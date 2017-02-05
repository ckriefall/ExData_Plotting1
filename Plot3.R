# clear environment variables
rm(list=ls())

#set working directory
setwd("~/RData/household_power_consumption")

# load some useful libraries
library("dplyr", lib.loc="~/R/win-library/3.3")
library(readr)
library("lubridate", lib.loc="~/R/win-library/3.3")

# load from the dataset from working directory
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
twoday_household <- filter(household_power_consumption,between(dmy(Date),mdy("2/1/2007"),mdy("2/2/2007")))

# memory management
rm("household_power_consumption")

# combine Date and Time into a new column called DateTime
twoday_household$DateTime <- dmy(twoday_household$Date)+seconds(twoday_household$Time)

layout(matrix(1:1, ncol = 1))

#plot 3 Sub Metering Over Time
# need these all on the same graph, sharing X access
png(filename="Plot3.png",height = 480,width = 480)
plot(twoday_household$DateTime,twoday_household$Sub_metering_1,type="l",col="gray",xlab="",ylab="Energy Sub Metering")
lines(twoday_household$DateTime,twoday_household$Sub_metering_2,type="l",col="red")
lines(twoday_household$DateTime,twoday_household$Sub_metering_3,type="l",col="blue")
legend("topright", legend = c("Sub Metering 1","Sub Metering 2","Sub Metering 3"), col=c("gray","red","blue"), lty=1)
dev.off()

