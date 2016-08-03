# GCD
Getting and Cleaning Data Project for Coursera

Overview
This repository hosts the R Script, Codebook and Readme files for the Getting Data and Cleaning Project on Coursera as part of the Johns Hopkins Data Science Specialization Course Track 

The data set used for this project is located at:   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  

For purposes of this project, files were downloaded from Coursera in a zipped folder and unzipped on a local directory.
About the repo files

This repository contains 3 files:

run_analysis.R – Contains the script to: read files; merge data into a master dataset; create a dataset with only the measurements on the mean and standard deviation for each measurement: apply descriptive activity labels; apply descriptive column names; and creates a tidy data set that produces a mean aggregated for each “subjectId” and “activityType”. 

CodeBook.md - Describes the variables, the data, and any transformations or work that was performed to clean up the data.

tidy.txt – The desired output of the project.  A tidy data set that produces a mean for each “subjectId” and “activityType”

Libraries Used:
Plyr
dplyr
