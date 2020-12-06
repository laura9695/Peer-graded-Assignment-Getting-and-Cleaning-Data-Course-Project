############################################
# Peer-graded Assignment
############################################

library(dplyr)
library(tidyr)

if(!file.exists("./data")){dir.create("./data")}
#Here are the data for the project:
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

############################################
# You should create one R script called run_analysis.R that does the following:
############################################

############################################
# 1. Merges the training and the test sets to create one data set.
############################################

# Reading all the files in the training and test sets

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

features <- read.table('./data/UCI HAR Dataset/features.txt')

activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Add column names

colnames(X_train) <- features[,2]
colnames(Y_train) <-"activity_Id"
colnames(subject_train) <- "subject_Id"

colnames(X_test) <- features[,2] 
colnames(Y_test) <- "activity_Id"
colnames(subject_test) <- "subject_Id"

colnames(activity_labels) <- c('activity_Id','activity_Type')

# Merge the data sets

train <- cbind(Y_train, subject_train, X_train)
test <- cbind(Y_test, subject_test, X_test)
data_all <- rbind(train, test)

############################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
############################################

mean_std <- grepl("activity|subject|mean|std", colnames(data_all))

data_mean_std <- data_all[ , mean_std == TRUE]

############################################
# 3. Uses descriptive activity names to name the activities in the data set
############################################

data_mean_std_labeled <- merge(data_mean_std, activity_labels,
                              by='activity_Id',
                              all.x=TRUE)

############################################
# 4. Appropriately labels the data set with descriptive variable names.
############################################

colnames <- colnames(data_mean_std_labeled)
colnames <- gsub("-mean.+-", "Mean", colnames)
colnames <- gsub("-std.+-", "Std", colnames)
colnames <- gsub("f", "Frequency", colnames)
colnames <- gsub("^t", "Time", colnames)
colnames <- gsub("Mag", "Magnitude", colnames)
colnames <- gsub("Acc", "Accelerator", colnames)
colnames <- gsub("Gyro", "Gyroscope", colnames)
colnames(data_mean_std_labeled) <- colnames

############################################
# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
############################################

data_mean_std_labeled$subject_Id <- as.factor(data_mean_std_labeled$subject_Id)
data_mean_std_labeled$activity_Id <- as.factor(data_mean_std_labeled$activity_Id)
    
data_tidy <- aggregate(. ~subject_Id + activity_Id, data_mean_std_labeled, mean)
    
############################################
# Export data in txt file for submitting
############################################
    
write.table(data_tidy, "data_tidy.txt", row.name=FALSE)


