
# Plot 3:

png("plot3.png", width = 480, height = 480)

plot(df2_datetime$DateTime, df2_datetime$Sub_metering_1, type = "l", col = "Black", xlab = "", ylab = "Energy sub metering")

lines(df2_datetime$DateTime, df2_datetime$Sub_metering_2, type = "l", col = "Red")
lines(df2_datetime$DateTime, df2_datetime$Sub_metering_3, type = "l", col = "Blue")

legend("topright"
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty = c(1,1)
       , lwd = c(2.5, 2.5)
       , col = c("Black", "Red", "Blue"))

dev.off()
