# Keeping these functions for future reference.  Didn't work in this example, but 
# may be handy later
#
#setClass('myDate')
#setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
#setClass('myTime')
#setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S") )

#
# DATA LOCATION
#
datafile = "./household_power_consumption.txt"

#
# OUTPUT LOCATION
#
outfile = "./plot1.png"

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

# plot 1
# histogram
# global active power
#
png(outfile,width = 480,height = 480)
hist(hpc_set$Global_active_power,
     xlim = range(0:6), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     breaks = "Sturges", 
     xaxt="n")
axis(side=1, at=seq(0,6,2))
dev.off()