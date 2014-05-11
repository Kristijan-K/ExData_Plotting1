# Default settings
Sys.setlocale("LC_TIME","English")
windows.options(width=480, height=480)
# Read and process data
temp<-read.csv("./household_power_consumption.txt",sep=";")
temp$Date<-as.Date(strptime(temp$Date,"%d/%m/%Y"))
# Extract only required rows
newdat<-temp[temp$Date>=as.Date(strptime("01/02/2007","%d/%m/%Y")) & temp$Date<=as.Date(strptime("02/02/2007","%d/%m/%Y")),]
newdat$Global_active_power<-as.numeric(gsub("\\?","NA",as.character(newdat$Global_active_power)))
# Plot data
hist(newdat$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power",col="red")
# Save plot to file
dev.copy(png,"plot1.png")
dev.off()