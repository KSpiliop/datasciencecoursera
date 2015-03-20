NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# data check
unique(NEI$Pollutant) # [1] "PM25-PRI"
unique(NEI$year) # [1] 1999 2002 2005 2008
class(NEI$Emissions) # [1] "numeric"

# data aggregation
df_Q1 <- aggregate(Emissions ~ year, data = NEI, FUN = sum)
df_Q1

# plot
plot(df_Q1
     , main = "Emission by Year"
     , type = "l"
     , xlab = "Year"
     , ylab = "Total Emissions (Tons)")

# export PNG
dev.copy(png, file = "plot1.png") 
dev.off()