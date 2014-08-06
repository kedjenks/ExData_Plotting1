
# Read in data 
column_classes = c("character","factor","numeric","numeric","numeric","numeric","numeric",
                   "numeric", "numeric")
data <- read.table("household_power_consumption.txt", sep=";", comment.char="",
                    nrows = 2100000, header=TRUE,colClasses=column_classes,na.strings="?")
                    #nrows = 100, header = TRUE,colClasses=column_classes,na.strings="?")

# Convert date columns
data$Date<- as.Date(data$Date,format ="%d/%m/%Y")

# Only interested in data between 2007-02-01 and 2007-02-02
data_subset <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Merge Date and Time Into One Item
Date_Time <- strptime(paste(data_subset$Date,data_subset$Time),format="%Y-%m-%d %H:%M:%S")
data_subset <- cbind(Date_Time,data_subset)

# Plot Energy sub-metering (y-axis) vs Date(x-axis) to PNG
library(datasets)
png(filename = "plot3.png", width = 480, height = 480)

with(data_subset,
     plot(Date_Time,Sub_metering_1, type="l",
          ylab = "Energy sub metering", xlab = NA))
with(data_subset, 
     points(Date_Time,Sub_metering_2,type="l", col="red"))
with(data_subset, 
     points(Date_Time,Sub_metering_3,type="l", col="blue"))

# Create legend
legend("topright", col = c("black","red","blue"), lty=c(1,1,1), lwd=c(2,2,2), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()