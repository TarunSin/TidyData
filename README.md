# TidyData
# Repo created for Project for Getting and Cleaning Data | Coursera
# Explanation for program - run_analysis.R

# Load the libraries which will be useful in cleaning & tidying the data

library(plyr)
library(dplyr)

# Read the test files using read.table command
# Read features.txt to get the column names. Store them in a vector. Use names command to name the columns

df1 <- read.table("X_test.txt", stringsAsFactors = FALSE)
df2 <- read.table("features.txt", stringsAsFactors = FALSE)
vec1 <- df2[,2]
names(df1) <- vec1

# Read the activities & labels. 

df3 <- read.table("y_test.txt", stringsAsFactors = FALSE)
act_lab <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

# Use join instead of merge to maintain the row postions.

df5 <- left_join(df3, act_lab)

# Get the Activity vector 
Activity <- df5[,2]

# Get the Subject list and store in a vector
df7 <-  read.table("subject_test.txt", stringsAsFactors = FALSE )
Subject <- df7[,1]


# Use grep to select the features with mean & std in them
test2 <- grep("mean", vec1)
test3 <- grep("std", vec1)

# select the appropriate columns in the dataframe
df8 <- df1[,c(test2,test3)]

# combine the Activity & Subject column.
df9 <- cbind(Activity, df8)
dftest <- cbind(Subject,df9)

# Now the data is tidy for test as each row defines features for combination of 
# Subject and Activity for mean and std

# Repeat the steps for training data

dftrain1 <- read.table("X_train.txt", stringsAsFactors = FALSE)
dftrain3 <- read.table("y_train.txt", stringsAsFactors = FALSE)

names(dftrain1) <- vec1

df5 <- left_join(dftrain3, act_lab)


Activity <- df5[,2]

df7 <-  read.table("subject_train.txt", stringsAsFactors = FALSE )
Subject <- df7[,1]

df8 <- dftrain1[,c(test2,test3)]
df9 <- cbind(Activity, df8)
dftrain <- cbind(Subject,df9)

# Combine the two data set test & training

dfcombine <- rbind(dftest, dftrain)

# Finally using group_by group the data and since all features (columns)
# are to be summarised, use summarise_each with function mean
# Please note features names have been kept same, though gsub function can be
# used to add "Mean" string to names

dfFinal <- dfcombine %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(dfFinal, file = "dfFinal.txt", row.names = FALSE)
