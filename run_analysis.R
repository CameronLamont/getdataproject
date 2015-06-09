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

filepath = "./UCI HAR Dataset"
print(paste(Sys.time(),"***Assuming Data Files Located in ",filepath))

# read in X data set feature list
X_features <- read.delim(file.path(filepath,"features.txt"),header=FALSE,sep=" ")
# convert lowercase t prefixed columns to TimeDomainSignal
X_features[,2] <- gsub("^t","TimeDomainSignal.",X_features[,2])
# convert lowercase f prefixed columns to FrequencyDomainSignal
X_features[,2] <- gsub("^f","FrequencyDomainSignal.",X_features[,2])

# setup input files for X and Y data sets 
X_names <- dir(filepath,pattern="^[Xx].*\\.txt",full.names=TRUE,recursive=TRUE)
Y_names <- dir(filepath,pattern="^[Yy].*\\.txt",full.names=TRUE,recursive=TRUE)

# create single feature list for Y data set
Y_features <- c('activityid')

activity_names <- c(file.path(filepath,"activity_labels.txt"))
activity_features <- c('activityid','activity')

subject_names <- dir(filepath,pattern="^(subject).*\\.txt",full.names=TRUE,recursive=TRUE)
subject_features <- c('subjectid')

body_acc_x_names <- dir(filepath,pattern="^(body_acc_x).*\\.txt",full.names=TRUE,recursive=TRUE)
body_acc_y_names <- dir(filepath,pattern="^(body_acc_y).*\\.txt",full.names=TRUE,recursive=TRUE)
body_acc_z_names <- dir(filepath,pattern="^(body_acc_z).*\\.txt",full.names=TRUE,recursive=TRUE)

body_gyro_x_names <- dir(filepath,pattern="^(body_gyro_x).*\\.txt",full.names=TRUE,recursive=TRUE)
body_gyro_y_names <- dir(filepath,pattern="^(body_gyro_y).*\\.txt",full.names=TRUE,recursive=TRUE)
body_gyro_z_names <- dir(filepath,pattern="^(body_gyro_z).*\\.txt",full.names=TRUE,recursive=TRUE)

total_acc_x_names <- dir(filepath,pattern="^(total_acc_x).*\\.txt",full.names=TRUE,recursive=TRUE)
total_acc_y_names <- dir(filepath,pattern="^(total_acc_y).*\\.txt",full.names=TRUE,recursive=TRUE)
total_acc_z_names <- dir(filepath,pattern="^(total_acc_z).*\\.txt",full.names=TRUE,recursive=TRUE)


# function to load a fileName into a dataframe and attach features
loadDataSet <- function(fileName, features, name_prefix="") {

    print(paste(Sys.time(),"Starting read of",fileName))
    # set sep to "" to mean any number of whitespace
    df <- read.delim(fileName,header=FALSE,sep="")
    
    print(paste(Sys.time(),nrow(df),"Rows",ncol(df),"Cols read from",fileName))
    
    print(paste(Sys.time(),"Setting Feature Names",fileName,name_prefix))
    # assign feature list - make unique and add name_prefix
    names(df) = make.names(paste0(name_prefix,features),unique=TRUE)
    
    print(paste(Sys.time(),"Adding sourceFileName and DataGroup variables",fileName))
    # create additional feature to store filename
    df[[paste0(name_prefix,"sourceFileName")]] <- fileName
    # tag rows with 'test' in them with (name_prefix)DataGroup='test', 
    #else 'train' else NA
    df[[paste0(name_prefix,"DataGroup")]] <- 
        ifelse(grepl('test', fileName),'test',
        ifelse(grepl('train',fileName),'train',NA))
    
    print(paste(Sys.time(),"Tidying Feature Names",fileName))
    # tidy up names - remove .. and ... and trim from the end of names
    names(df) <- gsub("[\\.][\\.]*","\\.",names(df))
    names(df) <- gsub("[\\.][\\.]*$","",names(df))
    print(paste(Sys.time(),"Completed read of ",fileName))
    df
}
print(paste(Sys.time(),"Reading X Data Sets",X_names))
# use rbind/lapply to load X and Y datasets from multiple files into X and Y respectively
X <- do.call(rbind,lapply(X=X_names,FUN=loadDataSet,features=X_features[,2]))

print(paste(Sys.time(),"Reading Y Data Sets",Y_names))
Y <- do.call(rbind,lapply(X=Y_names,FUN=loadDataSet,features=Y_features))

print(paste(Sys.time(),"Reading Subjects",subject_names))
# load subjects
subject <- do.call(rbind,lapply(X=subject_names,FUN=loadDataSet,features=subject_features))

print(paste(Sys.time(),"Reading Activity Labels",activity_names))
# load activity labels
activity_labels <- do.call(rbind,lapply(X=activity_names,FUN=loadDataSet,features=activity_features))

print(paste(Sys.time(),"Merging Activity Data Frame"))
# combine Y with activity labels
activity <- merge(x=Y,y=activity_labels,by="activityid",all=TRUE)

print(paste(Sys.time(),"Reading Inertial Signals"))
# load inertial signals
# TODO convert code to use list with cbind
print(paste(Sys.time(),"Reading Body Acceleration X",body_acc_x_names))
body_acc_x <- do.call(rbind,lapply(X=body_acc_x_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_x_"))
print(paste(Sys.time(),"Reading Body Acceleration Y",body_acc_y_names))
body_acc_y <- do.call(rbind,lapply(X=body_acc_y_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_y_"))
print(paste(Sys.time(),"Reading Body Acceleration Z",body_acc_z_names))
body_acc_z <- do.call(rbind,lapply(X=body_acc_z_names,FUN=loadDataSet,features=1:128,name_prefix="body_acc_z_"))

print(paste(Sys.time(),"Reading Body Gyroscope X",body_gyro_x_names))
body_gyro_x <- do.call(rbind,lapply(X=body_gyro_x_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_x_"))
print(paste(Sys.time(),"Reading Body Gyroscope Y",body_gyro_y_names))
body_gyro_y <- do.call(rbind,lapply(X=body_gyro_y_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_y_"))
print(paste(Sys.time(),"Reading Body Gyroscope Z",body_gyro_z_names))
body_gyro_z <- do.call(rbind,lapply(X=body_gyro_z_names,FUN=loadDataSet,features=1:128,name_prefix="body_gyro_z_"))

print(paste(Sys.time(),"Reading Total Acceleration X",total_acc_x_names))
total_acc_x <- do.call(rbind,lapply(X=total_acc_x_names,FUN=loadDataSet,features=1:128,name_prefix="total_acc_x_"))
print(paste(Sys.time(),"Reading Total Acceleration Y",total_acc_y_names))
total_acc_y <- do.call(rbind,lapply(X=total_acc_y_names,FUN=loadDataSet,features=1:128,name_prefix="total_acc_y_"))
print(paste(Sys.time(),"Reading Total Acceleration Z",total_acc_z_names))
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

print(paste(Sys.time(),"Merging Data Starting Subject + X + Activity + Inertial Signals"))
# add subjectid to X and activity
ds_names <- c(names(subject)[1],names(X),c("activityid","activity"))
ds <- cbind(subject[,1],X,activity[,c("activityid","activity")])

names(ds) <- ds_names

# add inertial signals vectors
ds <- cbind(ds,inertial_signals)
names(ds) <- c(ds_names,names(inertial_signals))

print(paste(Sys.time(),"Merging Complete",nrow(ds),"rows",ncol(ds),"cols"))

print(paste(Sys.time(),"Creating Output Data Set", "averaging fields matching ((std)|(mean))([\\.]|$)"))
# create output data frame
# group by subjectid,activity and average (summarise) all
# standard deviation (std) or mean calculations 
# (lower case 'mean.' or mean$ - does not include angle vectors e.g. gravityMean)
# 
output <- select(ds,subjectid,activity,
                 matches("((std)|(mean))([\\.]|$)",ignore.case=FALSE)) %>% 
    dplyr::group_by(subjectid,activity)  %>% dplyr::summarise_each(funs(mean))

print(paste(Sys.time(),"Output Data Set Created",nrow(ds),"rows",ncol(ds),"cols"))    

outputFileName = paste0("./output", format(Sys.time(),"%Y%m%d_%H%M"),".txt")
print(paste(Sys.time(),"Writing Output File",outputFileName))
# output txt 'output<Sys.time>.txt'
write.table(output,outputFileName,row.names=FALSE)
print(paste(Sys.time(),"Done"))

# library(knitr)
# kable(names(ds), format="markdown",col.names=c("column name"))
# kable(names(output), format="markdown",col.names=c("column name"))

