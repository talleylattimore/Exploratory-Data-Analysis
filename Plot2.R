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
plot(data1$Global_active_power ~ data1$Datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", ylim = c(0,6))

# Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()