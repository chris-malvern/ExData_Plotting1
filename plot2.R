
## read the data
chunk <- read.table(file, nrows=3500, sep=";", skip=66500, stringsAsFactors=FALSE)	
initial <- read.table(file, nrows=3, sep=";", skip=0, stringsAsFactors=FALSE)		## get 1st few rows
cnames <- as.character(initial[1, ])    						## col names as row 1
names(chunk) <- cnames							## use for col names
chunk <- chunk[-1, ]							## delete row 1
logic <- (chunk$Date=='1/2/2007' | chunk$Date=='2/2/2007')			## logical vector for subset
data <- chunk[logic, ]							## just the 2 days we want

## rejig date-time
data$Date <- strptime(paste(data$Date, data$Time, sep=" "), '%d/%m/%Y %H:%M:%S')

with(data, plot(Date,Global_active_power, ylab='Global Active Power (kilowatts)', xlab="", type='l', cex.axis=0.7, cex.lab=0.7))
dev.copy(png, file="plot2.png", width=4.8, height=4.8, units="in", res=100)
dev.off()
