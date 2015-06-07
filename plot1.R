# To Run the script:
# Download "household_power_consumption.txt" to ./data folder under working directory
# Please install if not already installed: install.packages("sqldf")
# Run the script as: source("plot1.R")

library(sqldf)

# Read records for 1/2/2007 & 2/2/2007
power<-read.csv.sql("./data/household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";" )

# Close conenctions
closeAllConnections()

# combine date-time as new column.
power$date.time<-strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")

par(mfrow =c(1,1))

# Create plot
hist(power$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# copy same plot to PNG file under working folder
dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")

dev.off()