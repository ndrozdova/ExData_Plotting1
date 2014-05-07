## Get data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","../data/household_power_consumption.zip")
paste0("Downloaded ", date())
unzip("../data/household_power_consumption.zip")

## Read data into data frame
d<-read.csv("../data/household_power_consumption.txt", header = T, sep = ";", na.string="?", stringsAsFactors = F)
str(d)

## Create a new column of class POSIXlt 
d$DateTime<-paste0(d$Date," ", d$Time)
d$DateTime <- strptime(d$DateTime, "%d/%m/%Y %H:%M:%S")

## Filter data based on a specified criteria
date1<- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
date2<- strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S")
d<-d[(d$DateTime >= date1 & d$DateTime <= date2),]
str(d)

## Create graph 2 and save it as a png image
png(filename = "figure/plot2.png", width = 480, height = 480, units = "px", bg = "transparent", antialias="cleartype")
plot(d$DateTime,d$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Close printing device
dev.off()
