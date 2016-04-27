# This script will clean data retrieved as part of the 
# "Getting and Cleaning Data" course project. It assumes
# that the current working directory contains an unzipped
# copy of the referenced dataset, in a subdirectory called
# "UCI HAR Dataset". Please see the script "download_data.R" 
# for the process of downloading and unzipping the data.
#
# This script will perform the following actions on the
# downloaded data, as per the course project instructions:
#
# 1) Merge the training and the test sets to create one data set
# 2) Extract only the measurements on the mean and standard 
#    deviation for each measurement
# 3) Use descriptive activity names to name the activities in the data set
# 4) Appropriately label the data set with descriptive variable names
# 5) From the data set in step 4, create a second, independent 
#    tidy data set with the average of each variable for each 
#    activity and each subject
#
#
# Some quick reference:
#    "features.txt" contains the column names for the measurements
#    "test/X_test.txt" and "train/X_train.txt" contain the actual measurements
#
#    "activity_labels.txt" contains the names of the activities
#    "test/y_test.txt" and "train/y_train.txt" contain the IDs of the
#     activity that corresponds to each measurement
#
#    "test/subject_test.txt" and "train/subject_train.txt" contain the ID 
#     numbers of the subject that corresponds to each measurement
#    (a given subject only shows up in one of "train" or "test")
#
#    "Inertial Signals" can be ignored for the purposes of this exercise
#    (I think).
#

##########
# Setup
##########

# We’ll be using the dplyr library, cuz it’s awesome.
library(dplyr)

# Navigate into the "UCI HAR Dataset" directory
setwd("UCI\ HAR\ Dataset")

##########
# Step 1
# Merges the training and the test sets to create one data set.
##########

# Load in "train/X_train.txt", "train/y_train.txt", and "train/subject_train.txt"
# and align their values into a single dataframe, using the labels from "features.txt"
# to assign column names

# Create a vector of the column names, based on the info in "features.txt"
features <- read.table("features.txt")
cols <- as.vector(features[,2])

# Read in the various files with data
training_data <- read.table("train/X_train.txt", col.names = cols)
training_subjects <- read.table("train/subject_train.txt", col.names = c("subject.id"))
training_activities <- read.table("train/y_train.txt", col.names = c("activity.id"))

# Combine them all together
training_all <- cbind(training_subjects, training_activities, training_data)

# Free up the temporary variables
rm(training_activities,training_data,training_subjects,features)

# Do the same for the "test" datasets

# Read in the various files with data
testing_data <- read.table("test/X_test.txt", col.names = cols)
testing_subjects <- read.table("test/subject_test.txt", col.names = c("subject.id"))
testing_activities <- read.table("test/y_test.txt", col.names = c("activity.id"))

# Combine them all together
testing_all <- cbind(testing_subjects, testing_activities, testing_data)

# Free up the temporary variables
rm(testing_subjects, testing_activities, testing_data)

# Combine these two dataframes and clean up
all_measurements <- rbind(testing_all, training_all)
rm(testing_all, training_all)

##########
# Step 2
# Extracts only the measurements on the mean and standard deviation for each measurement.
##########

# Keep only the activity ID, subject ID, and "mean" or "std" columns from the main
# dataframe. (Note: Instructions are unclear (IMHO) about whether or not
# the "gyro", "AccMag", etc. mean/std measurements should be kept, so I opted
# to keep them too.)
trimmed_measurements <- select(all_measurements, matches("subject.id"), matches("activity.id"), matches(".mean."), matches(".std."))

# Clean up
rm(all_measurements, cols)

##########
# Step 3
# Uses descriptive activity names to name the activities in the data set
##########

# Read in the activity labels (from "activity_labels.txt"), and
# merge with the main dataframe to replace activity IDs with labels
activity_labels <- read.table("activity_labels.txt", col.names = c("activity.id", "activity.name"))
labeled_measurements <- merge(activity_labels, trimmed_measurements)
rm(trimmed_measurements, activity_labels)

##########
# Step 4
# Appropriately labels the data set with descriptive variable names.
##########

# We actually already accomplished this as part of Step 1, just to make
# the data easier to work with, so we can skip this step at this point.

##########
# Step 5
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
##########

# Grouping by subject + activity, calculate means for each of the other columns
summarized_measurements <- summarize_each(group_by(labeled_measurements, activity.name, subject.id), funs(mean))

# And write out the dataset
write.table(summarized_measurements, file="summarized_measurements.txt", row.names = FALSE)
