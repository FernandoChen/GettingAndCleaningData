This the the accompanying README file for the Data Science Getting and Cleaning Data Course Project

The script file for this project is run_analysis.R. It assumes the zip file has been unpacked to your working directory in the folder UCI HAR Dataset.
Please add a setwd() statement at the beginning of the script to set your working directory so that this UCI HAR Dataset folder is underneath it for the script file to execute correctly.

This script file uses the following files in the "UCI HAR Dataset" folder. I didn't use the files in the ./Inertial Signals folders because I was not sure how they are related to the database.

./activity_lables.txt
./features.txt
./test/subject_test.txt
./test/X_test.txt
./test/Y_test.txt
./train/subject_train.txt
./train/X_train.txt
./train/Y_train.txt

I loaded each of these files to a data frame, added the appropriate column names and then assembled them together to form a single big data frame.

Then I created a subse containing only the activity,subject, mean and standard deviation fields - this reduced the number of measurements from 561 to 66.

The combined data set has 10299 observations of 68 variables - that's 66 of the measurements plus the activity and subject fields.

After looking at the 66 measurements carefully, I noticed that they are actually 4 things in one - the name of measurement, the component of the measurement -
either time or frequency, axis of the measurement -if exists, and the aggregate function applied to the result to obtain the reading.

Once I figured out how I wanted to reshape the data, I applied functions in the "tidyr" package and reached a final dataset consisting of 7 variables and 
11880 observations.

Comments have been added to the run_analysis.R script to document the steps if the above explanation is not clear enough.

The seven variables are activity, subject, component, measurement, aggregate, axis, and mean(reading). Since there are 30 subject, 6 activities, and I am
watching 66 variables, I find the result 11880 observations consistent with 30*6*66 = 11880

I think this dataset is tidy because each column is a variable, each  row is an observation and each type of observational unit forms a table. I could have split 
the dataset into 2 tables - one containing observations that have axis observations and the other without but it doesn't really make a lot of difference so I left 
them in a single dataset.




