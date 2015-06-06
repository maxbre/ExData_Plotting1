# set wd, change accordingly!
mywd<-"."
setwd(mywd)

# download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="dataset_local.zip")
# please eventually consider using the method "curl" (depending on the system in use)
# download.file(url, destfile="dataset_local.zip", method="curl")
unzip("dataset_local.zip")

# read data into a df
hdata<-read.table("household_power_consumption.txt", header=TRUE, sep=";",
           na.strings="?", stringsAsFactors=FALSE)

# data munging: fomat date, select range, create new variable
hdata$Date<-as.Date(hdata$Date, format="%d/%m/%Y")
sel<-hdata[hdata$Date>="2007-02-01" & hdata$Date<="2007-02-02",]
sel$timestamp<-as.POSIXct(paste(sel$Date, sel$Time), "%Y-%m-%d %H:%M:%S", tz="GMT")

# look at data
head(sel)
summary(sel)
str(sel)

# store locale
mylocale <- Sys.getlocale('LC_TIME')
# turn off locale-specific
Sys.setlocale('LC_TIME', 'C')

# plot 4

png(filename="./plot4.png")

par(mfrow=c(2,2))

plot(sel$timestamp, sel$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="")

plot(sel$timestamp, sel$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")

plot(sel$timestamp, sel$Sub_metering_1, type="l", 
     ylab="Energy sub metering",
     xlab="", lwd=1)

lines(sel$timestamp, sel$Sub_metering_2, col="red", lwd=1)

lines(sel$timestamp, sel$Sub_metering_3, col="blue", lwd=1)

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", cex=0.8)

plot(sel$timestamp, sel$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

dev.off()

# restore locale    
Sys.setlocale('LC_TIME', mylocale)

