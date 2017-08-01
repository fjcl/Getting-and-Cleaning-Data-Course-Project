#
# Getting and Cleaning Data Course Project
#
# Created: 01-08-2017
# Author: Francisco Javier Carrasco Lopez
#

## 1. Download and unzip the dataset:
zipFile <- "UCI_HAR.zip"
dataFile <- "UCI HAR Dataset"
if (!file.exists(zipFile)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, zipFile, method="curl")
}  
if (!file.exists(dataFile))
        unzip(zipFile)

# 2. Merge train and test dataset
train <- cbind(read.table("UCI HAR Dataset/train/Y_train.txt"),
               read.table("UCI HAR Dataset/train/subject_train.txt"),
               read.table("UCI HAR Dataset/train/X_train.txt"))
test <- cbind(read.table("UCI HAR Dataset/test/Y_test.txt"),
              read.table("UCI HAR Dataset/test/subject_test.txt"),
              read.table("UCI HAR Dataset/test/X_test.txt"))
fullData <- rbind(train, test)
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
colnames(fullData) <- c("activity", "subject", features[,2])

# 3. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_features <- grep(".*mean.*|.*std.*", features[,2])
extractedCols = c(1, 2, 2+mean_std_features)
extractedData <- fullData[extractedCols]

# 4. Name activities with descriptive activity names
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
fullData$activity <- factor(fullData$activity, levels = activityLabels[,1], labels = activityLabels[,2])

# 5. Label data with descriptive variable names
featureNames = features[mean_std_features,2]
featureNames = gsub('-mean', '.Mean', featureNames)
featureNames = gsub('-std', '.Std', featureNames)
featureNames <- gsub('[()]', '', featureNames)
featureNames <- gsub('-', '.', featureNames)
colnames(extractedData) <- c("activity", "subject", featureNames)

# 6. Create tidy dataset with average of each variable per subject and activity
tidyData <- melt(extractedData, id = c("activity", "subject"))
tidyData <- dcast(tidyData, activity + subject ~ variable, mean)
write.table(tidyData, "tidy.csv", row.names = FALSE, quote = FALSE, sep=";")
