# Getting and Cleaning Data Course Project
# Data sources https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# run_analysis.R script to perform  
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
# 
#How to run and expectation result
# Data set must download and unzip to current working directory ./"UCI HAR Dataset" before run run_analysis.R
# source("run_analysis.R") at RStudio and it will take proximately 2 minutes to complete
# tidy_data.txt will create under your current working directory. For more detail infomation please refer to README.md

# Load Raw Data into R
require(plyr)
dataset_dir <- "UCI HAR Dataset"
feature_file <- paste(dataset_dir, "/features.txt", sep = "")

activity_labels_file <- paste(dataset_dir, "/activity_labels.txt", sep = "")
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))

x_train_file <- paste(dataset_dir, "/train/X_train.txt", sep = "")
x_train <- read.table(x_train_file)

y_train_file <- paste(dataset_dir, "/train/y_train.txt", sep = "")
y_train <- read.table(y_train_file)

subject_train_file <- paste(dataset_dir, "/train/subject_train.txt", sep = "")
subject_train <- read.table(subject_train_file)

x_test_file  <- paste(dataset_dir, "/test/X_test.txt", sep = "")
x_test <- read.table(x_test_file)

y_test_file  <- paste(dataset_dir, "/test/y_test.txt", sep = "")
y_test <- read.table(y_test_file)

subject_test_file <- paste(dataset_dir, "/test/subject_test.txt", sep = "")
subject_test <- read.table(subject_test_file)

features <- read.table(feature_file, colClasses = c("character"))

#######################################################################
### 1. Merges the training and the test sets to create one data set.###
#######################################################################

# Binding data
training_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
combine_data <- rbind(training_data, test_data)

# Label columns
labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(combine_data) <- labels

############################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
############################################################################################

data_mean_std <- combine_data[,grepl("mean|std|Subject|ActivityId", names(combine_data))]

###########################################################################
# 3. Uses descriptive activity names to name the activities in the data set
###########################################################################

data_mean_std <- join(data_mean_std, activity_labels, by = "ActivityId", match = "first")
data_mean_std <- data_mean_std[,-1]

##############################################################
# 4. Appropriately labels the data set with descriptive names.
##############################################################

# Remove parentheses
names(data_mean_std) <- gsub('\\(|\\)',"",names(data_mean_std), perl = TRUE)
# Make syntactically valid names
names(data_mean_std) <- make.names(names(data_mean_std))
# Make clearer names
names(data_mean_std) <- gsub('Acc',"Acceleration",names(data_mean_std))
names(data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(data_mean_std))
names(data_mean_std) <- gsub('Gyro',"AngularSpeed",names(data_mean_std))
names(data_mean_std) <- gsub('Mag',"Magnitude",names(data_mean_std))
names(data_mean_std) <- gsub('^t',"TimeDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('^f',"FrequencyDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('\\.mean',".Mean",names(data_mean_std))
names(data_mean_std) <- gsub('\\.std',".StandardDeviation",names(data_mean_std))
names(data_mean_std) <- gsub('Freq\\.',"Frequency.",names(data_mean_std))
names(data_mean_std) <- gsub('Freq$',"Frequency",names(data_mean_std))

######################################################################################################################
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
######################################################################################################################

tidy_data <- ddply(data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE)