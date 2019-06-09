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


###2 nd plot
plot(x = data1$Time,y = data1$Global_active_power,ylab = "Global Active Power(kilowatts)", xlab = "",type = "l")


### Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()



