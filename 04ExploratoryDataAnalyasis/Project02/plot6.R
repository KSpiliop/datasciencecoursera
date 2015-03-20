NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

# data check

# data aggregation
df_Q6_1 <- merge(NEI[NEI$fips %in% c("24510", "06037"),], SCC, by = 'SCC')
df_Q6_2 <- df_Q6_1[grep("On-Road", df_Q6_1$EI.Sector), c("Emissions", "year","EI.Sector", "fips")]
df_Q6_3 <- aggregate(Emissions ~ year + fips, FUN = sum, data = df_Q6_2)
df_Q6_3$City <- ifelse(df_Q6_3$fips == "24510", "Baltimore City", "Los Angeles County")

# plot
g <- ggplot(df_Q6_3, aes(year, Emissions))
summary(g)
g + geom_point() +geom_line() + facet_grid(. ~ City) + xlab("year") + ylab("Total Emissions (tons)") + labs(title = "Two City Emission Comparison ")

# explort PNG
dev.copy(png, file = "plot6.png") 
dev.off()
