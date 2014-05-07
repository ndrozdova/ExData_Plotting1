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

## Create graph 4 and save it as a png image
png(filename = "figure/plot4.png", width = 480, height = 480, units = "px", bg = "transparent", antialias="cleartype")

## Cpecify global parameters
par(mfrow = c(2,2), mar = c(4,4,2,2),cex = 0.9)

## Plot 1
plot(d$DateTime, d$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")

## Plot 2
plot(d$DateTime,d$Voltage, type="l", ylab = "Voltage", xlab = "")

## Plot 3
plot(d$DateTime, y1, type="l", ylim = range(c(y1,y2,y3)), ylab = "Energy sub metering", xlab = "")
par(new = T)
plot(d$DateTime,y2, type="l", ylim = range(c(y1,y2,y3)), col = "red", ylab = "", xlab = "")
par(new = T)
plot(d$DateTime,y3, type="l", ylim = range(c(y1,y2,y3)), col = "blue", ylab = "", xlab = "")
legend("topright", bty = "n", lty=c(1,1,1), cex = 0.9, col = c("black","red", "blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Plot 4
par(new = F)
plot(d$DateTime,d$Global_reactive_power, type="l", xlab = "")

## Close printing device
dev.off()
