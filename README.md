# Getting and Cleaning Data Project

## run_analysis.R

The cleanup script (run_analysis.R) does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Running the script

To run the script, source `run_analysis.R`. After running, you will see the following output as the script works:

```
> source('C:/project/Coursera/Getting and Cleaning Data Course Project/run_analysis.R')
[1] "Reading datasets."
reading features:  ./UCI HAR Dataset//test/X_test.txt 
reading features:  ./UCI HAR Dataset//test/Y_test.txt 
reading subjects:  ./UCI HAR Dataset//test/subject_test.txt 
reading features:  ./UCI HAR Dataset//train/X_train.txt 
reading features:  ./UCI HAR Dataset//train/Y_train.txt 
reading subjects:  ./UCI HAR Dataset//train/subject_train.txt 
[1] "Joining datasets."
[1] "Extracts only the measurements on the mean and standard deviation"
Saving clean data to: C:/project/Coursera/Getting and Cleaning Data Course Project/cleandata.txt 
> 
```

## Process

For both the test and train datasets, produce an interim dataset:
 1. Get names columns from features.txt

 2. Read data from directory /test and /train

 3. Joining this datasets

 4. Extract the mean and standard deviation features (listed in CodeBook.md, section 'Extracted Features'). This is the `values` table.

 5. Get the list of activities.

 6. Put the activity *labels* (not numbers) into the `values` table.

 7. Get the list of subjects.

 8. Put the subject IDs into the `values` table.

 9. Rejoin the entire table, keying on subject/acitivity pairs, applying the mean function to each vector of values in each subject/activity pair. This is the clean dataset.

 10. Write the clean dataset to disk.

## Cleaned Data

The resulting clean dataset is in this repository at: `./cleandata.txt`. It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.

## Notes

X_* - feature values (one row of 561 features for a single activity)
Y_* - activity identifiers (for each row in X_*)
subject_* - subject identifiers for rows in X_*