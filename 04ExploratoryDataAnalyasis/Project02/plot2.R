NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# data check
unique(NEI$Pollutant) # [1] "PM25-PRI"
unique(NEI$year) # [1] 1999 2002 2005 2008
dim(NEI[NEI$fips == "24510", ]) # [1] 2096    6

# data aggregation
df_Q2 <- aggregate(Emissions ~ year, FUN = sum, data = data.frame(NEI[NEI$fips == "24510", c("Emissions", "year")]))
df_Q2

# plot
plot(df_Q2
     , main = "Emission by Year in Baltimore City"
     , type = "l"
     , xlab = "Year"
     , ylab = "Total Emissions (Tons)")

# export PNG
dev.copy(png, file = "plot2.png") 
dev.off()
