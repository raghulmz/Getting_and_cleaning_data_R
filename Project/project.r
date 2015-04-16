
#File path variables
train_X_file= "./UCI_HAR_Dataset/train/X_train.txt"
test_X_file= "./UCI_HAR_Dataset/test/X_test.txt"
train_Y_file= "./UCI_HAR_Dataset/train/Y_train.txt"
test_Y_file= "./UCI_HAR_Dataset/test/Y_test.txt"
train_subject_file= "./UCI_HAR_Dataset/train/subject_train.txt"
test_subject_file= "./UCI_HAR_Dataset/test/subject_test.txt"
features_file= "./UCI_HAR_Dataset/features.txt"
activity_label_file= "./UCI_HAR_Dataset/activity_labels.txt"

output_means_extracted = "./output_means_extracted.txt"

#Read data
X_train<-read.table(train_X_file)
X_test<-read.table(test_X_file)

Y_train<-read.table(train_Y_file)
Y_test<-read.table(test_Y_file)

train_subject<-read.table(train_subject_file)
test_subject<-read.table(test_subject_file)

features<-read.table(features_file)
activity_label<-read.table(activity_label_file)

#Check dimensions of data, set if(T) to run
if(F) {
  dim(X_train)
  dim(X_test)
  dim(Y_train)
  dim(Y_test)
  dim(train_subject)
  dim(test_subject)
  dim(features)
  dim(activity_label)
}

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

#Check dimensions and names of data, set if(T) to run
if(F) {
  dim(test_df)
  dim(train_df)
  names(test_df)
  names(train_df)
}

#Bind test data and train data

data<-rbind(train_df,test_df)

#Check dimensions of data, set if(T) to run
if(F) {dim(data)}

#Get Column names of features with mean() and std() in their names

required_features<-c(
  grep("mean()",x = features[,2], value = T),
  grep("std()", x = features[,2], value = T)
  )

# Column Names of features and response for extract

extract_names<-c("activity_no.","subject_no.",required_features)

# Extract required features

data_extract<-data[,extract_names]

#Check dimensions and names of data_extract, set if(T) to run
if(F) {
  dim(data_extract)
  names(data_extract)
}

#Use descriptive activity names to name the activities in the data set

data_extract<-merge(activity_label, data_extract, by.x = "activity_no.", by.y = "activity_no.",)

#Check dimensions and names of data_extract, set if(T) to run
if(F){
  dim(data_extract)
  names(data_extract)
}

#Split data by activity and further by subject
data_extract_split<-split(data_extract,list(data_extract$activity_label,data_extract$subject_no.))

# Calculate means using sapply
data_extract_means<-sapply(
  data_extract_split,
  function(x) {
    colMeans(x[,names(x)!=c("activity_no.", "activity_label", "subject_no.")])
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
colnames(data_extract_means)[c(1,2)]<-c("Activity","Subject")
add_label<-function(x) {
  for(i in rownames(x)) {
    x[i,c(1,2)]<-tolower(strsplit(x = i, split = "\\.")[[1]])
  }
  x
}

data_extract_means<-add_label(data_extract_means)

if(F) {
  head(data_extract_means[,1:5])
  dim(data_extract_means)
  class(data_extract_means)
}

write.table(file= output_means_extracted, x = data_extract_means, row.names = F)
