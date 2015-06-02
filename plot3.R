#
# DATA LOCATION
#
datafile = "./household_power_consumption.txt"

#
# OUTPUT LOCATION
#
outfile = "./plot3.png"

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

# plot 3
# time chart, multiple variables
# submetering
#
png(outfile,width = 480,height = 480)
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
       merge = TRUE)
dev.off()