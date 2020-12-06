# Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project

Codebook that indicates all the variables and summaries calculated, along with units, and any other relevant information.

# Description of variables:

- X_train <- UCI HAR Dataset/train/X_train.txt
- Y_train <- UCI HAR Dataset/train/y_train.txt
- subject_train <- UCI HAR Dataset/train/subject_train.txt
- X_test <- UCI HAR Dataset/test/X_test.txt
- Y_test <- UCI HAR Dataset/test/y_test.txt
- subject_test <- UCI HAR Dataset/test/subject_test.txt
- features <- UCI HAR Dataset/features.txt
- activity_labels <- UCI HAR Dataset/activity_labels.txt

# Description of creates datasets:

- train <- merged dataset of all train related variables
- test <- merged datset of all test related variables
- data_all <- merges data set of all variables from train and test

- data_mean_std <- dataset with only the measurements on the mean and standard deviation for each measurement
- data_mean_std_labeled <- dataset with descriptive activity names to name the activities
- data_tidy <- second, independent tidy data set with the average of each variable for each activity and each subject
