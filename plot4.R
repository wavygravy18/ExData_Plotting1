if (!file.exists("household_power_consumption.txt")) {
  URL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile="./household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

## Read in data from only two dates
hpc <- subset(read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c(rep('character', 2), rep('numeric', 7)), na.strings="?"), Date=="1/2/2007" | Date=="2/2/2007")

## Load lubridate, format dates and time and create datetime column
library(lubridate)
hpc$datetime <- dmy_hms(paste(hpc$Date, hpc$Time))

##Open png device
png(file="plot4.png")

par(mfrow = c(2,2))
with(hpc, {
  ##First plot
  plot(hpc$datetime, hpc$Global_active_power, type="n", xlab="", ylab="Global Active Power")
  lines(hpc$datetime, hpc$Global_active_power, type="l")
  ##Second plot
  plot(hpc$datetime, hpc$Voltage, xlab="datetime", ylab="Voltage", type="n")
  lines(hpc$datetime, hpc$Voltage, type="l")
  ##Third plot
  plot(hpc$datetime, hpc$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(hpc$datetime, hpc$Sub_metering_1, type="l")
  lines(hpc$datetime, hpc$Sub_metering_2, type="l", col="red")
  lines(hpc$datetime, hpc$Sub_metering_3, type="l", col="blue")
  legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  ##Forth plot
  plot(hpc$datetime, hpc$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n")
  lines(hpc$datetime, hpc$Global_reactive_power, type="l")
})

##Close png file device
dev.off()