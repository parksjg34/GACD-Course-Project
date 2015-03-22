###Unzip###

unzip(zipfile="./getdata_projectfiles_UCI HAR Dataset.zip",exdir=".")
list.files(".")

###List Files

DataFilesPath <- file.path("." , "UCI HAR Dataset")
DataFiles<-list.files(DataFilesPath, recursive=TRUE)
DataFiles

###Great Post: https://class.coursera.org/getdata-012/forum/thread?thread_id=9

#--------------------------------------------------------------------#

###Merges the training and the test sets to create one data set.
###Activity Files or Y:
FileYActivityTest  <- read.table(file.path(DataFilesPath, "test" , "Y_test.txt" ),header = FALSE)
FileYActivityTrain <- read.table(file.path(DataFilesPath, "train", "Y_train.txt"),header = FALSE)

#str(FileYActivityTest)
#str(FileYActivityTrain)

###Merge Activity or Y Data:

DataYActivity<- rbind(FileYActivityTrain, FileYActivityTest)
###Name the Activity or Y Variable:
names(DataYActivity)<- c("activity")

###Subject Files:
FileSubjectTrain <- read.table(file.path(DataFilesPath, "train", "subject_train.txt"),header = FALSE)
FileSubjectTest  <- read.table(file.path(DataFilesPath, "test" , "subject_test.txt"),header = FALSE)

#str(FileSubjectTrain)
#str(FileSubjectTest)

###Merge Subject Files
DataSubject <- rbind(FileSubjectTrain, FileSubjectTest)

###Name the Subject Variable:
names(DataSubject)<-c("subject")

###Features Files or X:
FileXFeaturesTest  <- read.table(file.path(DataFilesPath, "test" , "X_test.txt" ),header = FALSE)
FileXFeaturesTrain <- read.table(file.path(DataFilesPath, "train", "X_train.txt"),header = FALSE)

#str(FileXFeaturesTest)
#str(FileXFeaturesTrain)

###Merge Feature Files or X
DataXFeatures<- rbind(FileXFeaturesTrain, FileXFeaturesTest)

###Name the Feature Files or X:
DataXFeaturesNames <- read.table(file.path(DataFilesPath, "features.txt"),head=FALSE)
names(DataXFeatures)<- DataXFeaturesNames$V2

###Merge Columns
DataMerge <- cbind(DataSubject, DataYActivity)
Dataset <- cbind(DataXFeatures, DataMerge)

#str(Dataset)

#--------------------------------------------------------------------#

###Extract only the measurements on the mean and standard deviation for each measurement. 

###Get only Columns with Mean() or std() in their Names
MeanandstdFeatures<-DataXFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)|Subject|ActivityId", DataXFeaturesNames$V2)]

###Subset Desired Columns
DisiredNames<-c(as.character(MeanandstdFeatures), "subject", "activity" )
DataSetDefined<-subset(Dataset,select=DisiredNames)

#str(DataSetDefined)

#--------------------------------------------------------------------#

###Uses descriptive activity names to name the activities in the data set

###Read File
Activities <- read.table(file.path(DataFilesPath, "activity_labels.txt"),header = FALSE)
#str(Activities)

###Update Activity Values
DataYActivity[, 1] <- Activities[DataYActivity[, 1], 2]

###Raname Column
names(DataYActivity)<- c("activity")

#head(DataYActivity$activity,25)
###Rerun Dataset Creation (Step 1 or 2) for Proper Names in Dataset
#head(Dataset$activity,25)
#head(DataSetDefined$activity,25)

#--------------------------------------------------------------------#

###Appropriately labels the data set with descriptive variable names. 

#str(DataSetDefined)

#Clean Up Names
names(DataSetDefined) <- gsub('\\(|\\)',"",names(DataSetDefined), perl = TRUE)
names(DataSetDefined) <- gsub('Acc',"Acceleration",names(DataSetDefined))
names(DataSetDefined) <- gsub('GyroJerk',"AngularAcceleration",names(DataSetDefined))
names(DataSetDefined) <- gsub('Gyro',"AngularSpeed",names(DataSetDefined))
names(DataSetDefined) <- gsub('Mag',"Magnitude",names(DataSetDefined))
names(DataSetDefined) <- gsub('^t',"TimeDomain.",names(DataSetDefined))
names(DataSetDefined) <- gsub('^f',"FrequencyDomain.",names(DataSetDefined))
names(DataSetDefined) <- gsub('-mean',".Mean",names(DataSetDefined))
names(DataSetDefined) <- gsub('-std',".StandardDeviation",names(DataSetDefined))
names(DataSetDefined) <- gsub('Freq\\.',"Frequency.",names(DataSetDefined))
names(DataSetDefined) <- gsub('Freq$',"Frequency",names(DataSetDefined))
names(DataSetDefined) <- gsub('BodyBody',"Body",names(DataSetDefined))

names(DataSetDefined) <- make.names(names(DataSetDefined))

#names(DataSetDefined)
#str(DataSetDefined)

#--------------------------------------------------------------------#

###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

TidyData <-aggregate(. ~subject + activity, DataSetDefined, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "TidyData.txt",row.name=FALSE)

#str(TidyData)
