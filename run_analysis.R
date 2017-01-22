# Clean Up
rm(list=ls())

# Get Dataset and Make Directories if Needed

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Unzip File to Proper Location

unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Set Path

data_path <- file.path("./data" , "UCI HAR Dataset")

# Read in Data Files Y

yTest  <- read.table(file.path(data_path, "test" , "Y_test.txt"),header = FALSE)
yTrain <- read.table(file.path(data_path, "train", "Y_train.txt"),header = FALSE)

# Read in Data Files Subject

SubjectTrain <- read.table(file.path(data_path, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(data_path, "test" , "subject_test.txt"),header = FALSE)

# Read in Data Files X

xTest  <- read.table(file.path(data_path, "test" , "X_test.txt" ),header = FALSE)
xTrain <- read.table(file.path(data_path, "train", "X_train.txt"),header = FALSE)

# 1. Merges the training and the test sets to create one data set.
# Initial Merge

Subject <- rbind(SubjectTrain, SubjectTest)
Activity <- rbind(yTrain, yTest)
Features <- rbind(xTrain, xTest)

# Final Merge

Combine <- cbind(Subject, Activity)
Data <- cbind(Features, Combine)

# Label columns

featuresTxt <- read.table(file.path(data_path, "features.txt"), colClasses = c("character"))
FeaturesLabels <- rbind(rbind(featuresTxt, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(Data) <- FeaturesLabels

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others

subFeaturesNames = grepl("mean\\(\\)|std\\(\\)", featuresTxt$V2)

# Subset finalData table based on the logicalVector to keep only desired columns

finalData = Data[subFeaturesNames==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("ActivityId", "Activity"))
Data <- join(finalData, activity_labels, by = "ActivityId", match = "first")
Data <- Data[,-1]

# 4. Appropriately labels the data set with descriptive variable names.

names(Data)<-gsub("\\()","", names(Data))
names(Data)<-gsub("^(t)", "Time", names(Data))
names(Data)<-gsub("^(f)", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("-std","StdDev", names(Data))
names(Data)<-gsub("-mean","Mean", names(Data))

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

tidyData = ddply(Data, c("Subject","Activity"), numcolwise(mean))
write.table(tidyData, file = "./Getting-And-Cleaning-Data/tidyData.txt", row.name=FALSE)