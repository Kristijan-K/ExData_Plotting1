# Default settings
windows.options(width=480, height=480)
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
# Plot data
plot(newdat$y,newdat$Sub_metering_1,xlab="",ylab="Energy sub metering",typ="l",col="black")
lines(newdat$y,newdat$Sub_metering_3,typ="l",col="blue")
lines(newdat$y,newdat$Sub_metering_2,typ="l",col="red")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, col=c("black","red","blue"))
# Save data to file
dev.copy(png,"plot3.png")
dev.off()