getwd()




# change directory
setwd("~/Desktop/Coursera/03_CleaningData/Project/UCI HAR Dataset/")
list.files()

# import fies under this directory
dfFeatures <- read.table("features.txt")
str(dfFeatures)
colnames(dfFeatures) <- c("FeatureNumber", "FeatureName")



# change directory
setwd("~/Desktop/Coursera/03_CleaningData/Project/UCI HAR Dataset/test")
list.files()
# [1] "Inertial Signals" "subject_test.txt" "X_test.txt"       "y_test.txt"    

# import files under this directory
dfSubjectTest <- read.table("subject_test.txt")
dfXTest <- read.table("X_test.txt")
dfYTest <- read.table("y_test.txt")



# change directory
setwd("~/Desktop/Coursera/03_CleaningData/Project/UCI HAR Dataset/train")
list.files()
# [1] "Inertial Signals"  "subject_train.txt" "X_train.txt"       "y_train.txt"  

# import files under this directory
dfSubjectTrain <- read.table("subject_train.txt")
dfXTrain <- read.table("X_train.txt")
dfYTrain <- read.table("y_train.txt")



##################### Merges the training and the test sets to create one data set.

# stack Train and Test data pairings on top of each other
dfSubject <- rbind(dfSubjectTest, dfSubjectTrain)
dfX <- rbind(dfXTest, dfXTrain)
dfY <- rbind(dfYTest, dfYTrain)
  
str(dfSubject)
str(dfX)
str(dfY)

dim(dfSubject)
# [1] 10299     1
dim(dfY)
# [1] 10299     1
dim(dfX)
# [1] 10299   561
dim(dfFeatures)
# [1] 561   2



##################### Extracts only the measurements on the mean and standard deviation for each measurement. 
##################### Appropriately labels the data set with descriptive variable names. 

# change colnames 
colnames(dfSubject) <- "Subject"
colnames(dfY) <- "Feature"
colnames(dfX) <- as.vector(dfFeatures$FeatureName)

grep("mean()", colnames(dfX))
grep("mean()", dfFeatures$FeatureName)

grep("std()", colnames(dfX))
grep("std()", dfFeatures$FeatureName)

dfX_Subset_Mean <- dfX[, grep("mean()", colnames(dfX))]
dfX_Subset_Std <- dfX[, grep("std()", colnames(dfX))]

dfX_Subset_All <- cbind(dfX_Subset_Mean, dfX_Subset_Std)
dim(dfX_Subset_All)
head(dfX_Subset_All)
names(dfX_Subset_All)

dfFinal <- cbind(dfSubject, dfY, dfX_Subset_All)
str(dfFinal)


##################### Uses descriptive activity names to name the activities in the data set.
str(dfFinal$Y)
summary(dfFinal$Y)

# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

dfFinal$Y_Label <- 
  if(dfFinal$Y == '1'){
    dfFinal$Y_Label <- "Walking"
  } else {
    if(dfFinal$Y == '2'){
      dfFinal$Y_Label <- "Walking_Upstairs"
    } else {
      if(dfFinal$Y == '3'){
        dfFinal$Y_Label <- "Walking_Downstairs"
      } else {
        if(dfFinal$Y == '4'){
          dfFinal$Y_Label <- "Sitting"
        } else {
          if(dfFinal$Y == '5'){
            dfFinal$Y_Label <- "Standing"
          } else{
            if(dfFinal$Y == '6'{
              dfFinal$Y_Label <- "Laying"
            })
          }
        }

        
# output file for upload
write.table(dfFinal, "output.txt", sep="\t", row.name = FALSE)



