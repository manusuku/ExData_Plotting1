# To Run the script:
# Download "household_power_consumption.txt" to ./data folder under working directory
# Please install if not already installed: install.packages("sqldf")
# Run the script as: source("plot2.R")

library(sqldf)

# Read records for 1/2/2007 & 2/2/2007
power<-read.csv.sql("./data/household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";" )

# Close conenctions
closeAllConnections()

# combine date-time as new column.
power$date.time<-strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")

par(mfrow =c(1,1))

# Create plot
with(power, plot(date.time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
with(power, points(date.time, Sub_metering_1, type="l", col="black"))
with(power, points(date.time, Sub_metering_2, type="l", col="red"))
with(power, points(date.time, Sub_metering_3, type="l", col="blue"))
legend("topright", pch=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# copy same plot to PNG file under working folder
dev.copy(png, file="plot3.png", width = 480, height = 480, units = "px")

# close devices and exit.
dev.off()
