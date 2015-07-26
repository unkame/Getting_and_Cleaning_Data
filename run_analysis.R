library(reshape2)
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Download and unzip the data
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels and features, and transform them to character
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features[,2] <- as.character(features[,2])

# Extract the mean and standard deviation of data by features
features2 <- grep(".*mean.*|.*std.*", features[,2])
features2.names <- features[features2,2]
features2.names = gsub('-mean', 'Mean', features2.names)
features2.names = gsub('-std', 'Std', features2.names)
features2.names <- gsub('[-()]', '', features2.names)

# Load the training data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features2]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the testing data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features2]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Combine the data of both training and testing data
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", features2.names)

# Transform the activities and subjects to factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# Save file as tidy.txt
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
