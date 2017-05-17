run_analysis <- function(){
        ## Coursera Data Science Specialization (Johns Hopkins University)
        ## Getting and Cleaning Data
        ## Course Project
        ## Ashley M. Kelly, May 2017
        ## This project to demonstrates my ability to collect, work with, and clean a data set.
        
        ###################################################################################################
        ## Merge the training and the test sets to create one data set.
        ###################################################################################################
        
        ## Download, unzip and store data
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/HARData.zip")
        unzip(zipfile="./data/HARData.zip",exdir="./data")
        
        ## Assign file tables to variables
        X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE)
        Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE)
        subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
        X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE)
        Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE)
        subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
        features <- read.table('./data/UCI HAR Dataset/features.txt', header=FALSE)
        activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt', header=FALSE)
        
        ## Arrange columns
        colnames(X_train) <- features[,2] 
        colnames(Y_train) <-"activityId"
        colnames(subject_train) <- "subjectId"
        colnames(X_test) <- features[,2] 
        colnames(Y_test) <- "activityId"
        colnames(subject_test) <- "subjectId"
        colnames(activity_labels) <- c('activityId','activityType')
        trainData <- cbind(Y_train, subject_train, X_train)
        
        ## Concatenate data into one large dataset
        testData <- cbind(Y_test, subject_test, X_test)
        AllData <- rbind(trainData, testData)
        
        ###################################################################################################
        ## Extract only the measurements on the mean and standard deviation for each measurement.
        ###################################################################################################
        
        ## Reading column names:
        colNames <- colnames(AllData)
        
        ## Create vector for defining ID, mean and standard deviation:
        mean_and_std <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
        )
        
        ## Create Data Table that consists of only the mean and stanard deviation
        setForMeanAndStd <- AllData[ , mean_and_std == TRUE]
        
        ###################################################################################################
        ## Use descriptive activity names to name the activities in the data set
        ## Appropriately label the data set with descriptive variable names.
        ###################################################################################################
        
        setWithActivityNames <- merge(setForMeanAndStd, activity_labels, by='activityId', all.x=TRUE)
        
        ###################################################################################################
        ## From the data set in step 4, create a second, independent tidy data set with the average
        ## each variable for each activity and each subject.
        ###################################################################################################

        ## Create final tidy data set
        secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
        secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
        
        ## Write to file
        write.table(secTidySet, "./data/tidySet.txt", row.name=FALSE)

}