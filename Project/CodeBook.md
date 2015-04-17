##CodeBook
###Getting and Cleaning Data Course Project

Description of Variables, Data files and the working of the script `run_analysis.R`

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

1. Read data from the following files<br><br>
Training Features - `X_train.txt`<br>
Training Response -`Y_train.txt`<br>
Test Features - `X_test.txt`<br>
Test Response - `Y_test.txt`<br>
Training Subjects - `subject_train.txt`<br>
Test Subjects - `subject_test.txt`<br>
Features (Column Names) - `features_file.txt`<br>
Activity Labels - `activity_label_file.txt`<br>

2. Apply column names (feature names) 

3. Combine (`cbind`) features, activity and subject dataframes together to form two data sets test and train

4. Combine (`rbind`) test data and train data together

5. Get Column Names list of features with “mean()” and “std()” in their names (`grep`)

6. Combine Column Names list with response name

7. Extract required features using the List

8. Write data file of extracted data (Containing mean and std columns)<br>
`output_means_extracted.txt`

9. Group and split data by activity and by subject

10. Calculate means using `sapply`

11. Transpose Matrix, add “activity\_label” and “subject\_no.” columns

12. Tidy up data and Write data file of “means” when grouped by activity and subject<br>
`output_means_by_activity_subject.txt`