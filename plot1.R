temp<-read.csv("./household_power_consumption.txt",sep=";")
temp$Date<-as.Date(strptime(temp$Date,"%d/%m/%Y"))
newdat<-temp[temp$Date>=as.Date(strptime("01/02/2007","%d/%m/%Y")) & temp$Date<=as.Date(strptime("02/02/2007","%d/%m/%Y")),]
newdat$Global_active_power<-as.numeric(gsub("\\?","NA",newdat$Global_active_power))
hist(newdat$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power",col="red")
dev.copy(png,"plot1.png")
dev.off()