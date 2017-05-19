subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
X_Data <- rbind(X_train, X_test)
Y_Data <- rbind(Y_train, Y_test)
subject_Data <- rbind(subject_train, subject_test)
X_Data_mean_std <- X_Data[, grep("-(mean|std)\\(\\)", read.table("./UCI HAR Dataset/features.txt")[, 2])]
names(X_Data_mean_std) <- read.table("./UCI HAR Dataset/features.txt")[grep("-(mean|std)\\(\\)", read.table("./UCI HAR Dataset/features.txt")[, 2]), 2]
dim(X_Data_mean_std)
Y_Data[, 1] <- read.table("./UCI HAR Dataset/activity_labels.txt")[Y_Data[, 1], 2]
names(Y_Data) <- "Activity"
names(subject_Data) <- "Subject"
singleDataSet <- cbind(X_Data_mean_std, Y_Data, subject_Data)
names(singleDataSet) <- make.names(names(singleDataSet))
names(singleDataSet) <- gsub('Acc',"Acceleration",names(singleDataSet))
names(singleDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(singleDataSet))
names(singleDataSet) <- gsub('Gyro',"AngularSpeed",names(singleDataSet))
names(singleDataSet) <- gsub('Mag',"Magnitude",names(singleDataSet))
names(singleDataSet) <- gsub('^t',"TimeDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('^f',"FrequencyDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('\\.mean',".Mean",names(singleDataSet))
names(singleDataSet) <- gsub('\\.std',".StandardDeviation",names(singleDataSet))
names(singleDataSet) <- gsub('Freq\\.',"Frequency.",names(singleDataSet))
names(singleDataSet) <- gsub('Freq$',"Frequency",names(singleDataSet))
View(singleDataSet)
names(singleDataSet)
Data2 <- aggregate(. ~Subject + Activity, singleDataSet, mean)
Data2 <- Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
View(Data2)