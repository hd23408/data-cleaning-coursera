
# This script will retrieve the data provided for
# the Getting and Cleaning Data Course Project, and
# unzip it into the current directory. Be sure to setwd()
# to something useful before running it!

# Retrieve the data zip file into the current working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "smartphone_data.zip", "curl")

# Unzip the file
unzip("smartphone_data.zip")

