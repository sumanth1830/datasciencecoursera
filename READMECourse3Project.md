# datasciencecoursera
John Hopkins Data Science Specialisation
## For Course 3 

## Step- 1
## Merge the training and the test sets to create one data set.

# We need to merge the X_train.txt and X_test.txt files as they have values for 561-feature vector with time and frequency domain variables.
trainingset dataframe <-  X_train.txt
testset dataframe <-  X_test.txt

# We also need to merge subject_train.txt and subject_test.txt as they have corresponding data of subjects on whom the tests are conducted.
trainsubjects dataframe <- subject_train.txt
testsubjects dataframe <- subject_test.txt

# We also need to merge the test labels and train labels text files are they correspond to respective activities
trainactivities dataframe <- y_train.txt
testactivities dataframe <- y_test.txt

mergedDataset, mergedsubjectset, mergedactivitiesset are the data frames formed by merging corresponding train and test sets

## Step-2

##Extracts only the measurements on the mean and standard deviation for each measurement. 
## There were 66 columns which had mean and standard deviation for measurements

We subset mergedDataset to get respective 66 columns.

## Step-3
## Uses descriptive activity names to name the activities in the data set

## mergedDataset <- bind_cols(mergedDataset, mergedactivitiesset, mergedsubjectset)
We merge mergedDataset, mergedsubjectset, mergedactivitiesset to get the complete set
Now, we name activities in mergedDataset based on the labels provided in activity_labels.txt

## Step - 4
## Appropriately labels the data set with descriptive variable names. 

We assign the feature names to column names of mergedDataset, by extracting names from features.txt

## Step - 5
## From the data set in step 4, 
## creates a second, independent tidy data set with the average of each variable for each activity and each subject.

We first group the data based on Activity and Subject columns and then do mean for all columns based on groups.
