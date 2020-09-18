# Download data
setwd("~/Desktop/R/Coursera/3_Getting&Cleaning_Data/Assignment")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "rawdata.zip"
if (!file.exists(destFile)){
    download.file(fileUrl, destfile = destFile, method = "curl")
}
if (!file.exists("./UCI HAR Dataset")){
    unzip(destFile)
}
setwd("./UCI HAR Dataset")

# Combining train and test
library(data.table)
library(plyr)

### which subject is measured
trainsubject <- read.table("./train/subject_train.txt", header = FALSE)
testsubject <- read.table("./test/subject_test.txt", header = FALSE)
subject <- rbind(trainsubject, testsubject)

### which activity is monitered
trainlabel <- read.table("./train/y_train.txt", header = FALSE)
testlabel <- read.table("./test/y_test.txt", header = FALSE)
label <- rbind(trainlabel, testlabel)

### the features that are measured for each subject for each activity
trainset <- read.table("./train/X_train.txt", header = FALSE)
testset <- read.table("./test/X_test.txt", header = FALSE)
featureValues <- rbind(trainset, testset)

### activities that correspond to labels 1-6
activitylabels <- read.table("activity_labels.txt", header = FALSE)

### labels for which feature is monitored
featurenames <- read.table("features.txt", header = FALSE)

# Preparing for data merging -- editing column names

### processing acitvity labels
names(label) <- "ActivityNumber"
names(activitylabels) <- c("ActivityNumber", "ActivityName")
activityMonitored <- as.data.frame(join(label, activitylabels)[ ,2])

### processing column name
names(subject) <- "Subject"
names(activityMonitored) <- "Activity"

# Extraction and more descriptions

### extract and change feature names to be more descriptive
featureList <- as.vector(featurenames[ ,2])
positions <- grep("mean\\(\\)|std\\(\\)", featureList)
featureUseful <- featureValues[ ,positions]
names(featureUseful) <- featureList[positions]
names(featureUseful) <- gsub("^t", "time", names(featureUseful))
names(featureUseful) <- gsub("^f", "frequency", names(featureUseful))
names(featureUseful) <- gsub("BodyBody", "Body", names(featureUseful))
names(featureUseful) <- gsub("Acc", "Accelerometer", names(featureUseful))
names(featureUseful) <- gsub("Mag", "Magnitude", names(featureUseful))
names(featureUseful) <- gsub("Gyro", "Gyroscope", names(featureUseful))

### merging the data
wholeData <- cbind(subject, activityMonitored)
wholeData <- cbind(wholeData, featureUseful)

# Creating a new data set and get average
newData <- aggregate(. ~ Subject + Activity, wholeData, mean)
dim(newData)
write.table(newData, file = "tidyData.txt", row.names = FALSE)





