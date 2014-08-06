
# Read in data 
column_classes = c("character","factor","numeric","numeric","numeric","numeric","numeric",
                   "numeric", "numeric")
data <- read.table("household_power_consumption.txt", sep=";", comment.char="",
                    nrows = 2100000, header=TRUE,colClasses=column_classes,na.strings="?")
                    #nrows = 100, header = TRUE,)
                  
# Convert date columns
data$Date<- as.Date(data$Date,format ="%d/%m/%Y")

# Only interested in data between 2007-02-01 and 2007-02-02
data_subset <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Plot Global Active Power histogram to PNG
library(datasets)
png(filename = "plot1.png", width = 480, height = 480)
hist(data_subset$Global_active_power, 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")
dev.off()