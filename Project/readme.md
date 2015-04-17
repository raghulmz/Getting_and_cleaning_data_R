###Getting and Cleaning Data Course Project

1. Download data from the following URL
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Extract the .zip and place it in the same directory as `run_analysis.R`
   `unzip "UCI HAR Dataset.zip”`

3. Rename the data folder to UCI\_HAR\_Dataset
   `mv UCI HAR Dataset UCI_HAR_Dataset`

4. In R console use `setwd()` to change directory to the one with `run_analysis.R`

5. In R console `source(".run_analysis.R")

6. Output Data files will be created in the working directory
   `output_means_extracted.txt` - Means of mean and std columns when grouped by activity and subject
   `output_mean_std_extracted.txt` - Data extract of mean and std columns

####Original Source Description
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones