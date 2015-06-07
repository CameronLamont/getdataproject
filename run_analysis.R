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

X_features <- read.delim("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ")

X_names <- c("./UCI HAR Dataset/test/X_test.txt","./UCI HAR Dataset/train/X_train.txt")

Y_names <- c("./UCI HAR Dataset/test/Y_test.txt","./UCI HAR Dataset/train/Y_train.txt")
Y_features <- c('Y')

loadDataSet <- function(fileName, features) {
    
    rawFile <- readLines(fileName)
    rawFile <- gsub("[ ][ ]*"," ", rawFile)
    
    rawFile <- str_trim(rawFile)
    
    df <- read.delim(textConnection(rawFile),header=FALSE,sep=" ")
    
    names(df) = features
    df$sourceFileName <- fileName
    df
}


X <- do.call(rbind,lapply(X=X_names,FUN=loadDataSet,features=X_features[,2]))
Y <- do.call(rbind,lapply(X=Y_names,FUN=loadDataSet,features=Y_features))

X <- do.call(rbind,lapply(X_names,function(fileName){ rawFile <- readLines(fileName)
                                 rawFile <- gsub("[ ][ ]*"," ", rawFile)
                                 
                                 rawFile <- str_trim(rawFile)
                                 
                                 df <- read.delim(textConnection(rawFile),header=FALSE,sep=" ")
                                 
                                 names(df) = X_features[,2]
                                 df$sourceFileName <- fileName
                                 df}))
X$DataGroup <- ifelse('test' %in% X$sourceFileName,'test','training')

Y <- do.call(rbind,lapply(Y_names,function(fileName){ rawFile <- readLines(fileName)
                                                      rawFile <- gsub("[ ][ ]*"," ", rawFile)
                                                      
                                                      rawFile <- str_trim(rawFile)
                                                      
                                                      df <- read.delim(textConnection(rawFile),header=FALSE,sep=" ")
                                                      
                                                      names(df) = c('Y')
                                                      df$sourceFileName <- fileName
                                                      df}))
Y$DataGroup <- ifelse('test' %in% Y$sourceFileName,'test','training')

