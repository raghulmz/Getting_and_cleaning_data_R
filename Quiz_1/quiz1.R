setwd("../../..//Coursera/Data Science Specialization - John Hopkins University/Getting and Cleaning Data/R/Quiz_1/")

library("XML")
library("xlsx")
library("jsonlite")
#library("dplyr")

#Q1

data1<-read.csv(file = "getdata-data-ss06hid.csv",header=T)
names(data1)
unique(data1$VAL)
length(data1$VAL[which(data1$VAL==24)])

#Q2
data1$FES

#Q3

dat<-read.xlsx("getdata-data-DATA.gov_NGAP.xlsx",
               sheetIndex=1,
               rowIndex=18:23,
               colIndex=7:15)

sum(dat$Zip*dat$Ext,na.rm=T)

#Q4
fileURL<- "./getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL,useInternalNodes = T) 
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]][[1]][[2]]

xmlSApply(rootNode,xmlValue)
zipcodes<-xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcodes[zipcodes==21231])

#Q5
library(data.table)
DT<-fread("./getdata-data-ss06pid.csv")


system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time({mean(DT[DT$SEX==1,]$pwgtp15)
            mean(DT[DT$SEX==2,]$pwgtp15)})
system.time({rowMeans(DT)[DT$SEX==1]
             rowMeans(DT)[DT$SEX==2]})
system.time(DT[,mean(pwgtp15),by=SEX])
