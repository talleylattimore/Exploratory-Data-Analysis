# Read the file into R
# fread is faster that data.table, which is important given the size of this file
library(data.table)
data <- fread("household_power_consumption.txt", sep = ";")

# Convert the date to a date format and subset the dataset
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
data1 <- data
data1 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Create a separate variable with the date and time and convert it to a useable format
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

#Create the plot
with(data1, {
  plot(as.numeric(Sub_metering_1) ~ Datetime, type = "l",
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

# Add a legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()