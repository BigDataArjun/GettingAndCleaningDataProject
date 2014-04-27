library(reshape2) #Adding the reshape2 library to perform Averages

#reading the activity labels data and labeling the columns 
activity <- read.table("Data/activity_labels.txt",col.name=c("activityIndex","activityName"))

#reading the features data and extracting the mean() and std() patterns
features <-read.table("Data/features.txt",sep="")
toMatch <- c(".*mean\\(\\).*-X$",".*mean\\(\\).*-Y$",".*mean\\(\\).*-Z$", ".*std\\(\\).*-X$",".*std\\(\\).*-Y$",".*std\\(\\).*-Z$")
selectedFeaturesName <- unique (grep(paste(toMatch,collapse="|"), features$V2, value=TRUE))
selectedFeaturesIndex <- unique (grep(paste(toMatch,collapse="|"), features$V2))

#generating a vector of classes as numeric and NULL, to extract only the required fields from the text file
notSelectedFeaturesIndex <- (1:nrow(features))[-selectedFeaturesIndex]
colClasses <- character(nrow(features))
colClasses[notSelectedFeaturesIndex] <- "NULL"
colClasses[selectedFeaturesIndex] <- "numeric"

#extracting only the required fields and naming the columns accordingly
X_trainSelectedData <- read.table("Data/X_train.txt",colClasses=colClasses, sep="", col.names=features$V2)
subject <- read.table("Data/subject_train.txt",col.name="subject")
Y_train <- read.table("Data/y_train.txt", col.name="activityIndex")
#combining the data 
mergedDataTrain <- cbind(subject,X_trainSelectedData,Y_train)
#generating the activity labels
tidyDataTrain <- merge(mergedDataTrain,activity,by=c("activityIndex"),sort=FALSE)

#perfoeming the similar steps as above for test data
X_testSelectedData <- read.table("Data/X_test.txt",colClasses=colClasses, sep="", col.names=features$V2)
subject <- read.table("Data/subject_test.txt",col.name="subject")
Y_test <- read.table("Data/y_test.txt", col.name="activityIndex")

mergedDataTest <- cbind(subject,X_testSelectedData,Y_test)
tidyDataTest <- merge(mergedDataTest,activity,by=c("activityIndex"),sort=FALSE)
#comn=bining the train and test data
tidyDataSet <- rbind(tidyDataTrain,tidyDataTest)

#melting the data to long form with subject and activityName as the variables
molten = melt(tidyDataSet, id.vars = c("subject", "activityName"), na.rm = TRUE)
#dcasting the data and generating the mean values
tidyDataSetAvg <- dcast(molten,formula = subject + activityName ~ variable, fun.aggregate = mean)

#writing the output to a file
write.table(tidyDataSetAvg, "tidyDataSetAvg.txt", sep="\t")
