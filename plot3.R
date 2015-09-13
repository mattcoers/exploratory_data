#install.packages('dplyr')

library(dplyr) ## This is necessary to use the filter function

# SET WORKING DIRECTORY
setwd("~/datascience/exploratory_data")

# READ DATA AND TRUNCATE THE RECORD SET TO ONLY USE 2007-02-01 AND 2007-02-02
powerData <- read.table("../household_power_consumption.txt", sep=";", header = TRUE)
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerDataSubset <- filter(powerData, powerData$Date >= as.Date("2007-02-01") & powerData$Date <= as.Date("2007-02-02"))

# CREATE THE TIMESERIES DATA
powerDataSubset$DateTime <- do.call(paste, c(powerDataSubset[c("Date","Time")], sep=" "))
powerDataSubset$DateTime <- strptime(powerDataSubset$DateTime, format="%Y-%m-%d %H:%M:%S")
powerDataSubset$Global_active_power <- as.numeric(as.character(powerDataSubset$Global_active_power))
powerDataSubset$Sub_metering_1 <- as.numeric(as.character(powerDataSubset$Sub_metering_1))
powerDataSubset$Sub_metering_2 <- as.numeric(as.character(powerDataSubset$Sub_metering_2))
powerDataSubset$Sub_metering_3 <- as.numeric(as.character(powerDataSubset$Sub_metering_3))

# PLOT THE GRAPH AND SAVE IT TO THE FILE
plot(powerDataSubset$DateTime, powerDataSubset$Global_active_power, type="n", ylab="Energy sub metering", xlab="") # Create a blank plot
lines(powerDataSubset$DateTime, powerDataSubset$Sub_metering_1, col = "black") # This plots only the male points and makes them green
lines(powerDataSubset$DateTime, powerDataSubset$Sub_metering_2, col = "red") # This plots only the male points and makes them green
lines(powerDataSubset$DateTime, powerDataSubset$Sub_metering_3, col = "blue") # This plots only the male points and makes them green
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()