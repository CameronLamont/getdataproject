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

    #X_test <- readLines("./UCI HAR Dataset/test/X_test.txt")
    #X_test <- gsub("[ ][ ]*"," ", X_test)
    #X_test <- str_trim(X_test)
    #names(X_test_df) = X_features[,2]
    
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


#    
# loadDataSet(X_names[1],X_features[,2])


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

# # X_test <- read.delim("./UCI HAR Dataset/test/X_test.txt",header=FALSE) #,sep=" ")
# 
# Y_test <- read.delim("./UCI HAR Dataset/test/Y_test.txt",header=FALSE,sep=" ")
# subject_test <- read.delim("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep=" ")
# 
# X_train <- read.delim("./UCI HAR Dataset/train/X_train.txt",header=FALSE,sep=" ")
# Y_train <- read.delim("./UCI HAR Dataset/train/Y_train.txt",header=FALSE,sep=" ")
# subject_train <- read.delim("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep=" ")
# 
# 
# body_acc_x_test <- read.delim("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",header=FALSE,sep=" ")
# 
# # should be 128 element vector
# # sep needs to be "  " but read.delim insists on single byte
# total_acc_x_test <- read.delim("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",header=FALSE,sep=" ")
# 
# 
# activity_labels <- read.delim("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")
# 


# r <- X_test[1,]
# r_split <- strsplit(str_trim(as.character(r)),"[ ]+")
# 
# X_test[1,] %>% mutate(V1=str_trim(as.character(V1))) %>% separate(col=V1,sep="[ ][ ]*",into=features[,2],convert=TRUE) %>% print
# 
# X_test[1,]  %>% mutate(V1=str_trim(as.character(V1))) %>% separate(col=V1,into=features[,2]) %>% print
