NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 4
# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

# data check
length(unique(NEI$SCC)); dim(NEI)
# [1] 5386
# [1] 6497651       6

length(unique(SCC$SCC)); dim(SCC)
# [1] 11717
# [1] 11717    15

str(SCC)
unique(SCC$EI.Sector)
grep("Coal", SCC$EI.Sector)

# data aggregation
df_Q4_1 <- merge(NEI, SCC, by = 'SCC')
df_Q4_2 <- df_Q4_1[grep("Coal", df_Q4_1$EI.Sector), c("Emissions", "year","EI.Sector")]
df_Q4_3 <- aggregate(Emissions ~ year, FUN = sum, data = df_Q4_2)

# plot
g <- ggplot(df_Q4_3, aes(year, Emissions))
summary(g)
g + geom_point() + geom_line() + labs(title = "Total Coal Combustion Emissions") + labs(x = "Year", y = "Total Emissions (ton)")

# explort PNG
dev.copy(png, file = "plot4.png") 
dev.off()
