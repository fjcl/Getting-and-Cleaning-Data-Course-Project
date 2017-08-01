# Getting-and-Cleaning-Data-Course-Project

## Summary

The R script, `run_analysis.R`, process the Human Activity Recognition Using Smartphones Data Set as follows:

1. Downloads the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip if
   it does not already exist in the working directory.
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set.
5. Appropriately labels the data set with descriptive variable names.
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each
   activity and each subject.
7. Saves the result in file tidy.csv in CVS format.
