urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
nameFile <- "household_power_consumption.txt"

if (!exists("dataFrame")) {
        temp <- tempfile()
        download.file(url=urlFile, temp, method="curl")
        downloadDate <- date()
        con <- unz(temp, nameFile)
        dataFrame <- read.csv(con, sep=";", header = TRUE)
        dataFrame$Time <- strptime(
                paste(levels(dataFrame$Date)[as.numeric(dataFrame$Date)], 
                      levels(dataFrame$Time)[as.numeric(dataFrame$Time)]), 
                format="%d/%m/%Y %H:%M:%S")
        dataFrame$Date <- as.Date(
                levels(dataFrame$Date)[as.numeric(dataFrame$Date)], 
                format="%d/%m/%Y")
        
        dataFrame<- with(dataFrame, 
                         subset(dataFrame, Date >= as.Date("2007-02-01") 
                                & Date <= as.Date("2007-02-02") ))
}

png(filename="plot2.png", width=480, height=480)  # Open PNG device


plot(dataFrame$Time , dataFrame$Global_active_power, type="n", 
     ylab="Global Active Power (kilowatts)", xlab="")
lines(dataFrame$Time , dataFrame$Global_active_power)

dev.off()
