##CodeBook
###Getting and Cleaning Data Course Project

Description of Variables, Data files and the working of the script `run_analysis.R.`

###Variables in output file(s)

* `activity_label` <br>
   Name of activity (laying, sitting, standing, walking, walking\_downstairs, walking\_upstairs)
* `subject_no.` <br>
   Subject number (1 to 30)
* `activity_no.` <br>
   Activity number (1 to 6)
* The other columns are as described in the original data set

###Output files
* `output_means_extracted.txt` - Means of mean and std columns when grouped by activity and subject
* `output_mean_std_extracted.txt` - Data extract of mean and std columns

### The `run_analysis.R`

1. Read data from the following files<br>
`X_train.txt`<br>
`Y_train.txt`<br>
`X_test.txt`<br>
`Y_test.txt`<br>
`subject_train.txt`<br>
`subject_test.txt`<br>
`features_file.txt`<br>
`activity_label_file.txt`<br>

2. Apply column names to the data 

3. Bind features, activity and subject dataframes together to form two data sets test and train

4. Bind test data and train data together

5. Get Column names of features with mean() and std() in their names

6. Put Column Names of features and response for extract

7. Extract required features

8. Write data file of extracted data (Containing only mean and std columns)<br>
`output_means_extracted.txt`

9. Group and split data by activity and further by subject

10. Calculate means using `sapply`

11. Transpose Matrix, add activity\_label and subject\_no columns

12. Tidy up data and Write data file of mean and std columns when grouped by activity and subject<br>
`output_means_by_activity_subject.txt`