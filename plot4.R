#
# Assumes the R script is at the level of the data file
# 
dataFile <- "household_power_consumption.txt"
myData <- read.table(dataFile,header=TRUE,sep=";",na.string="?")
cleanData <- myData[complete.cases(myData),]
cleanData$Date <- as.Date(cleanData$Date,format="%d/%m/%Y")
plotData1 <- cleanData[((cleanData$Date - as.Date("2007-02-01")) == 0),]
plotData2 <- cleanData[((cleanData$Date - as.Date("2007-02-02")) == 0),]
plotData <- rbind(plotData1,plotData2)
plotData$Time <- strptime(paste(plotData$Date,plotData$Time),"%Y-%m-%d %H:%M:%S")
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))
# plot 1
with(plotData, {
  plot(Time,Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")
  axis.Date(1,at=Time[1],max(2),"days")
})
# plot 2
with(plotData, {
  plot(Time,Sub_metering_1,ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)),type="n",xlab="",ylab="Energy sub metering")
  points(Time,Sub_metering_1,type="l",col="black")
  points(Time,Sub_metering_2,type="l",col="red")
  points(Time,Sub_metering_3,type="l",col="blue")
  axis.Date(1,at=Time[1],max(2),"days")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),col=c("black","red","blue"))
})
# plot 3
with(plotData, {
  plot(Time,Voltage,xlab="datetime",ylab="Voltage",type="l")
  axis.Date(1,at=Time[1],max(2),"days")
})
# plot 4
with(plotData, {
  plot(Time,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
  axis.Date(1,at=Time[1],max(2),"days")
})
dev.off()