library(foreign)
setwd("./Documents/cleandata/UCI_HAR_Dataset")
########### read the training data
X_train = read.table("./train/X_train.txt");
y_train = read.table("./train/y_train.txt");
subject_train = read.table("./train/subject_train.txt");

########### read the train data set in the folder Inertial Signals
setwd("./train/Inertial Signals")

files <-list.files()

data <- 0

n= 0
for (f in files) {
  n=n+1
  tempData = scan( f, what="character")
  
  data <- c(data,tempData)    
  
} 

data <- data[2:length(data)]
rm(tempData)

data1 <- matrix(data, nrow = 9, byrow = TRUE)
data_1 <- t(matrix(data1[1, ],nrow = 128, byrow = FALSE))
data_2 <- t(matrix(data1[2, ],nrow = 128, byrow = FALSE))
d <- cbind(data_1,data_2)
data_3 <- t(matrix(data1[3, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_3)
data_4 <- t(matrix(data1[4, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_4)
data_5 <- t(matrix(data1[5, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_5)
data_6 <- t(matrix(data1[6, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_6)
data_7 <- t(matrix(data1[7, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_7)
data_8 <- t(matrix(data1[8, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_8)
data_9 <- t(matrix(data1[9, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_9)

################### combine training dataset together
data_f <- cbind(subject_train, y_train, X_train, d)

rm(data)
rm(data_1)
rm(data_2)
rm(data_3)
rm(data_4)
rm(data_5)
rm(data_6)
rm(data_7)
rm(data_8)
rm(data_9)
##############################
### read the  test data
############################# 

X_test = read.table("../../test/X_test.txt");
y_test = read.table("../../test/y_test.txt");
subject_test = read.table("../../test/subject_test.txt");

######## read the test data set in the folder Inertial Signals

setwd("../../test/Inertial Signals")
rm(files)
files <-list.files()

data <- 0

n= 0
for (f in files) {
  n=n+1
  tempData = scan( f, what="character")
  
  data <- c(data,tempData)    
  
} 

data <- data[2:length(data)]
rm(tempData)

data1 <- matrix(data, nrow = 9, byrow = TRUE)
data_1 <- t(matrix(data1[1, ],nrow = 128, byrow = FALSE))
data_2 <- t(matrix(data1[2, ],nrow = 128, byrow = FALSE))
d <- cbind(data_1,data_2)
data_3 <- t(matrix(data1[3, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_3)
data_4 <- t(matrix(data1[4, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_4)
data_5 <- t(matrix(data1[5, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_5)
data_6 <- t(matrix(data1[6, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_6)
data_7 <- t(matrix(data1[7, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_7)
data_8 <- t(matrix(data1[8, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_8)
data_9 <- t(matrix(data1[9, ],nrow = 128, byrow = FALSE))
d <- cbind(d,data_9)
################### combine test dataset together
data_ftest <- cbind(subject_test, y_test, X_test, d)

rm(data)
rm(data_1)
rm(data_2)
rm(data_3)
rm(data_4)
rm(data_5)
rm(data_6)
rm(data_7)
rm(data_8)
rm(data_9)

########## combine all the data as one dataset

data_final <- rbind(data_f, data_ftest)

############ name the first two columns: "subject_index", "activity", and 561 the features

fea = t(read.table("../../features.txt", header=FALSE));

names(data_final) <- c("subject_index", "activity", fea[2,])

########### extract only the measurements on the mean and standard deviation for each measurement
mean_ones <- data_final[, grep('mean\\(', colnames(data_final))] 
std_ones <- data_final[, grep('std', colnames(data_final))] 

#### combine these measures with subject index and activity

extract <- cbind(data_final[, 1:2],mean_ones,std_ones)
extract1 <- extract 

#### Uses descriptive activity names to name the activities in the data set
extract1[,2] <- gsub("1","WALKING",extract1[,2])
extract1[,2] <- gsub("2","WALKING_UPSTAIRS",extract1[,2])
extract1[,2] <- gsub("3","WALKING_DOWNSTAIRS",extract1[,2])
extract1[,2] <- gsub("4","SITTING",extract1[,2])
extract1[,2] <- gsub("5","STANDING",extract1[,2])
extract1[,2] <- gsub("6","LAYING",extract1[,2])

### FOR Q5 creates a second, independent tidy data set with the average of each variable for each activity and each subject

#########
act <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

result = NULL

for (i in 1:30){
  for (gg in act){
    
    x <- sapply(extract1[extract1$subject_index==i & extract1$activity==gg, 3:68], mean)
    x1 <- cbind(i,gg,t(x))
    result <- rbind(result, x1)
    
    rm(x)
  }
  
}
## rename the first 2 columns
colnames(result)[1:2] <- c("subject_index", "activity")
#######save the data as results.txt
write.table(result,"../../results.txt",row.names = FALSE)
