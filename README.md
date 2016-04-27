# data-cleaning-coursera
Human Activity Recognition Data Cleanup project for data-cleaning course

This project is the course project submission for the "Getting and Cleaning Data"
course project from Johns Hopkins University, on coursera.org.

There are two scripts in this repository: "download_data.R", which will 
download the needed data from the URL referenced in the instructions for the
course project, and "run_analysis.R", which will run the data cleanup steps
described in the instructions and produce a tidy, summarized data file.

# Additional details

The "run_analysis.R" script will clean data retrieved as part of the 
"Getting and Cleaning Data" course project. It assumes
that the current working directory contains an unzipped
copy of the referenced dataset, in a subdirectory called
"UCI HAR Dataset". Please see the script "download_data.R" 
for the process of downloading and unzipping the data.

Note that the current working directory, in which the "run_analysis.R"
script is being run, must contain the full "UCI HAR Dataset" directory.
Do not attempt to run this script from within the "UCI HAR Dataset"
directory itself.

The "run_analysis.R" script will perform the following actions on the
downloaded data, as per the course project instructions:

1) Merge the training and the test sets to create one data set
2) Extract only the measurements on the mean and standard 
deviation for each measurement
3) Use descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names
5) From the data set in step 4, create a second, independent 
tidy data set with the average of each variable for each 
activity and each subject

An output file called "summarized_measurements.txt" will be written out into the "UCI HAR Dataset"
directory.
