Enter file contents #Load reshape2 package
library(reshape2)

#Pre-process data to get features label
##Read features.txt for column labels
features <- read.table("features.txt")
feature_names <-  features[,2]

#Read test and train data
# 4) Appropriately label the data set with descriptive variable names
##Read and label columns of x_test, test data
testdata <- read.table("./test/X_test.txt")
colnames(testdata) <- feature_names

##Read and label columns of x_train, train data
traindata <- read.table("./train/X_train.txt")
colnames(traindata) <- feature_names

#Get subject id and activity id of test and train data
##Test
##Read subject_test for test subject id's and label column as subject_id
test_subject_id <- read.table("./test/subject_test.txt")
colnames(test_subject_id) <- "subject_id"

##Read y_test for activity id's and label column as activity_id
test_activity_id <- read.table("./test/y_test.txt")
colnames(test_activity_id) <- "activity_id"

##Train
##Read subject_train for train subject id and label column as subject_id
train_subject_id <- read.table("./train/subject_train.txt")
colnames(train_subject_id) <- "subject_id"

##Read y_train for activity id's and label column as activity_id
train_activity_id <- read.table("./train/y_train.txt")
colnames(train_activity_id) <- "activity_id"


#Merge subject id, activity id, data into one dataframe
##Test
test_data <- cbind(test_subject_id , test_activity_id , testdata)

##Train
train_data <- cbind(train_subject_id , train_activity_id , traindata)

#1) Merge the training and the test sets to create one set.
all_data <- rbind(train_data,test_data)

#2) Extract only the measurements on the mean and standard deviation for each measurement
mean_col_idx <- grep("mean",names(all_data),ignore.case=TRUE)
mean_col_names <- names(all_data)[mean_col_idx]
std_col_idx <- grep("std",names(all_data),ignore.case=TRUE)
std_col_names <- names(all_data)[std_col_idx]
meanstd_data <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]

#3) Use descriptive activity names to name the activites in the data set
activity_labels <- read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))
descr_data <- merge(activity_labels,meanstd_data,by.x="activity_id",by.y="activity_id",all=TRUE)

#5) Create a second, independently tidy data set with the average of each variable for each activity and each subject
##Melt the dataset for cast functionaliy
data_melt <- melt(descr_data,id=c("activity_id","activity_name","subject_id"))

##Cast the dataset to average each variable for each activity and each subject
mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)

##Write tidy_data_set.txt
write.table(mean_data,"./tidy_data_set.txt",row.name=FALSE )here
