#Read the data in from the text files.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#Apply column names
colnames(subject_test)<-"subject"
colnames(x_test)<-features$V2
colnames(y_test)<-"activity"
colnames(subject_train)<-"subject"
colnames(x_train)<-features$V2
colnames(y_train)<-"activity"

#Synthesize test data and train data
test_data<-cbind(subject_test, y_test, x_test)
train_data<-cbind(subject_train, y_train, x_train)

#Remove duplicated columns
test_data<-test_data[, !duplicated(colnames(test_data))]
train_data<-train_data[, !duplicated(colnames(train_data))]

#Combine test and train data
combined_data<-rbind(train_data, test_data)

#Drop all data but identification, mean records, and standard deviations
combined_data<-combined_data[,grep("(-(mean|std)|subject|activity)", colnames(combined_data))]

#make activities user-friendly
combined_data$activity<-factor(
  combined_data$activity, levels=c(1, 2, 3, 4, 5, 6),
  labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
)

#Make column names more descriptive.
colnames(combined_data)<-gsub("^t", "time-", colnames(combined_data))
colnames(combined_data)<-gsub("^f", "fourier-", colnames(combined_data))
colnames(combined_data)<-gsub("BodyAcc", "body-accelerometer-", colnames(combined_data))
colnames(combined_data)<-gsub("GravityAcc", "gravity-accelerometer-", colnames(combined_data))
colnames(combined_data)<-gsub("BodyGyro", "body-gyroscope-", colnames(combined_data))
colnames(combined_data)<-gsub("Jerk", "jerk", colnames(combined_data))
colnames(combined_data)<-gsub("mean[(][)]-(X|Y|Z)", "\\1-mean", colnames(combined_data))
colnames(combined_data)<-gsub("std[(][)]-(X|Y|Z)", "\\1-s", colnames(combined_data))
colnames(combined_data)<-gsub("Mag$", "magnitude", colnames(combined_data))
colnames(combined_data)<-gsub("--", "-", colnames(combined_data))

#Create another data set with averages by activity
average_data<-aggregate(. ~ activity, data = combined_data[,-1], mean)

#Write to file
write.table(average_data, file="average_data.txt", row.name= F)
