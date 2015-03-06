
## read the data
chunk <- read.table(file, nrows=3500, sep=";", skip=66500, stringsAsFactors=FALSE)	
initial <- read.table(file, nrows=3, sep=";", skip=0, stringsAsFactors=FALSE)		## get 1st few rows
cnames <- as.character(initial[1, ])    						## still has col names as row 1
names(chunk) <- cnames							## use for col names
chunk <- chunk[-1, ]							## delete row 1
logic <- (chunk$Date=='1/2/2007' | chunk$Date=='2/2/2007')			## logical vector for subset
data <- chunk[logic, ]							## just the 2 days we want

## rejig date-time
data$Date <- strptime(paste(data$Date, data$Time, sep=" "), '%d/%m/%Y %H:%M:%S')

png(filename="plot3.png", width=480, height=480, bg='white')

with(data, { plot(Date,Sub_metering_1, ylab="Energy sub metering", xlab="", type="n", cex.axis=0.7)
              lines(Date,Sub_metering_1, ylab="", xlab="", type='l', col="black")
              lines(Date,Sub_metering_2, ylab="", xlab="", type='l', col="red")
              lines(Date,Sub_metering_3, ylab="", xlab="", type='l', col="blue")
              legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6)
} )

##dev.copy(png, file="plot3.png", width=4.8, height=4.8, units="in", res=100)
dev.off()
