library(dplyr)
library(tidyr)

# Loads data from different files that need to perform the task
# The data is downloaded and decompressed in our working directory, the directory
# where data is decompressed "UCI HAR Dataset" there are two more folders "test" and "train" where
# find most of the survey data.



# Load data features, activity_labels.

features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")

# Load test data folder and the train folder, the files are:
# y_train, X_train, subject_train, y_test, X_test, subject_test

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")

# We combine the two data frames and X_test X_train to create a 
# new data frame with all values, we call total_X

total_X <- rbind(X_train, X_test)

# We combine the two data frames  subject_test  and subject_train to create a 
# new data frame, the call total_subject

total_subject <- rbind(subject_train, subject_test)

# We combine the two data frames y_train and y_test to create a new data frame, the call total_y

total_y <- rbind(y_train, y_test)

# We will select the columns containing means and standard deviations, after reading the file
# features_info and feaures created a vector with the selection of columns that I think represents
# mean values and standard deviations, call the data frame X_selected.

colums <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,
            121,122,123,124,125,126,161,162,163,164,165,166,201,
            202,214,215,227,228,241,242,253,254,266,267,268,269,
            270,271,345,346,347,348,349,350,373,374,375,424,425,
            426,427,428,429,452,453,454,503,504,526,529,530,539,
            542,543,552)

X_selected <- total_X[,colums]

# Now we name the activities in total_y name with the data we have in activity_label

for (x in activity_labels$V1){
  total_y$V1 <- replace(total_y$V1, total_y$V1 == x ,
                                as.character(activity_labels$V2[[x]]))
}

# We label the different variables with descriptive names

col_names <- features[2][colums,] # Descriptive variable names with mean and standard deviation

colnames(total_subject) <- "Subject"  # We label as Subject total_suject
colnames(total_y) <- "Activity" # We label as Activity  total_y 
colnames(X_selected) <- col_names # We label the col_names vector X_selected

# We join the three data frames, total_subject, total_y, X_selected
# to create the data frame data_selected  you already have
# variables with descriptive names

data_selected <- cbind(total_subject, total_y, X_selected)


# We ordain respect to the data frame  Activity and Subject

data_selected <- arrange(data_selected, Subject, Activity)

# Grouped columns in a new data frame with Subject, Activity, Parameters, Value

by_parameters <- gather(data_selected, Parameters, Value, -Subject, -Activity)

# We grouped by varying the data frame to make the calculation of the average,
# grouped by Subject, Activity, Parameters. Calculating the average is calculated
# and the result is placed in Average.

by_parameters <- group_by(by_parameters, Subject, Activity, Parameters)
pack_mean <- mutate(by_parameters, Average = mean (Value))

# Prepare the data to show the latest data frame, remove the Value variable and retreat all repeated rows
# , separated Parameters with the spread function, obtaining a data frame called final_df
# with the following variables, Subject, Activity and other variables that had gathered in Parameters,
# the values of these variables are the average of different values in the variables had about Subject and Activity.

final_df <- select(pack_mean, Subject, Activity, Parameters, Average)
final_df <- unique(final_df)
final_df <- spread(final_df, Parameters, Average)

# final_df saved as a data set on the hard disk, save it directly in the working directory
# name and as you will final_dataset.txt

write.table(final_df, "final_dataset.txt", row.name=FALSE)