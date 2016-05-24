#Script for Final Project for Getting and Cleaning Data

setwd("/Users/Sazerac/Dropbox/Coursera/Cleaning_Data_FP/")

file <- "getdata_dataset.zip"

## Download data:
if (!file.exists(file)){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(URL, file, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

###Load In Test dataSets and Apply Header titles
##Test Variables
X_Test<- read.table(file="UCI HAR Dataset/test/X_test.txt", sep="", header=F)
FEAT<- read.table(file="UCI HAR Dataset/features.txt", sep="", header=F)
colnames(X_Test)<-FEAT[,2]
##Subject Designations
Subject<-read.table(file="UCI HAR Dataset/test/subject_test.txt", sep="", header=F)
names(Subject)=c("Subject")
##Test Designations
TestType<-read.table(file="UCI HAR Dataset/test/y_test.txt", sep="", header=F)
names(TestType)=c("TestType")
#Create a DataType Column
TYPE<-as.data.frame(matrix("Test", 2947, 1))
names(TYPE)=c("DataType")

#Make a final Test Dataset
TEST<-cbind(Subject, TestType, TYPE, X_Test)
#Clean_Names
names(TEST)<-gsub('[-()]', '', names(TEST))


#Rep for training
###Load In Test dataSets and Apply Header titles
##Training Variables
X_Test_Train<- read.table(file="UCI HAR Dataset/train/X_train.txt", sep="", header=F)
colnames(X_Test_Train)<-FEAT[,2]

##Subject Designations
Subject_Train<-read.table(file="UCI HAR Dataset/train/subject_train.txt", sep="", header=F)
names(Subject_Train)=c("Subject")

##Test Designations
TestType_Train<-read.table(file="UCI HAR Dataset/train/y_train.txt", sep="", header=F)
names(TestType_Train)=c("TestType")

#Create a DataType Column
TYPE_train<-as.data.frame(matrix("Train", 7352, 1))
names(TYPE_train)=c("DataType")

#Make a final Test Dataset
TRAIN<-cbind(Subject_Train, TestType_Train, TYPE_train, X_Test_Train)

##Appropriately labels the data set with descriptive variable names.
names(TRAIN)<-gsub('[-()]', '', names(TRAIN))

##Merges the training and the test sets to create one data set.
#MakeMasterSet
MASTER<-rbind(TEST, TRAIN)

##Uses descriptive activity names to name the activities in the data set
#changeActivityLabels
ActLvl<-read.table(file="UCI HAR Dataset/activity_labels.txt", sep="", header=F)
MASTER[,2]<-ActLvl[MASTER[,2],2]

##Extracts only the measurements on the mean and standard deviation for each measurement.
#Get Columns to extract
STD_Name<-tolower(names(MASTER))
ColTarget<-c(1,2,3,grep(".*mean.*|.*std.*", STD_Name))
#Extract
Tidy<-MASTER[,ColTarget]


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Ftidy <- aggregate(Tidy, by=list(activity = Tidy$TestType, subject=Tidy$Subject), mean)
Ftidy <- cbind(Ftidy[,1:2], Ftidy[,6:dim(Ftidy)[2]]) 

write.table(Ftidy, "tidy.txt", row.names = FALSE, quote = FALSE)







