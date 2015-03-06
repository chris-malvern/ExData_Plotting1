file='exdata_data_household_power_consumption/household_power_consumption.txt'

## this was code to find which chunk of the db to open..
##seek<-function(file, skip){
##	initial <- read.table(file, nrows=10, skip=skip, sep=";", stringsAsFactors=FALSE)
##	print(initial[5,1])
##}
##skip=65000; enough=FALSE
##while(!enough){ seek(file, skip); print(skip); skip<-skip+500 }

## read the data
chunk <- read.table(file, nrows=3500, sep=";", skip=66500, stringsAsFactors=FALSE)	
initial <- read.table(file, nrows=3, sep=";", skip=0, stringsAsFactors=FALSE)		## get 1st few rows
cnames <- as.character(initial[1, ])    						## still has col names as row 1
names(chunk) <- cnames							## use for col names
chunk <- chunk[-1, ]							## delete row 1
logic <- (chunk$Date=='1/2/2007' | chunk$Date=='2/2/2007')			## logical vector for subset
data <- chunk[logic, ]							## just the 2 days we want

## here's the 1st graph
hist(data$Global_active_power, breaks=12, col='red', xlab='Global Active Power (kilowatts)', ylab='Frequency', main='Global Active Power')
dev.copy(png, file="plot1.png", width=4.8, height=4.8, units="in", res=100)
dev.off()
