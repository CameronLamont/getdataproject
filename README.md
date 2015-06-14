---
title: "Readme - Getting and Cleaning Data Course Project (getdataproject)"
output: html_document
---
Cameron Lamont

Getting and Cleaning Data Course Project
https://github.com/CameronLamont/getdataproject

## Introduction

Tidy and Summarisation of Human Activity Recognition Using Smartphones Data Set

Project URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data supporting project can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###R Program comprised of:
* README.md
    This file containing installation and usage instructions
* Main R Script - run_analysis.R
    Main script to perform analysis on input data
* Code Book - CodeBook.md
    Additional description of output data file and transformations

##Usage Instructions

1. Start up R or RStudio and set the working directory to the location where run_analysis.R is located using 
    ```{r}
    setwd("path/to/run_activity.R")
    ```
   
2.  Download and unzip the project data to the same location
    
    ```{r}
    download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "./getdata-projectfiles-UCI HAR Dataset.zip")
    unzip("./getdata-projectfiles-UCI HAR Dataset.zip")
    ```
    run_actity.R Assumes that Samsung Project data has been downloaded and unzipped into the 
    working directory "./UCI HAR Dataset" unzipping to the working directory will create the directory structure.
    On some operating systems curl mode may be required in download.file
3.  Execute the script using RStudio 'Run Source' or using the following `source("./run_analysis.R")`
4.  Script will output several messages describing its activity, should no
    errors are encountered single output file will be created in 
    `./output[%Y%m%d_%H%M].txt` (based on timestamp of execution)

## Main R Script - run_analysis.R

Single monolithic script with single function definition used for loading files.

### Performs the following:

 1. Merges the training and the test sets to create one data set.
   * loads X, Y, subject data sets from training and test sets
   * in-addition loads inertia signals from training and test sets
   * features for X an Y features.txt and activity_labels.txt referenced
 2. Extracts only the measurements on the mean and standard deviation for each 
   measurement. 
    * all measurements are read in initially - mean and standard deviation 
   features are outputted
 3. Uses descriptive activity names to name the activities in the data set
   * Y data sets have been substituted with the Activity label
 4. Appropriately labels the data set with descriptive variable names. 
   * X data sets are named based on the features.txt file; 
        names have been made more descriptive
   * Subjects are loaded as subjectid
 5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject.
   * last step exports to `paste0("./output", format(Sys.time(),"%Y%m%d_%H%M"),".txt")`
   * file named for timestamp of execution time

### R Libraries required

    The following libraries will be loaded by the script as it runs.
    
        ```{r}
        library(stringr)
        library(dplyr)
        ```

## Output File - output%Y%m%d_%H%M.txt

    Output file containing average of each mean and standard deviation variable 
    found in the source for each activity and each subject - created using 
    write.table() using row.name=FALSE (space delimetered .txt file).
    
        
        `write.table(ds,paste0("./output", format(Sys.time(),"%Y%m%d_%H%M"),".txt"),row.name=FALSE)`
        

    Typical output is 30 rows - one per subject - 68 columns.  Description of the 
    file and transformation can be found in the Code Book

## CodeBook.md - Codebook description

The Code Book describes the variables, the data, transformations and 
work performed to clean up the data.  It contains a table of output columns 
with descriptions.
