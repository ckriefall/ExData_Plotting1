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
#plot 1 Frequency Over Global Active Power
png(filename="Plot1.png",height = 480,width = 480)
hist(twoday_household$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")
dev.off()

