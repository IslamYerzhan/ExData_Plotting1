#Download data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = T,sep = ";")
unlink(temp)
rm(temp)


data_frame <- as.data.frame(data)



# choose needed date
data1 <- subset(data_frame, data_frame$Date=="1/2/2007" | data_frame$Date=="2/2/2007")

data1$Date <- as.Date(data1$Date, format= "%d/%m/%Y")
data1$Time <- strptime(data1$Time, format= "%H:%M:%S")

rownames(data1) <- 1:nrow(data1)


data1$Time[1:1440] <- format(data1$Time[1:1440],"2007-02-01 %H:%M:%S")
data1$Time[1441:length(data1$Time)] <- format(data1$Time[1441:length(data1$Time)],"2007-02-02 %H:%M:%S")

str(data1)

data1$Global_active_power <- gsub("?","",data1$Global_active_power)
data1$Global_active_power <- as.numeric(data1$Global_active_power)

data1$Sub_metering_1 <- gsub("?","",data1$Sub_metering_1)
data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)

data1$Sub_metering_2 <- gsub("?","",data1$Sub_metering_2)
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)

data1$Sub_metering_3 <- gsub("?","",data1$Sub_metering_3)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)

data1$Voltage <- gsub("?","",data1$Voltage)
data1$Voltage <- as.numeric(data1$Voltage)

data1$Global_reactive_power <- gsub("?","",data1$Global_reactive_power)
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power)


par(mfrow=c(2,2))
plot(x = data1$Time,y = data1$Global_active_power,ylab = "Global Active Power", xlab = "",type = "l")
plot(x=data1$Time,y = data1$Voltage,ylab = "Voltage",xlab = "datetime",type = "l")

plot(x = data1$Time,y = data1$Sub_metering_1,ylab = "Energy sub metering", xlab = "",type = "l",col="black")
lines(x = data1$Time,y = data1$Sub_metering_2, type = "l",col="red")
lines(x = data1$Time,y = data1$Sub_metering_3, type = "l",col="blue")
legend("topright", inset=.02, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1, cex=0.6,box.lty=0)
par(mar= c(5,5,2,2))

plot(x = data1$Time,y = data1$Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power")


### Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()











