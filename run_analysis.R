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
#X_names <- c("./UCI HAR Dataset/test/X_test.txt","./UCI HAR Dataset/train/X_train.txt")
X_names <- dir("./UCI HAR Dataset",pattern="^[Xx].*\\.txt",full.names=TRUE,recursive=TRUE)
#Y_names <- c("./UCI HAR Dataset/test/Y_test.txt","./UCI HAR Dataset/train/Y_train.txt")
Y_names <- dir("./UCI HAR Dataset",pattern="^[Yy].*\\.txt",full.names=TRUE,recursive=TRUE)

# create single feature list for Y data set
Y_features <- c('activityid')

activity_names <- c('./UCI HAR Dataset/activity_labels.txt')
activity_features <- c('activityid','activity')

#subject_names <- c("./UCI HAR Dataset/test/subject_test.txt","./UCI HAR Dataset/train/subject_train.txt")
subject_names <- dir("./UCI HAR Dataset",pattern="^(subject).*\\.txt",full.names=TRUE,recursive=TRUE)
subject_features <- c('subjectid')

body_acc_x_names <- dir("./UCI HAR Dataset",pattern="^(body_acc_x).*\\.txt",full.names=TRUE,recursive=TRUE)
body_acc_y_names <- dir("./UCI HAR Dataset",pattern="^(body_acc_y).*\\.txt",full.names=TRUE,recursive=TRUE)
body_acc_z_names <- dir("./UCI HAR Dataset",pattern="^(body_acc_z).*\\.txt",full.names=TRUE,recursive=TRUE)

body_gyro_x_names <- dir("./UCI HAR Dataset",pattern="^(body_gyro_x).*\\.txt",full.names=TRUE,recursive=TRUE)
body_gyro_y_names <- dir("./UCI HAR Dataset",pattern="^(body_gyro_y).*\\.txt",full.names=TRUE,recursive=TRUE)
body_gyro_z_names <- dir("./UCI HAR Dataset",pattern="^(body_gyro_z).*\\.txt",full.names=TRUE,recursive=TRUE)

total_acc_x_names <- dir("./UCI HAR Dataset",pattern="^(total_acc_x).*\\.txt",full.names=TRUE,recursive=TRUE)
total_acc_y_names <- dir("./UCI HAR Dataset",pattern="^(total_acc_y).*\\.txt",full.names=TRUE,recursive=TRUE)
total_acc_z_names <- dir("./UCI HAR Dataset",pattern="^(total_acc_z).*\\.txt",full.names=TRUE,recursive=TRUE)


# function to load a fileName into a dataframe and attach features
loadDataSet <- function(fileName, features, name_prefix="") {

    # set sep to "" to mean any number of whitespace
    df <- read.delim(fileName,header=FALSE,sep="")
    
    # assign feature list - make unique and add name_prefix
    names(df) = make.names(paste0(name_prefix,features),unique=TRUE)
    
    # create additional feature to store filename
    df[[paste0(name_prefix,"sourceFileName")]] <- fileName
    # tag rows with 'test' in them with (name_prefix)DataGroup='test', 
    #else 'train' else NA
    df[[paste0(name_prefix,"DataGroup")]] <- 
        ifelse(grepl('test', fileName),'test',
        ifelse(grepl('train',fileName),'train',NA))
    # tidy up names - remove .. and ... and trim from the end of names
    names(df) <- gsub("[\\.][\\.]*","\\.",names(df))
    names(df) <- gsub("[\\.][\\.]*$","",names(df))
    df
}

# use rbind/lapply to load X and Y datasets from multiple files into X and Y respectively
X <- do.call(rbind,lapply(X=X_names,FUN=loadDataSet,features=X_features[,2]))
Y <- do.call(rbind,lapply(X=Y_names,FUN=loadDataSet,features=Y_features))

# load subjects
subject <- do.call(rbind,lapply(X=subject_names,FUN=loadDataSet,features=subject_features))
# load activity labels
activity_labels <- do.call(rbind,lapply(X=activity_names,FUN=loadDataSet,features=activity_features))

# combine Y with activity labels
activity <- merge(x=Y,y=activity_labels,by="activityid",all=TRUE)

# load inertial signals
# TODO convert code to use list with cbind
body_acc_x <- do.call(rbind,lapply(X=body_acc_x_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_x_"))
body_acc_y <- do.call(rbind,lapply(X=body_acc_y_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_y_"))
body_acc_z <- do.call(rbind,lapply(X=body_acc_z_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_z_"))

body_gyro_x <- do.call(rbind,lapply(X=body_gyro_x_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_x_"))
body_gyro_y <- do.call(rbind,lapply(X=body_gyro_y_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_y_"))
body_gyro_z <- do.call(rbind,lapply(X=body_gyro_z_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_z_"))

total_acc_x <- do.call(rbind,lapply(X=total_acc_x_names,FUN=loadDataSet,features=1:128,name_prefix="total_acc_x_"))
total_acc_y <- do.call(rbind,lapply(X=total_acc_y_names,FUN=loadDataSet,features=1:128,name_prefix="total_acc_y_"))
total_acc_z <- do.call(rbind,lapply(X=total_acc_z_names,FUN=loadDataSet,features=1:128,name_prefix="total_acc_z_"))

# combine all inertial signals into single data frame
inertial_signals <- cbind(body_acc_x,body_acc_y,body_acc_z,
                          body_gyro_x,body_gyro_y,body_gyro_z,
                          total_acc_x,total_acc_y,total_acc_z)
names(inertial_signals) = c(names(body_acc_x),names(body_acc_y),
                            names(body_acc_z),names(body_gyro_x),
                            names(body_gyro_y),names(body_gyro_z),
                            names(total_acc_x),names(total_acc_y),
                            names(total_acc_z))

# add subjectid to X and activity
ds_names <- c(names(subject)[1],names(X),c("activityid","activity"))
ds <- cbind(subject[,1],X,activity[,c("activityid","activity")])

names(ds) <- ds_names

# add inertial signals vectors
ds <- cbind(ds,inertial_signals)
names(ds) <- c(ds_names,names(inertial_signals))


# create output data frame
# group by subjectid,activity and average (summarise) all
# standard deviation (std) or mean calculations 
# (lower case 'mean.' or mean$)
# 
output <- select(ds,subjectid,activity,
                 matches("((std)|(mean))([\\.]|$)",ignore.case=FALSE)) %>% 
    dplyr::group_by(subjectid,activity)  %>% dplyr::summarise_each(funs(mean))
    

#%>% filter(complete.cases(.)) 
   
write.csv(output,"./output.csv",row.names=FALSE)
