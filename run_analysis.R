# Getting and Cleaning Data Course Project

# You should create one R script called run_analysis.R that does the following. 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

library(stringr)
library(dplyr)

# read in X data set feature list
X_features <- read.delim("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ")

# setup input files for X and Y data sets 
X_names <- c("./UCI HAR Dataset/test/X_test.txt","./UCI HAR Dataset/train/X_train.txt")

Y_names <- c("./UCI HAR Dataset/test/Y_test.txt","./UCI HAR Dataset/train/Y_train.txt")

# create single feature list for Y data set
Y_features <- c('Y')

subject_names <- c("./UCI HAR Dataset/test/subject_test.txt","./UCI HAR Dataset/train/subject_train.txt")
subject_features <- c('subjectid')

# function to load a fileName into a dataframe and attach features
loadDataSet <- function(fileName, features) {
    
    # TODO - speed up as this is quite slow and 
    # a dplyr method wasn't working out
    
    # using readLines with 
    rawFile <- readLines(fileName)
    # gsub to swap multiple spaces for single
    rawFile <- gsub("[ ][ ]*"," ", rawFile)
    # trim trailing whitespace
    rawFile <- str_trim(rawFile)
    
    # push raw file into read.delim via a textConnection
    df <- read.delim(textConnection(rawFile),header=FALSE,sep=" ")
    
    # assign feature list
    names(df) = features
    # create additional feature to store filename
    df$sourceFileName <- fileName
    df
}

# use rbind/lapply to load X and Y datasets from multiple files into X and Y respectively
X <- do.call(rbind,lapply(X=X_names,FUN=loadDataSet,features=X_features[,2]))
Y <- do.call(rbind,lapply(X=Y_names,FUN=loadDataSet,features=Y_features))
subject <- do.call(rbind,lapply(X=subject_names,FUN=loadDataSet,features=subject_features))

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
X$DataGroup <- ifelse('test' %in% X$sourceFileName,'test','training')

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
Y$DataGroup <- ifelse('test' %in% Y$sourceFileName,'test','training')

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
subject$DataGroup <- ifelse('test' %in% subject$sourceFileName,'test','training')

# add subjectid to X and Y
ds <- cbind(subject[,1],X,Y[,1])
names(ds)[1] <- names(subject)[1]
names(ds)[length(names(ds))] <- names(Y)[1]

measures <- c('mean','std')

# get all mean and std columns
match(names(ds),grep("(mean)|(std)",X_features$V2,value=TRUE))


