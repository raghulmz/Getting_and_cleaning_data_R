
#File path variables
train_X_file= "./UCI_HAR_Dataset/train/X_train.txt"
test_X_file= "./UCI_HAR_Dataset/test/X_test.txt"
train_Y_file= "./UCI_HAR_Dataset/train/Y_train.txt"
test_Y_file= "./UCI_HAR_Dataset/test/Y_test.txt"
train_subject_file= "./UCI_HAR_Dataset/train/subject_train.txt"
test_subject_file= "./UCI_HAR_Dataset/test/subject_test.txt"
features_file= "./UCI_HAR_Dataset/features.txt"
activity_label_file= "./UCI_HAR_Dataset/activity_labels.txt"

output_means_extracted = "./output_means_by_activity_subject.txt"
output_mean_std_extracted = "output_mean_std_extracted.txt"

#Read data
X_train<-read.table(train_X_file)
X_test<-read.table(test_X_file)

Y_train<-read.table(train_Y_file)
Y_test<-read.table(test_Y_file)

train_subject<-read.table(train_subject_file)
test_subject<-read.table(test_subject_file)

features<-read.table(features_file)
activity_label<-read.table(activity_label_file)

#Apply Column Names

names(X_train)<-features[,2]
names(X_test)<-features[,2]
names(Y_train)<-"activity_no."
names(Y_test)<-"activity_no."
names(train_subject)<-"subject_no."
names(test_subject)<-"subject_no."
names(activity_label)<-c("activity_no.","activity_label")

#Bind features, activity and subject dataframes
test_df<-cbind(X_test,Y_test,test_subject)
train_df<-cbind(X_train,Y_train,train_subject)

#Bind test data and train data

data<-rbind(train_df,test_df)

#Get Column names of features with mean() and std() in their names

required_features<-c(
  grep("mean()",x = features[,2], value = T),
  grep("std()", x = features[,2], value = T)
  )

# Column Names of features and response for extract

extract_names<-c("activity_no.","subject_no.",required_features)

# Extract required features

data_extract<-data[,extract_names]

#Use descriptive activity names to name the activities in the data set

data_extract<-merge(activity_label, data_extract, by.x = "activity_no.", by.y = "activity_no.",)

#Write data file of extracted data (Containing only mean and std columns)

write.table(file= output_mean_std_extracted, x = data_extract, row.names = F)

#Split data by activity and further by subject
data_extract_split<-split(data_extract,list(data_extract$activity_label,data_extract$subject_no.))

# Calculate means using sapply
data_extract_means<-sapply(
  data_extract_split,
  function(x) {
    colMeans(x[,!names(x) %in% c("activity_no.", "activity_label", "subject_no.")])
  }
  )

#Transpose Matrix
data_extract_means<-t(data_extract_means)

#Add activity_label and subject_no columns
#Initialize columns
data_extract_means<-cbind(
  vector(mode="integer",length=nrow(data_extract_means)),
  vector(mode="character",length=nrow(data_extract_means)),
  data_extract_means
  )
colnames(data_extract_means)[c(1,2)]<-c("subject_no.","activity_label")

#Tidy up data

add_label<-function(x) {
  for(i in rownames(x)) {
    x[i,c(2,1)]<-tolower(strsplit(x = i, split = "\\.")[[1]])
  }
  x
}

data_extract_means<-add_label(data_extract_means)

write.table(file= output_means_extracted, x = data_extract_means, row.names = F)
