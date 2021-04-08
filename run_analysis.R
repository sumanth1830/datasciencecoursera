
## Step- 1
## Merge the training and the test sets to create one data set.

##We need to merge the X_train.txt and X_test.txt files as they have values for 561-feature vector with time and frequency domain variables.
trainingset <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE)
testset <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE)

## We also need to merge subject_train.txt and subject_test.txt as they have corresponding data of subjects on whom the tests are conducted.

trainsubjects <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
testsubjects <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## We also need to merge the test labels and train labels text files are they correspond to respective activities

trainactivities <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
testactivities <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)


## I opted for rowbind as they are not yet named

mergedDataset <- bind_rows(trainingset, testset)
mergedsubjectset <- bind_rows(trainsubjects, testsubjects)
mergedactivitiesset <- bind_rows(trainactivities, testactivities)

##Now we should column bind all these sets together to form mergedDataset


print("Step-1 cleared")

## Step-2

##Extracts only the measurements on the mean and standard deviation for each measurement. 
## There were 66 columns which had mean and standard deviation for measurements

mergedDataset <- mergedDataset [ ,c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254,
                                    266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]

##That will get the subset of respective mean and sd columns of respective measurements
print("Step-2 cleared")

## Step-3
## Uses descriptive activity names to name the activities in the data set

mergedDataset <- bind_cols(mergedDataset, mergedactivitiesset, mergedsubjectset)

mergedDataset$V1...67[mergedDataset$V1...67 == 1] <- "WALKING"
mergedDataset$V1...67[mergedDataset$V1...67 == 2] <- "WALKING_UPSTAIRS"
mergedDataset$V1...67[mergedDataset$V1...67 == 3] <- "WALKING_DOWNSTAIRS"
mergedDataset$V1...67[mergedDataset$V1...67 == 4] <- "SITTING"
mergedDataset$V1...67[mergedDataset$V1...67 == 5] <- "STANDING"
mergedDataset$V1...67[mergedDataset$V1...67 == 6] <- "LAYING"

## Name the activities column values based on the activity_labels.txt
print("Step-3 cleared")

##Step - 4
## Appropriately labels the data set with descriptive variable names. 

featurenames <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", header = FALSE)

## To only get the names of mean() and std() columns names of feature from features.txt
## [^F] - To remove meanFreq() measure from names
featurenames <- featurenames$V2[grep(".*(mean|std)[^F].*", featurenames$V2)]

## To include Activity and Subject column to the feature names 
featurenames <- c(featurenames, "Activity", "Subject")

colnames(mergedDataset) <- featurenames
print("Step-4 cleared")


##Step - 5
##From the data set in step 4, 
##creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finaldataset <- mergedDataset %>% group_by(Activity, Subject) %>% summarise(across(everything(), list(mean)))

write.table(Finaldataset, "result.txt", sep="\t", row.names = FALSE)
















