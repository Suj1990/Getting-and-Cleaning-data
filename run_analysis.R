##read alll the data into R
subject_test <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\test\\subject_test.txt")
subject_train <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\train\\subject_train.txt")
X_test <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\test\\y_test.txt")
X_train <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\train\\y_train.txt")
activity_labels <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\activity_labels.txt")
features <- read.table("D:\\ONEDRIVE\\Tableau Training\\Coursera\\New folder\\UCI HAR Dataset\\features.txt") 

##Merges the training and the test sets to create one data set.
dataSet <- rbind(X_train,X_test)

##Extracts only the measurements on the mean and 
##standard deviation for each measurement.
MeanStdv  <- grep("mean()|std()", features[, 2]) 
dataSet <- dataSet[,MeanStdv ]


##Uses descriptive activity names to name the activities in the data set
act_group <- factor(dataSet$activity)
levels(act_group) <- activity_labels[,2]
dataSet$activity <- act_group

##Appropriately labels the data set with descriptive variable names.
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataSet) <- CleanFeatureNames[MeanStdOnly]

##From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
Data1 <- melt(dataSet,(id.vars=c("subject","activity")))
data2 <- dcast(data1, subject + activity ~ variable, mean)
names(data2)[-c(1:2)] <- paste("[mean of]" , names(data2)[-c(1:2)] )
write.table(data2, "tidy_data.txt", sep = ",")

 

