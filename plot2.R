#
# DATA LOCATION
#
datafile = "./household_power_consumption.txt"

#
# OUTPUT LOCATION
#
outfile = "./plot2.png"

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

# plot 2
# time chart, on variable
# global active power
#
png(outfile,width = 480,height = 480)
plot(hpc_set$datetime,
     hpc_set$Global_active_power,
     type="l",
     col="black",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()