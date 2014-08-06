
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

# Date and Time Into One Item
Date_Time <- strptime(paste(data_subset$Date,data_subset$Time),format="%Y-%m-%d %H:%M:%S")
data_subset <- cbind(Date_Time,data_subset)

# Plot Global Active Power (y-axis) vs Date(x-axis) to PNG
library(datasets)
png(filename = "plot2.png", width = 480, height = 480)

with(data_subset,
     plot(Date_Time,Global_active_power, type="l",
          ylab = "Global Active Power (kilowatts)", xlab = NA))

dev.off()