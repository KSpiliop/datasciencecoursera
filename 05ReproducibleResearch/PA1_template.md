# Load and Process Data


```r
# set up working directory
setwd("~/Desktop/Coursera/05_ReproducibleResearch/Project01")
getwd()
```

```
## [1] "/Users/SusanMacAir/Desktop/Coursera/05_ReproducibleResearch/Project01"
```

```r
dir()
```

```
## [1] "activity.csv"              "figure"                   
## [3] "graphics"                  "PA1_template.html"        
## [5] "PA1_template.Rmd"          "RCode 20150315.R"         
## [7] "repdata-data-activity.zip"
```

```r
# import raw data
df0_raw <- read.csv("activity.csv")
str(df0_raw)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
# convert "date" variable from factor format to date format
df1_date <- data.frame(df0_raw$steps, as.Date(df0_raw$date, "%Y-%m-%d"), df0_raw$interval)
names(df1_date) <- c("steps", "date", "interval")
str(df1_date) # 17568 obs. of  3 variables
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Date, format: "2012-10-01" "2012-10-01" ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
# load libraries
library(ggplot2)
```


# Find the average number of steps taken per day?

On original data (missing included), agggregate to date level, sum the number of steps

```r
df2_sum_steps_by_date <- aggregate(steps ~ date, data = df1_date, sum)
str(df2_sum_steps_by_date) # 53 obs. of  2 variables
```

```
## 'data.frame':	53 obs. of  2 variables:
##  $ date : Date, format: "2012-10-02" "2012-10-03" ...
##  $ steps: int  126 11352 12116 13294 15420 11015 12811 9900 10304 17382 ...
```

Histogram of sum of number of steps, based on data frame created above

```r
ggplot(df2_sum_steps_by_date, aes(x=steps)) + geom_histogram(binwidth = 1000, colour="black", fill="white")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 
![Plot1](/graphics/Plot1.png)

Find mean and median of steps taken per day:
Mean = 10770, Median = 10760

```r
summary(df2_sum_steps_by_date$steps) 
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##      41    8841   10760   10770   13290   21190
```

```r
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 41    8841   10760   10770   13290   21190 
```


# What is the average daily activity pattern?

Calculate the mean number of steps, aggregated by 5-min interval, ignoring missing data

```r
df3_avg_steps_by_interval <- aggregate(steps ~ interval, data = df1_date, mean)
str(df3_avg_steps_by_interval) # 288 obs. of  2 variables
```

```
## 'data.frame':	288 obs. of  2 variables:
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
##  $ steps   : num  1.717 0.3396 0.1321 0.1509 0.0755 ...
```

Plot average number of steps taken as a time series

```r
ggplot(df3_avg_steps_by_interval, aes(x = interval, y = steps)) + geom_line()
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

Find 5-min interval with max number of steps

```r
df3_avg_steps_by_interval [df3_avg_steps_by_interval $steps == max(df3_avg_steps_by_interval $steps),]
```

```
##     interval    steps
## 104      835 206.1698
```

```r
# interval 835, at maximum average steps of 206.1698
```


# Impute missing values

Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NA)

```r
sum(!complete.cases(df1_date))
```

```
## [1] 2304
```

```r
# 2304 rows out of 15264 rows have 1 or more missing data
```

Devise a strategy for filling in all of the missing values in the dataset. Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
# create copy of df
df4_missing <- df1_date
str(df4_missing)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Date, format: "2012-10-01" "2012-10-01" ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
# impute missing steps with mean steps
df4_missing$steps <- replace(df4_missing$steps, is.na(df4_missing$steps), mean(df4_missing$steps, na.rm = TRUE))
# impute missing date with median date "2012 - 10 - 31"
df4_missing$date <- replace(df4_missing$date, is.na(df4_missing$date), median(df4_missing$date, na.rm = TRUE))
# impute missing interval with mean interval
df4_missing$interval <- replace(df4_missing$interval, is.na(df4_missing$interval), mean(df4_missing$interval, na.rm = TRUE))
# check to see no more missing variables in new dataset
sum(!complete.cases(df4_missing))  
```

```
## [1] 0
```

Aggregate data again, after imputing missing values.  Sum number of steps, aggregated by date

```r
df5_sum_steps <- aggregate(steps ~ date, df4_missing, sum)
str(df5_sum_steps)
```

```
## 'data.frame':	61 obs. of  2 variables:
##  $ date : Date, format: "2012-10-01" "2012-10-02" ...
##  $ steps: num  10766 126 11352 12116 13294 ...
```

Make a histogram of the total number of steps taken each day

```r
ggplot(df5_sum_steps, aes(x=steps)) + geom_histogram(binwidth = 1000, colour="black", fill="white")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 

Calculate and report the mean and median total number of steps taken per day. 

```r
summary(df5_sum_steps$steps)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##      41    9819   10770   10770   12810   21190
```

```r
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 41    9819   10770   10770   12810   21190 
# mean = 10770, median = 10770
```

Q: Do these values differ from the estimates from the first part of the assignment? 
A: Yes, median has increased, mean remains the same

Q: What is the impact of imputing missing data on the estimates of the total daily number of steps?
A: Histogram has shifted a little. Summary statistics have changed



# Are there differences in activity patterns between weekdays and weekends?


```r
# Make a copy of the original dataset with missing values imputed
df6_weekday <- df4_missing

# create a new column in the df, containing string of Mon - Sun, based on date variable
df6_weekday$weekday <- weekdays(df6_weekday$date)
unique(df6_weekday$weekday)
```

```
## [1] "Monday"    "Tuesday"   "Wednesday" "Thursday"  "Friday"    "Saturday" 
## [7] "Sunday"
```

```r
# create new factor variable with two levels: weekday or weekend
df6_weekday$WeekdayOrWeekend <- NA
df6_weekday[df6_weekday$weekday %in% c("Saturday", "Sunday"),"WeekdayOrWeekend"] <- "Weekend"
df6_weekday[!df6_weekday$weekday %in% c("Saturday", "Sunday"),"WeekdayOrWeekend"] <- "Weekday"
unique(df6_weekday$WeekdayOrWeekend) # [1] "Weekday" "Weekend"
```

```
## [1] "Weekday" "Weekend"
```

```r
# aggregate up by time interval and WeekdayOrWeekend
df7_avg_steps_by_interval <- aggregate(steps ~ interval + WeekdayOrWeekend, data = df6_weekday, mean)
str(df7_avg_steps_by_interval)
```

```
## 'data.frame':	576 obs. of  3 variables:
##  $ interval        : num  0 5 10 15 20 25 30 35 40 45 ...
##  $ WeekdayOrWeekend: chr  "Weekday" "Weekday" "Weekday" "Weekday" ...
##  $ steps           : num  7.01 5.38 5.14 5.16 5.07 ...
```

```r
# plot average number of steps taken, broken out by weekday or weekend
ggplot(df7_avg_steps_by_interval, aes(x = interval, y = steps)) + geom_line() + facet_grid(WeekdayOrWeekend ~.)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png) 

