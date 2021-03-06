## This script prepares data collected from Galaxy S smartphones.
## It createses two data.frame objects: df and aggdf.
## df contains all training and test data from the dataset, 
##   and its columns contain all mean() and std() measurments for x,
##   as well as outputs y (with descriptive labels),
##   and each subject's id number.
##
## aggdf sumamrizes the data in df by grouping by subject and activity, returning
##  the mean of each measurement

## Download the data, unzip it, and set working directory to the extracted folder
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','smartphone.zip','curl')
DateDownloaded <- Sys.Date()
unzip('smartphone.zip')
setwd('./UCI HAR Dataset')

## Read in all the necessary data
feature_names <- as.character(read.table('features.txt')[[2]])
xtrain <- read.table('train/X_train.txt', col.names = feature_names, check.names=FALSE)
ytrain <- read.table('train/y_train.txt', col.names = c('activity_code'))
subject_train <- read.table('train/subject_train.txt', col.names = c('subject_id'))
xtest <- read.table('test/X_test.txt', col.names = feature_names, check.names=FALSE)
ytest <- read.table('test/y_test.txt', col.names = c('activity_code'))
subject_test <- read.table('test/subject_test.txt', col.names = c('subject_id'))
activity_labels <- read.table('activity_labels.txt', col.names = c('activity_code','activity'))

## Combine the data into a useful dataframe
x <- rbind(xtrain, xtest)
x <- x[,names(x)[grep("mean\\(\\)|std\\(\\)",names(x))]]  #keep only mean() or std() measurements
y <- rbind(ytrain, ytest)
subjects <- rbind(subject_train, subject_test)
df <- cbind(subjects, x, y)
## Convert activity_code into descriptive activity found in activity_labels
df <- merge(df, activity_labels, by='activity_code')

## Create independent data.frame with average measurements grouped by subject and activity
aggdf <- aggregate(df, by=list(df$subject_id, df$activity), FUN="mean")
#drop original activity column (NAs after attempting to take their average)
#and drop Group.1 column (equivalent to subject_id)
aggdf <- aggdf[,c(2,4:(length(aggdf)-1))]
#rename Group1 to subject_id, and Group2 to activity
names(aggdf)[1] <- c('activity')
