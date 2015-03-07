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
png(file="plot1.png",width=480,height=480)
hist(plotData$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()