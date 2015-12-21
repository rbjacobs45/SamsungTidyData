rm(list=ls()) # Cleanup
library(dplyr)
setwd("C:/Users/Ryan/Documents/Coursera/Getting and Cleaning Data/Course Project")

# Check to see whether the 'UCI HAR Dataset' directory exists
if(!file.exists("./UCI HAR Dataset")) {
        stop("The 'UCI HAR Dataset' directory cannot be found in your current path!")
}

# Load feature names vector and convert names to character
features <- read.table('./UCI HAR Dataset/features.txt')
features <- as.character(features[,2])

# Load test data files: "X_test.txt", "y_test.txt", and "subject_test.txt"
xTest <- read.table('./UCI HAR Dataset/test/X_test.txt', col.names = features)
yTest <- read.table('./UCI HAR Dataset/test/y_test.txt', col.names = 'activity_id')
subTest <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names = 'subject_id')

# Combine all test data in one data frame
testData <- cbind(subTest, yTest, xTest)

# Load training data files: "X_train.txt", "y_train.txt", and "subject_train.txt"
xTrain <- read.table('./UCI HAR Dataset/train/X_train.txt', col.names = features)
yTrain <- read.table('./UCI HAR Dataset/train/y_train.txt', col.names = 'activity_id')
subTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names = 'subject_id')

# Combine all training data in one data frame
trainData <- cbind(subTrain, yTrain, xTrain)

# Merge test data and training data into one data frame
data <- rbind(testData, trainData)

# Simplify names of the mean and standard deviation variables
names(data) <- gsub('.mean...', 'Mean', names(data), fixed = TRUE)
names(data) <- gsub('.std...', 'Sd', names(data), fixed = TRUE)
names(data) <- gsub('.mean..', 'Mean', names(data), fixed = TRUE)
names(data) <- gsub('.std..', 'Sd', names(data), fixed = TRUE)
names(data) <- gsub('Mean.', 'Mean', names(data), fixed = TRUE)
names(data) <- gsub('Meang', 'Mean.g', names(data), fixed = TRUE)

# Load activity labels file
actLabels <- read.table('./UCI HAR Dataset/activity_labels.txt')
actLabels <- as.character(actLabels[,2])

# Add a new variable to the data frame that has the activity labels instead of IDs
activity <- factor(data$activity_id, levels = 1:6, labels = actLabels)
data$activity_id <- activity
data <- rename(data, activity = activity_id)

# Extract only the features that are mean and standard deviations
tidyData1 <- select(data, subject_id:activity, 
                    contains('Mean', ignore.case = FALSE), 
                    contains('Sd', ignore.case = FALSE),
                    -contains('angle'))

# Create another tidy data set with the average of each feature variable for each
# activity and each subject
grouped_data <- group_by(tidyData1, subject_id, activity)
tidyData2 <- summarize_each(grouped_data, funs(mean))

# Write the final tidy data set to file
write.table(tidyData2, file = 'tidyData.txt', row.name = FALSE)
