if (!file.exists("household_power_consumption.txt")) {
  URL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile="./household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

## Read in data from only two dates
hpc <- subset(read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c(rep('character', 2), rep('numeric', 7)), na.strings="?"), Date=="1/2/2007" | Date=="2/2/2007")

##Open png device
png(file="plot3.png")

## Make histogram
hist(hpc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

#Close png file device
dev.off()