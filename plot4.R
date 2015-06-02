#
# DATA LOCATION
#
datafile = "./household_power_consumption.txt"

#
# OUTPUT LOCATION
#
outfile = "./plot4.png"

# Read everything
hpc_all <- read.csv(datafile,
                    nrows = -1,
                    sep = ";", 
                    colClasses = c("character",
                                   "character",
                                   "numeric",
                                   "numeric",
                                   "numeric",
                                   "numeric",
                                   "numeric",
                                   "numeric",
                                   "numeric"),
                    na.strings = "?")

# subset to July 1&2, 2007
hpc_set <- hpc_all[hpc_all$Date == "1/2/2007"|hpc_all$Date == "2/2/2007",]

# remove the largest item from memory
rm("hpc_all")

# create a column with the date in R date format
dt <- hpc_set[["Date"]]
tm <- hpc_set[["Time"]]
dttm <- paste(dt,tm)
datetime <- strptime(dttm,format = "%d/%m/%Y %H:%M:%S", tz = "GMT")

# add the column to the data set
hpc_set <- cbind(datetime,hpc_set)

# tidy up the work area
rmList <- c("dt","tm","dttm","rmList","datetime")
rm(list = rmList)

# plot 4
# multiple plots (4)
#
png(outfile,width = 480,height = 480)
layout(matrix(1:4,2,2)) 

# upper left time chart
plot(hpc_set$datetime,
     hpc_set$Global_active_power,
     type="l",
     col="black",
     xlab = "",
     ylab = "Global Active Power")

# lower left multiple time chart
plot(hpc_set$datetime,
     hpc_set$Sub_metering_1,
     type="l",
     col="black",
     xlab = "",
     ylab = "Energy sub metering")
lines(hpc_set$datetime,
      hpc_set$Sub_metering_2,
      type="l",
      col="red")
lines(hpc_set$datetime,
      hpc_set$Sub_metering_3,
      type="l",
      col="blue")
cn <- colnames(hpc_set)
lg <- c(cn[8],cn[9],cn[10])
legend("topright",
       lg,
       text.col = "black",
       lty = c(1,1,1),
       col = c("black","red","blue"),
       merge = TRUE,
       bty = "n")

# upper right time chart
plot(hpc_set$datetime,
     hpc_set$Voltage,
     type="l",
     col="black",
     xlab = "datetime",
     ylab = "Voltage")

# upper right time chart
plot(hpc_set$datetime,
     hpc_set$Global_reactive_power,
     type="l",
     col="black",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()