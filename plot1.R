# set wd, change accordignly!
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

#plot 1

png(filename="./plot1.png")

hist(sel$Global_active_power, col="darkorange", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)"
     )

dev.off()

# restore locale    
Sys.setlocale('LC_TIME', mylocale)

