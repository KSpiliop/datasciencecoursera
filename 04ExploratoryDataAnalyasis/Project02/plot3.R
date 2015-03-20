NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#################################################################################### Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

# data check
unique(NEI$type) # [1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"

# data aggregation
df_Q3 <- aggregate(Emissions ~ year + type, FUN = sum, data = data.frame(NEI[NEI$fips == "24510", c("Emissions", "year", "type")]))
df_Q3

# plot
g <- ggplot(df_Q3, aes(year, Emissions))
summary(g)
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm") + labs(title = "Emission by Type and Year") + labs(x = "Year", y = "Total Emissions (ton)")

# export PNG
dev.copy(png, file = "plot3.png") 
dev.off()
