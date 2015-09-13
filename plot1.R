#install.packages('dplyr')

library(dplyr) ## This is necessary to use the filter function

# SET WORKING DIRECTORY
setwd("~/datascience/exploratory_data")

# READ DATA AND TRUNCATE THE RECORD SET TO ONLY USE 2007-02-01 AND 2007-02-02
powerData <- read.table("../household_power_consumption.txt", sep=";", header = TRUE)
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerDataSubset <- filter(powerData, powerData$Date >= as.Date("2007-02-01 00:00:00") & powerData$Date <= as.Date("2007-02-02 00:00:00"))

# MAKE THE ACTIVE POWER DATA A NUMBER SO IT CAN BE GRAPHED
Global_active_power <- as.numeric(as.character(powerDataSubset$Global_active_power))

# PLOT THE GRAPH AND SAVE IT TO A PNG FILE
hist(Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col = "red")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()