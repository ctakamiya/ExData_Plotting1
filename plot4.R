urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
nameFile <- "household_power_consumption.txt"

if (!exists("dataFrame")) {
        temp <- tempfile()
        download.file(url=urlFile, temp, method="curl")
        downloadDate <- date()
        con <- unz(temp, nameFile)
        dataFrame <- read.csv(con, sep=";", header = TRUE, 
                              colClasses=rep("factor",9))
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

png(filename="plot4.png", width=480, height=480)  # Open PNG device

par(mfcol=c(2,2))


# plot pos=(1,1)
plot(dataFrame$Time , dataFrame$Global_active_power, type="n", 
     ylab="Global Active Power", xlab="")
lines(dataFrame$Time , dataFrame$Global_active_power)


# plot pos=(2,1)
sub_met1<- levels(dataFrame$Sub_metering_1)[as.numeric(dataFrame$Sub_metering_1)]
sub_met2<- levels(dataFrame$Sub_metering_2)[as.numeric(dataFrame$Sub_metering_2)]
sub_met3<- levels(dataFrame$Sub_metering_3)[as.numeric(dataFrame$Sub_metering_3)]
 
plot(dataFrame$Time , dataFrame$Global_active_power, type="n", 
     ylab="Global Active Power", xlab="",ylim=c(0,40))
lines(dataFrame$Time , sub_met1, col="black")
lines(dataFrame$Time , sub_met2, col="red")
lines(dataFrame$Time , sub_met3, col="blue")

legend("topright", lty = c(1,1,1), col=c("black", "red", "blue"), bty = "n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# plot pos=(1,2)
plot(dataFrame$Time , dataFrame$Voltage, 
     type="n", 
     ylab="Voltage", xlab="datetime")
lines(dataFrame$Time , dataFrame$Voltage)


# plot pos=(2,2)
plot(dataFrame$Time , dataFrame$Global_reactive_power, 
     type="n", 
     ylab="Global_reactive_power", xlab="datetime")
lines(dataFrame$Time , dataFrame$Global_reactive_power)


dev.off()