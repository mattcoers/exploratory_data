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

# PLOT THE GRAPH AND SAVE IT TO THE FILE
plot(powerDataSubset$DateTime, powerDataSubset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()