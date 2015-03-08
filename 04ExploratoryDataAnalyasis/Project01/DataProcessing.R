getwd()
setwd("~/Desktop/Coursera/04_ExploratoryDataAnalysis/Project01")

file_name = "household_power_consumption.txt"
?read.table

# Step 0: Import Data (missing data is represented by "?")
df0_raw <- read.csv(file_name, header = TRUE, sep = ";", na.string = "?")
class(df0_raw); dim(df0_raw); str(df0_raw); head(df0_raw); tail(df0_raw)

# Step 1: Subset Data to 2/1/2007 - 2/2/2007
df1_sub <- df0_raw
df1_sub$Date <- as.Date(df1_sub$Date, "%d/%m/%Y")

DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
df1_sub <- df1_sub[df1_sub$Date >= DATE1 & df1_sub$Date <= DATE2,]
class(df1_sub); dim(df1_sub); str(df1_sub); head(df1_sub); tail(df1_sub)

# Step 2: Merge Date and Time, Convert to Date/Time format
df2_datetime <- df1_sub
df2_datetime$DateTime <- paste(df2_datetime$Date, df2_datetime$Time)
df2_datetime$DateTime <- strptime(df2_datetime$DateTime, "%Y-%m-%d %H:%M:%S")
class(df2_datetime); dim(df2_datetime); str(df2_datetime); head(df2_datetime); tail(df2_datetime)

