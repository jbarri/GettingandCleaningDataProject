# Getting and Cleaning Data Project

### Introduction

With this project we intend to get a subset of data that meets the condition data to be tidy, in this repository will have the file with the results, the program written in R that allows us to analyze the raw data and get the data tidy, plus a README file and a CODEBOOK is attached.

### Raw Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Instructions

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Merges the training and the test sets to create one data set.

The data is downloaded and decompressed in our working directory, the directory
where data is decompressed "UCI HAR Dataset" there are two more folders "test" and "train" where
find most of the survey data. Inertial Signal folder is not required for this project.

#### Extracts only the measurements on the mean and standard deviation for each measurement.

Create a vector column name `columns` with mean values and standard deviation appear, information for selecting the two files get, `features_info` and `features`.

#### Uses descriptive activity names to name the activities in the data set.

The activities carried out in the experiment are six.
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
Use the descriptions stored in the data frame `activity_labels` to identify the numerical values are in `total_y`. I do this using the function  `for`.

#### Appropriately labels the data set with descriptive variable names. 

At this point we have a data frame with 75 variables unnamed, we will label the first column as `Subject` (there are 30 people doing the experiment), the second column will label as `Activity` (there are six activities subject box) for the rest of variables describing `features` that are in the file is used, I think it is sufficiently descriptive.

#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I use the function `gather` to create a new data frame (`by_parameters`) with the following variables, `Subject`, `Activity`, `Parameters` and `Value`.
I use the function to group `group_by` `Subject`, `Activity` and `Parameters`, then use the function `mutate` to calculate the average and put the result in the `Average` variable.
I use the `select` function, select `Subject`, `Activity`, `Parameters`, `Average`. Remove repeated rows with `unique` function, finally use the `spread` to regain function 75 variables, now will mean values.

#### Write data set on the hard disk
`final_df` saved as a data set on the hard disk, save it directly in the working directory
name and as you will `final_dataset.txt`.

`write.table(final_df, "final_dataset.txt", row.name=FALSE)`

#### Read hard drive data set

It can be read directly by loading the file `final_dataset.txt` directly in RStudio, the following line can also be used to load the file in a data frame called data.

`data <- read.table("final_dataset.txt", header = TRUE)`

