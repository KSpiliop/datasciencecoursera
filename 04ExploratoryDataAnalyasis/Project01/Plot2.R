
# Plot 2:

png("plot2.png", width = 480, height = 480)

plot(df2_datetime$DateTime, df2_datetime$Global_active_power
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power (kilowatts)"
)

dev.off()

