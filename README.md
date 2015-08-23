# cleandata_courseproject
run_analysis.R is to clean the data and finally output a tidy dataset with the average of each variable for each activity and each subject.

1, it read the train data set with all the data including data in the folder Inertial Signals
2, combine training dataset together
3, it read the test data set with all the data including data in the folder Inertial Signals
4, combine test dataset together
5, combine all the data as one dataset
6, name the first two columns: "subject_index", "activity", and 561 the features
7, extract only the measurements on the mean and standard deviation for each measurement
8, combine these measures with subject index and activity
9,	Uses descriptive activity names to name the activities in the data set
10, creates a second, independent tidy data set with the average of each variable for each activity and each subject 
11, save the data as results.txt
