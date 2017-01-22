## Coursera Getting and Cleaning Data
## Week 4 Project
## January 22, 2017

###Terry M. Atkison

This is my Repo for the submission of the course project for the Johns Hopkins Getting and Cleaning Data course.

### Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Script Notes 

This script will check for the existence of a 'data' directory, and if it doesn't exist it will make one for you.  It will then download the source zipfile and unzip it to that data directory.

There is no need to make modifications to the script unless you already have the data files downloaded and unzipped to your own preferred data directory.  The script will take care of the preparation of the data files itself.  All directory locations are relative to your own working directory so it should work no matter your working directory structure.

### Project Summary
The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## What you'll find in this repository

* __CodeBook.md__: information about raw and tidy data set and guidelines on how this script modifies the original data
* __README.md__: this file
* __run_analysis.R__: R script to transform the given data set in a tidy one
* __tidyData.txt__: The tidy data set created by this script