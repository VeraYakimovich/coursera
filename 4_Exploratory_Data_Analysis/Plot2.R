library(datasets)

##reading data
filepath <- "./exdata-data-household_power_consumption/household_power_consumption.txt"
ds <- read.table(text = grep("^[1,2]/2/2007", readLines(filepath), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE,na.strings = "?")

## Converting dates
ds$Datetime <- as.POSIXct(strptime(paste(ds$Date, ds$Time), "%d/%m/%Y %H:%M:%S"))

#  Open the PNG graphics device to create a file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

## Generating Plot 2
plot(ds$Global_active_power ~ ds$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

#Closing the device
dev.off()
