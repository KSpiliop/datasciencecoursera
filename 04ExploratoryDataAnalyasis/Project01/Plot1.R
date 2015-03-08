
# Plot 1: 
png("plot1.png", width=480, height=480)

hist(df2_datetime$Global_active_power
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , ylab = "Frequency"
     , col = "Red"
     #      , xlim = c(0, 6)
     , breaks = 12
     , ylim = c(0, 1200)
)

dev.off()


