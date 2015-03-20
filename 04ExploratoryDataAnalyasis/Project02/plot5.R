NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# data check
length(unique(NEI$SCC)); dim(NEI)
# [1] 5386
# [1] 6497651       6

length(unique(SCC$SCC)); dim(SCC)
# [1] 11717
# [1] 11717    15

str(SCC)
unique(SCC$EI.Sector)
grep("On-Road", SCC$EI.Sector)

# data aggregation
df_Q5_1 <- merge(NEI[NEI$fips == "24510",], SCC, by = 'SCC')
df_Q5_2 <- df_Q5_1[grep("On-Road", df_Q5_1$EI.Sector), c("Emissions", "year","EI.Sector")]
df_Q5_3 <- aggregate(Emissions ~ year, FUN = sum, data = df_Q5_2)

# plot
g <- ggplot(df_Q5_3, aes(year, Emissions))
summary(g)
g + geom_point() + geom_line() + labs(title = "Motor Vehicle Emissions in Baltimore City") + labs(x = "Year", y = "Total Emissions (ton)")

# explort PNG
dev.copy(png, file = "plot5.png") 
dev.off()
