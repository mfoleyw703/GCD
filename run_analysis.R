# Clean workspace
#rm(list=ls())
#
# Set Working Directory
#setwd("~/Coursera/cleaning/Project")
#
# Download the Zipped Files
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl,destfile="Dataset.zip")
#
# Unzip the files
#unzip(zipfile="./Dataset.zip",exdir="./data")
#
#Above Code only needs to be applied once

# Clean workspace
rm(list=ls())


# Set Working Directory
setwd("~/Coursera/cleaning/Project")

# load packages
library(plyr)
library(dplyr)

# Step 1 Merge Training and Test Sets Into One Set
# Read Training Files
x_train  <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read Test Files
x_test  <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read Features
features  <- read.table("./data/UCI HAR Dataset/features.txt")

# Read Activity Labels
act_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Apply Column Names
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(sub_train) <- "subjectId"

colnames(x_test) <- features[,2]
colnames(y_test) <-"activityId"
colnames(sub_test) <- "subjectId"

colnames(act_labels) <- c("activityId","activityType")

# Bind Data Sets
bind_train <- cbind(x_train,sub_train,y_train)
bind_test <- cbind(x_test,sub_test,y_test)

# Create a master data set
alldata <- rbind(bind_train,bind_test)
 
# Step 2 - 
  # Extracts only the measurements on the mean and standard deviation for each measurement
# Remove Duplicate Column Names
# This step is needed since select in next step detects duplicate columns - removes duplicate data columns
remove_dup_col_names <- duplicated(colnames(alldata))
alldata <- alldata[,!remove_dup_col_names]

# Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std<-select(alldata, subjectId, activityId, contains("mean"), contains("std"))

# Step3 
# Add Descriptive Activity Labels 
# Note: This step Activity type labels to end of the data frame
mean_std_add_act_names <- merge(mean_std,act_labels,by='activityId',all.x=TRUE)

# Step 4
# Add Descriptive Column Names
names(mean_std_add_act_names)<-gsub("^t", "time", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("^f", "frequency", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("Acc", "Accelerometer", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("Gyro", "Gyroscope", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("Mag", "Magnitude", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("BodyBody", "Body", names(mean_std_add_act_names))
names(mean_std_add_act_names)<-gsub("std", "stddev", names(mean_std_add_act_names))

# Step 5 
# Create a Tidy Data Set
tidy <- ddply(mean_std_add_act_names, .(subjectId, activityType), function(x) colMeans(x[, 3:87]))

# Create an output of the tidy data set
# Use "\t" to make Excel friendly
write.table(tidy, "Tidy.txt", sep="\t", row.name=FALSE)
