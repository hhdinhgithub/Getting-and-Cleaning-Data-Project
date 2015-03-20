#Getting and Cleaning Data Course Project 
###Mar 2015

##Project Description

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The requirement to have:

    *a tidy data set as described below
    *a link to a Github repository with your script for performing the analysis, and
    *a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

The data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##run_analysis.R that does the following.

    1) Merges the training and the test sets to create one data set.
    2) Extracts only the measurements on the mean and standard deviation for each measurement.
    3) Uses descriptive activity names to name the activities in the data set
    4) Appropriately labels the data set with descriptive activity names.
    5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##What you find in this repository

    *CodeBook.md: information about raw and tidy data set and elaboration made to transform them
    *README.md: this file
    *run_analysis.R: R script to transform raw data set in a tidy one
    *tidy_data.txt: Final tidy data set, It is output file after you run run_analysis.R	

##How to create the tidy data set

    1) Download compressed raw data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    2) unzip raw data and copy the directory "UCI HAR Dataset" under current working directory
    3) Open a RStudio console
    4) Source run_analisys.R script (it requires the plyr package): source("run_analysis.R")
    5) The tidy_data.txt file will create under current working dir

