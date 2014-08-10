
urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
nameFile <- "household_power_consumption.txt"

if (!exists("dataFrame")) {
        temp <- tempfile()
        download.file(url=urlFile, temp, method="curl")
        downloadDate <- date()
        con <- unz(temp, nameFile)
        dataFrame <- read.csv(con, sep=";", header = TRUE)
        dataFrame$Date <- as.Date(
                levels(dataFrame$Date)[as.numeric(dataFrame$Date)], 
                format="%d/%m/%Y")
        dataFrame$Time <- strptime(
                     levels(dataFrame$Time)[as.numeric(dataFrame$Time)], 
                     format="%H:%M:%S")
        dataFrame<- with(dataFrame, 
                         subset(dataFrame, Date >= as.Date("2007-02-01") 
                                & Date <= as.Date("2007-02-02") ))
}

png(filename="plot1.png", width=480, height=480)  # Open PNG device

# Preparing data to Histogram
idx <- as.numeric(dataFrame$Global_active_power[dataFrame$Global_active_power != "?"])
dataPlot <- as.numeric(levels(dataFrame$Global_active_power)[idx])


hist(dataPlot, xlab="Global Active Power (kilowatts)", 
     main= "Global Active Power", col="red")
dev.off()
