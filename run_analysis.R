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
#library(data.table)

# read in X data set feature list
X_features <- read.delim("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ")

# setup input files for X and Y data sets 
X_names <- c("./UCI HAR Dataset/test/X_test.txt","./UCI HAR Dataset/train/X_train.txt")

Y_names <- c("./UCI HAR Dataset/test/Y_test.txt","./UCI HAR Dataset/train/Y_train.txt")

# create single feature list for Y data set
Y_features <- c('Y')

subject_names <- c("./UCI HAR Dataset/test/subject_test.txt","./UCI HAR Dataset/train/subject_train.txt")
subject_features <- c('subjectid')

activity_names <- c('./UCI HAR Dataset/activity_labels.txt')
activity_features <- c('activityid','activity')

# function to load a fileName into a dataframe and attach features
loadDataSet <- function(fileName, features) {

    # set sep to "" to mean any number of whitespace
    df <- read.delim(fileName,header=FALSE,sep="")
    
    # assign feature list - make unique
    names(df) = make.names(features,unique=TRUE)
    
    # create additional feature to store filename
    df$sourceFileName <- fileName
    df
}

# use rbind/lapply to load X and Y datasets from multiple files into X and Y respectively
X <- do.call(rbind,lapply(X=X_names,FUN=loadDataSet,features=X_features[,2]))
Y <- do.call(rbind,lapply(X=Y_names,FUN=loadDataSet,features=Y_features))
subject <- do.call(rbind,lapply(X=subject_names,FUN=loadDataSet,features=subject_features))

activity_labels <- do.call(rbind,lapply(X=activity_names,FUN=loadDataSet,features=activity_features))

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
X$DataGroup <- ifelse(grepl('test', X$sourceFileName),'test','training')

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
Y$DataGroup <- ifelse(grepl('test',Y$sourceFileName),'test','training')

# tag rows with 'test' in them with DataGroup=test, else assume 'training'
subject$DataGroup <- ifelse(grepl('test',subject$sourceFileName),'test','training')

# add subjectid to X and Y
ds <- cbind(subject[,1],X,Y[,1])
names(ds)[1] <- names(subject)[1]
names(ds)[length(names(ds))] <- names(Y)[1]

#measures <- c('mean','std')

# get all mean and std columns
#cols <- names(ds)[grepl("(subjectid)|(mean)|(std)|(DataGroup)",names(ds))]

#match(cols,names(ds))

#select(ds,(match(cols,names(ds))))


#ds %>% select(subjectid,contains("mean"),contains("std")) %>% 
#    dplyr::group_by(subjectid) %>% dplyr::summarize(contains("mean"),contains("std"))


body_acc_x_test <- read.delim("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",sep="")
body_acc_y_test <- read.delim("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",sep="")
body_acc_z_test <- read.delim("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",sep="")

body_acc_x_train <- read.delim("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",sep="")
body_acc_y_train <- read.delim("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",sep="")
body_acc_z_train <- read.delim("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",sep="")

