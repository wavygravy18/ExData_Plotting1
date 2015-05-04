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
png(file="plot2.png")

##Create line graph
plot(hpc$datetime, hpc$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(hpc$datetime, hpc$Global_active_power, type="l")

#Close png file device
dev.off()