###Getting and Cleaning Data Course Project

1. Download data from the following URL<br>
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Extract the .zip and place it in the same directory as `run_analysis.R`<br>
   `unzip "UCI HAR Dataset.zip”`

3. Rename the data folder to UCI\_HAR\_Dataset<br>
   `mv "UCI HAR Dataset" UCI_HAR_Dataset`

4. In R console use `setwd()` to change directory to the one with `run_analysis.R`

5. In R console `source("run_analysis.R")`

6. Output Data files will be created in the working directory<br>

 **Step 2 Output**   <br>
 Data extract of mean and standard deviation columns<br>
 `output_mean_std_extracted.txt` <br><br>
 **Step 5 Output**   <br>
 Means of mean and std columns when grouped by activity and subject<br>
 `output_means_by_activity_subject.txt` <br>
####Original Data Source
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones