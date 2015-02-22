The run_analysis.R script performs the following:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Specifically, first, variable names from features.txt were added to test and train data.  Next, each was merged with corresponding subject id and activity id labels.  Then, test and train data was merged into one dataset.  Next, only measurements on mean and standard deviation were kept.  Activity descriptions were added.  Finally, using melt and cast from the reshape2 library, the average values of each variable for each activity and each subject were calculated to form a new table, which was written to tidy_data_set.txt.

The CodeBook.md describes the data, variables, and data cleaning procedure.
