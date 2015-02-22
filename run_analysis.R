#Please make sure the folder /UCI HAR Dataset is in your working directory

#1.Merges training and test data sets to create one data set
#4. Appropriately label  the data set with descriptive variable names

features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("activityid", "activity")

#Loads subject data
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#row binds strain and stest
s <- rbind(strain, stest)
#labels the data set
colnames(s) <- c("subject")


#Loads x data
xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/x_test.txt")
#row binds xtrain and xtest
x <- rbind(xtrain, xtest)
#labels the data set
colnames(x) <- features[, 2]



#Loads y data
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
#row binds ytrain and ytest
y <- rbind(ytrain, ytest)
#labels the data set
colnames(y) <- c("activityid")

#Training and #Test data merged and labeled

#2. Extracts only the meansurements on the mean and standard deviation for each measurement
#Load measurements

#Extracts only mean() and std()
columns <- grep("std\\(\\)|mean\\(\\)", features[, 2])
x2 <- x[, columns]

#column binds subject, x, and y

d <- cbind(s, y, x2)

#merges the activities databaset to get the names of the activities

df <- merge(activities, d, by.x="activityid", by.y="activityid", sort=FALSE)

#removes the activityid field since we already have the activity field

df <- df[, !(names(df) %in% c("activityid"))]


#5. Loads dplyr and tidyr

library(dplyr)
library(tidyr)

# moves the valeus to a single variable, then separate the variable into 4 variables -component, measure, aggregate and axis.
dfx <- df %>% 
  gather(component_measurement_aggregate_axis, reading, -activity, -subject) %>%
  mutate(component_measurement_aggregate_axis = sub("^t", "t_", component_measurement_aggregate_axis)) %>%
  mutate(component_measurement_aggregate_axis = sub("^f", "f_", component_measurement_aggregate_axis)) %>%
  separate(col=component_measurement_aggregate_axis, c("component", "measurement", "aggregate", "axis"))


#groups the records byactivity, subject, component, measurement, aggregate and axis
# and then calculate the average
dfx_grouped <- group_by(dfx,activity, subject, component, measurement, aggregate, axis)
dfy <- summarize(dfx_grouped, mean(reading))

#outputs the result to a file using write.table

write.table(dfy, file = "courseproject_tidydataset.txt", row.names=FALSE)
