# Default settings
windows.options(width=480, height=480)
Sys.setlocale("LC_TIME","English")
# Read and process data
temp<-read.csv("./household_power_consumption.txt",sep=";")
temp$Date<-as.Date(strptime(temp$Date,"%d/%m/%Y"))
# Extract only required rows
newdat<-temp[temp$Date>=as.Date(strptime("01/02/2007","%d/%m/%Y")) & temp$Date<=as.Date(strptime("02/02/2007","%d/%m/%Y")),]
newdat$Global_active_power<-as.numeric(gsub("\\?","NA",newdat$Global_active_power))
# Plot data
y<-paste(as.character(newdat$Date),as.character(newdat$Time))
y<-strptime(y,"%Y-%m-%d %H:%M:%S")
newdat<-cbind(newdat,y)
plot(newdat$Global_active_power~newdat$y,typ="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,"plot2.png")
dev.off()