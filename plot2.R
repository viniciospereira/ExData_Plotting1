# This code was created to simply to examine how household energy usage varies over a 2-day period in February, 2007.
# Code developed by Vinicios Pereira.


# Downloading the data.

# Checks if data directory exists, if not creates it.
if(!file.exists("./data")){dir.create("./data")}
# Assigns the URL of the collection data to a variable.
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Downloads the data to data dorectory if the file doesn't exist.
if(!file.exists("./data/exdata-data-household_power_consumption.zip")) {
     download.file(dataUrl, "./data/exdata-data-household_power_consumption.zip", method = "curl")
}
# Store the date when the file was downloaded.
dateDownloaded <- date()


# Reading the data from the zip file.

# Reads the file "household_power_consumption.txt" inside the file "exdata-data-household_power_consumption.zip".
zipFilePath <- "./data/exdata-data-household_power_consumption.zip"
dataFileTxtPath <- "household_power_consumption.txt"
houseHoldPower <- read.table(unz(zipFilePath, dataFileTxtPath), header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Converts the variable "Time" to date format.
houseHoldPower$Time <- strptime(paste(houseHoldPower$Date, houseHoldPower$Time), format = "%d/%m/%Y %H:%M:%S")

# Converts the variable "Date" to date format.
houseHoldPower$Date <- strptime(houseHoldPower$Date, format = "%d/%m/%Y")

# Subsets observations made in 2007-02-01 and 2007-02-02.
houseHoldPower <- subset(houseHoldPower, Date == "2007-02-01" | Date == "2007-02-02")

# Converts the variable Global_active_power to numeric.
houseHoldPower$Global_active_power <- as.numeric(houseHoldPower$Global_active_power)


# Plotting the graph.

# Opens PNG file.
png(filename = "plot2.png", width = 480, height = 480)

# Plots the graph.
plot(houseHoldPower$Time, houseHoldPower$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

# Closes the file.
dev.off()