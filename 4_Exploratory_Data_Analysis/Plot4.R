library(datasets)

##reading data
filepath <- "./exdata-data-household_power_consumption/household_power_consumption.txt"
ds <- read.table(text = grep("^[1,2]/2/2007", readLines(filepath), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE,na.strings = "?")

## Converting dates
ds$Datetime <- as.POSIXct(strptime(paste(ds$Date, ds$Time), "%d/%m/%Y %H:%M:%S"))

##  Open the PNG graphics device to create a file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

## Generating Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(ds, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

#Closing the device
dev.off()

