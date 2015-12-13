# Read the file into R
# fread is faster that data.table, which is important given the size of this file
data <- fread("household_power_consumption.txt", sep = ";")

# Convert the date to a date format and subset the dataset
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
data1 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Create a separate variable with the date and time and convert it to a useable format
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

#Create the plot
par(mfrow = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(data1$Global_active_power ~ data1$Datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", ylim = c(0,6))
plot(data1$Voltage ~ data1$Datetime, type = "l", xlab = "datetime", ylab = "Voltage")

plot(data = data1, Sub_metering_1~Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
lines(data = data1, Sub_metering_2~Datetime,col='Red')
lines(data = data1, Sub_metering_3~Datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data1$Global_reactive_power ~ data1$Datetime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()