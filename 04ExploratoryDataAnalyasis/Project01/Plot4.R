
# Plot 4:

png("plot4.png", width = 480, height = 480)

par(mfrow=c(2, 2))

plot(df2_datetime$DateTime, df2_datetime$Global_active_power
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power"
)

plot(df2_datetime$DateTime, df2_datetime$Voltage
     , type = "l"
     , xlab = "datetime"
     , ylab = "Voltage"
)

plot(df2_datetime$DateTime, df2_datetime$Sub_metering_1, type = "l", col = "Black", xlab = "", ylab = "Energy sub metering")
lines(df2_datetime$DateTime, df2_datetime$Sub_metering_2, type = "l", col = "Red")
lines(df2_datetime$DateTime, df2_datetime$Sub_metering_3, type = "l", col = "Blue")
legend("topright"
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty = c(1,1)
       , lwd = c(2.5, 2.5)
       , col = c("Black", "Red", "Blue"))

plot(df2_datetime$DateTime, df2_datetime$Global_reactive_power
     , type = "l"
     , xlab = "datetime"
     , ylab = "Global_reactive_power"
)

dev.off()