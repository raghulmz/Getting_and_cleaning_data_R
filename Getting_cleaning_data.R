setwd()
getwd()

if(!file.exists("data")) {
  dir.create("data")
}

download.file(fileURL,destfile = "./data/cameras.csv",method = "curl")

#Not best way to read large files
read.table("./data/cameras.csv",
           sep = ",",
           header = T,
           skip = 10,
           nrows = 5,
           qoute = "", # dont read qoutes
           na.strings = T)
read.csv("./data/cameras.csv",header = T)

#Excel files
library("XLConnect")
library("xlsx")

read.xlsx("./data/cameras.xslx", sheetIndex = 1,
          colIndex= 2:3,
          rowIndex= 5:45)

#Reading XML
library("XML")

#fileURL<-"http://www.w3schools.com/xml/simple.xml"
fileURL<- "./getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL,useInternalNodes = T) 
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]][[1]][[2]]

xmlSApply(rootNode,xmlValue)
zipcodes<-xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcodes[zipcodes==21231])

#Reading JSON

library("jsonlite")

jsonData<- fromJSON("https://api.github.com/users/jtleek/repos")
toJSON()

#data.frame
#Much faster, written in C
#More memory efficient

library("data.table")

dt<-data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3))
dt[2,]
dt[dt$y=="a",]
dt[3] # subsets rows
dt[,3] # returns 3
dt[,mean(x)] # returns mean of dt$x
dt[,z:=x^4] # add new column z=x^4
dt2<-dt
dt[,z:=3] # Changes both dt and dt2
dt
dt2 
dt<-dt[,z:=x^2]
dt
dt2


#Keys
dt<-data.table(x=rep(c("A","B","C"),each=100),y=rnorm(300))
setkey(dt,x)
dt["A"]
dt["C"]

dt2<-data.table(x=rep(c("A","B","C"),each=100),y=pnorm(300))
setkey(dt2,x)

merge(dt,dt2)

#fast reading
fread(file)

#Getting data from APIs

library(httr)

