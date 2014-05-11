# Default settings
windows.options(width=480, height=480)
dev.new(480,480)
par(pin=c(2,2))
Sys.setlocale("LC_TIME","English")
# Read and process data
temp<-read.csv("./household_power_consumption.txt",sep=";")
temp$Date<-as.Date(strptime(temp$Date,"%d/%m/%Y"))
# Extract only required rows
newdat<-temp[temp$Date>=as.Date(strptime("01/02/2007","%d/%m/%Y")) & temp$Date<=as.Date(strptime("02/02/2007","%d/%m/%Y")),]
newdat$Global_active_power<-as.numeric(gsub("\\?","NA",newdat$Global_active_power))
# Merge date and time
y<-paste(as.character(newdat$Date),as.character(newdat$Time))
y<-strptime(y,"%Y-%m-%d %H:%M:%S")
newdat<-cbind(newdat,y)
# Process plot data
newdat$Sub_metering_3 <- as.numeric(as.character(newdat$Sub_metering_3))
newdat$Sub_metering_1 <- as.numeric(as.character(newdat$Sub_metering_1))
newdat$Sub_metering_2 <- as.numeric(as.character(newdat$Sub_metering_2))
newdat$Voltage <- as.numeric(as.character(newdat$Voltage))
newdat$Global_reactive_power <- as.numeric(as.character(newdat$Global_reactive_power))
newdat$Global_active_power<-as.numeric(gsub("\\?","NA",as.character(newdat$Global_active_power)))
# Plot data
par(mfrow=c(2,2))
plot(newdat$Global_active_power~newdat$y,typ="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(newdat$y,newdat$Voltage,ylab="Voltage",xlab="datetime",lwd=1,typ="l")
plot(newdat$y,newdat$Sub_metering_1,xlab="",ylab="Energy sub metering",typ="l",col="black")
lines(newdat$y,newdat$Sub_metering_3,typ="l",col="blue")
lines(newdat$y,newdat$Sub_metering_2,typ="l",col="red")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, col=c("black","red","blue"),cex=0.5)
plot(newdat$y,newdat$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",lwd=1,typ="l")
# Save data to file
dev.copy(png,"plot4.png")
dev.off()