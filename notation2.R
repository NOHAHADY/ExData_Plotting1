
p <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


p[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

p[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

p <- p[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("notation2.png", width=480, height=480)

plot(p[, dateTime], p[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(p[, dateTime], p[, Sub_metering_2],col="red")
lines(p[, dateTime], p[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()