
#Goal : examine how the household energy usage varies over a 2 day period in Feb

#Reconstruct the plots with the base plotting system
#Plot file format is a PNG file with a width of 480 pixels and a height of 480 pixels

#Code file should include code for reading the data

#read the data from csv file
#mission values are coded as "?"

destfile <- file.path(".", "2025","household_power_consumption.txt")
data <- read.csv(destfile, sep=";",na.strings="?",colClasses = "character")

#get the dimensions of the dataset
#the dataset has 2,075,259 rows and 9 columns
dim(data)
names(data)


#subset the data from 2007-02-01 and 2007-02-02
#subset the rows with date values 2007-02-01 and 2007-02-02
data_subset <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

#convert the Date and Time variables to Date/Time classes
#strptime() as.Date()
#Combine data and time into a single character string
data_subset$DateTime <- strptime(paste(data_subset$Date, data_subset$Time),
                                 format="%d/%m/%Y %H:%M:%S")

names(data_subset)

# Columns 3 through 9 contain the power, voltage, and metering data
data_subset[, 3:9] <- lapply(data_subset[, 3:9], as.numeric)

#Global Active Power (kilowatts) vs frequency with title "Global Active Power"
#Sampling data (Thu and Fri) vs Global Active Power (kilowatts)
#Energy sub metering (Thu and Fri), legends, Sub_metering_1, Sub_metering_2,Sub_metering_3
#Plot 1, Plot 2, datetime vs voltage, datetime vs Global_reactive_power

#open png device
png("plot3.png",width = 480, height=480)

# 1. Create the base plot with Sub_metering_1 (Black line)
plot(data_subset$DateTime, data_subset$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")

# 2. Add Sub_metering_2 (Red line)
lines(data_subset$DateTime, data_subset$Sub_metering_2, col = "red")

# 3. Add Sub_metering_3 (Blue line)
lines(data_subset$DateTime, data_subset$Sub_metering_3, col = "blue")

# 4. Add the legend in the top-right corner
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1)

# Close the device
dev.off()



