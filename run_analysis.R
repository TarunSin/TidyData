library(plyr)
library(dplyr)


df1 <- read.table("X_test.txt", stringsAsFactors = FALSE)
df2 <- read.table("features.txt", stringsAsFactors = FALSE)
vec1 <- df2[,2]
names(df1) <- vec1

df3 <- read.table("y_test.txt", stringsAsFactors = FALSE)
act_lab <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

df5 <- left_join(df3, act_lab)

Activity <- df5[,2]

df7 <-  read.table("subject_test.txt", stringsAsFactors = FALSE )
Subject <- df7[,1]

test2 <- grep("mean", vec1)
test3 <- grep("std", vec1)
df8 <- df1[,c(test2,test3)]
df9 <- cbind(Activity, df8)
dftest <- cbind(Subject,df9)

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

dfcombine <- rbind(dftest, dftrain)

dfFinal <- dfcombine %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(dfFinal, file = "dfFinal.txt", row.names = FALSE)