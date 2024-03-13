install.packages("tidyverse")
library(tidyverse)
install.packages("readr")
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(data.table)

dailyActivity <- read.csv("C:\\Users\\Navee\\OneDrive\\Documents\\Google Data Analysis\\Fitabase Data 4.12.16-5.12.16\\dailyActivity_merged.csv")
head(dailyActivity)
str(dailyActivity)
summary(dailyActivity)


##Checks for missing values in each columns 
colSums(is.na(dailyActivity))  

##Remove leading and trailing white space from the column
dailyActivity$Id <- trimws(dailyActivity$Id)
dailyActivity$ActivityDate <- trimws(dailyActivity$ActivityDate)
dailyActivity$TotalSteps <- trimws(dailyActivity$TotalSteps)
dailyActivity$TotalDistance <- trimws(dailyActivity$TotalDistance)
dailyActivity$TrackerDistance <- trimws(dailyActivity$TrackerDistance)
dailyActivity$LoggedActivitiesDistance <- trimws(dailyActivity$LoggedActivitiesDistance)
dailyActivity$VeryActiveDistance <- trimws(dailyActivity$VeryActiveDistance)
dailyActivity$ModeratelyActiveDistance <- trimws(dailyActivity$ModeratelyActiveDistance)
dailyActivity$LightActiveDistance <- trimws(dailyActivity$LightActiveDistance)
dailyActivity$SedentaryActiveDistance <- trimws(dailyActivity$SedentaryActiveDistance)
dailyActivity$VeryActiveMinutes<- trimws(dailyActivity$VeryActiveMinutes)
dailyActivity$FairlyActiveMinutes <- trimws(dailyActivity$FairlyActiveMinutes)
dailyActivity$LightlyActiveMinutes <- trimws(dailyActivity$LightlyActiveMinutes)
dailyActivity$SedentaryMinutes <- trimws(dailyActivity$SedentaryMinutes)
dailyActivity$Calories <- trimws(dailyActivity$Calories)

##AcitivityDate data type conversion from char to date and changing char data type to num  
dailyActivity$ActivityDate <- mdy(dailyActivity$ActivityDate)
dailyActivity$weekday <- weekdays(dailyActivity$ActivityDate)

dailyActivity$Id<- gsub(",", "", dailyActivity$Id)     
dailyActivity$Id <- as.numeric(dailyActivity$Id)
dailyActivity$TotalSteps <- as.numeric(dailyActivity$TotalSteps)
dailyActivity$TotalDistance <- as.numeric(dailyActivity$TotalDistance)
dailyActivity$TrackerDistance <- as.numeric(dailyActivity$TrackerDistance)
dailyActivity$LoggedActivitiesDistance <- as.numeric(dailyActivity$LoggedActivitiesDistance)
dailyActivity$VeryActiveDistance <- as.numeric(dailyActivity$VeryActiveDistance)
dailyActivity$ModeratelyActiveDistance <- as.numeric(dailyActivity$ModeratelyActiveDistance)
dailyActivity$LightActiveDistance <- as.numeric(dailyActivity$LightActiveDistance)
dailyActivity$SedentaryActiveDistance <- as.numeric(dailyActivity$SedentaryActiveDistance)
dailyActivity$VeryActiveMinutes <- as.numeric(dailyActivity$VeryActiveMinutes)
dailyActivity$FairlyActiveMinutes <- as.numeric(dailyActivity$FairlyActiveMinutes)
dailyActivity$LightlyActiveMinutes <- as.numeric(dailyActivity$LightlyActiveMinutes)
dailyActivity$SedentaryMinutes <- as.numeric(dailyActivity$SedentaryMinutes)
dailyActivity$Calories <- as.numeric(dailyActivity$Calories)

#Average Total Steps, Total Distance and Total Calories 
mean(dailyActivity$TotalSteps)
mean(dailyActivity$TotalDistance)
mean(dailyActivity$Calories)

##Most Active days and least active days
average_active_time <- dailyActivity %>%
  group_by(weekday) %>%
  summarize(AvgTotalSteps = mean(TotalSteps), AvgVeryActiveMinute = mean(VeryActiveMinutes), AvgCaloriesBurn = mean(Calories))
print(average_active_time)

## Total steps grouped by weekday
ggplot(dailyActivity, aes(x = dailyActivity$weekday, y=dailyActivity$TotalSteps)) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Total Steps in a Day", x = "Week Day ", y = "Total Steps")

sleepDay <- read.csv("C:\\Users\\Navee\\OneDrive\\Documents\\Google Data Analysis\\Fitabase Data 4.12.16-5.12.16\\sleepDay_merged.csv")
head(sleepDay)
str(sleepDay)
summary(sleepDay)
##Checks for missing values in each columns 
colSums(is.na(sleepDay))

##Remove leading and trailing white space from the column
sleepDay$SleepDay <- trimws(sleepDay$SleepDay)
sleepDay$Id <- trimws(sleepDay$Id)
sleepDay$TotalSleepRecords <- trimws(sleepDay$TotalSleepRecords)
sleepDay$TotalMinutesAsleep <- trimws(sleepDay$TotalMinutesAsleep)
sleepDay$TotalTimeInBed <- trimws(sleepDay$TotalTimeInBed)

##SleepDay data type conversion from char to date
sleepDay$SleepDay <- mdy(sleepDay$SleepDay)
View(sleepDay)
sleepDay$Id <- as.numeric(sleepDay$Id)
sleepDay$TotalSleepRecords <- as.numeric(sleepDay$TotalSleepRecords)
sleepDay $TotalMinutesAsleep <- as.numeric(sleepDay$TotalMinutesAsleep)
sleepDay$TotalTimeInBed <- as.numeric(sleepDay$TotalTimeInBed)

#Average Sleeping hours 
round(mean(sleepDay$TotalMinutesAsleep)/60)

#Corrolation between Total steps vs Calories burnt 
ggplot(dailyActivity, aes(x=TotalSteps, y=Calories)) + geom_point() +  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = 'Total Steps vs Calories', x= 'Total Steps', y = 'Calories Burnt')

#changing col name of date to match in both dataset 
colnames(dailyActivity)[2]  <- "Date" 
colnames(sleepDay)[2] <- "Date"

#Merging sleep and activity levels 
df_merge <- merge(dailyActivity, sleepDay, by = c("Id", "Date"))

## Graph of Sedentary Minutes vs Total Time Asleep
ggplot(df_merge, aes(x=SedentaryMinutes, y=TotalMinutesAsleep)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = 'Sedentary Minutes vs Total Minutes Asleep', x= 'Sendentary Minutes', y = 'Total Minutes Asleep')

#Calculate average sedentary minutes, total minutes asleep by day 
average_sedentary_time <- df_merge %>%
  group_by(weekday) %>%
  summarize(AvgSedentaryMinute = mean(SedentaryMinutes)/60, AvgtotalSleepMinute = mean(TotalMinutesAsleep)/60)
print(average_sedentary_time)

weightLog <- read.csv("C:\\Users\\Navee\\OneDrive\\Documents\\Google Data Analysis\\Fitabase Data 4.12.16-5.12.16\\weightLogInfo_merged.csv")
head(weightLog)
str(weightLog)
summary(weightLog)

##Checks for missing values in each columns 

colSums(is.na(weightLog))

##Remove leading and trailing white space from the column

weightLog$Date <- trimws(weightLog$Date)

##Date data type conversion from char to date 
weightLog$Date <- mdy(weightLog$Date)

weightLog%>%
  group_by(Id)%>%
  summarise(min(WeightPounds),max(WeightPounds))

heartrateInSec <- read.csv("C:\\Users\\Navee\\OneDrive\\Documents\\Google Data Analysis\\Fitabase Data 4.12.16-5.12.16\\heartrate_seconds_merged.csv")

##All column conversion from char to num and Date data type  
heartrateInSec$Id <- as.numeric(heartrateInSec$Id)
heartrateInSec$Date <- mdy(heartrateInSec$Date)
library(data.table)
heartrateInSec$Time <- as.ITime(heartrateInSec$Time)

##Average heart rate group by ID
average_heartrate <- heartrateInSec %>%
  group_by(Id) %>%
  summarize(avg_heartrate = mean(Value))
print(average_heartrate)


hourlySteps <- read.csv("C:\\Users\\Navee\\OneDrive\\Documents\\Google Data Analysis\\Fitabase Data 4.12.16-5.12.16\\hourlySteps_merged.csv")
head(hourlySteps)
str(hourlySteps)

##Checks for missing values in each columns 
colSums(is.na(hourlySteps))

##Remove leading and trailing white space from the column
hourlySteps$ActivityHour <- trimws(hourlySteps$ActivityHour)
hourlySteps$AM_PM <- trimws(hourlySteps$AM_PM)

##Converting Active hours from char to time data type

hourlySteps$ActivityHour <- as.ITime(hourlySteps$ActivityHour)
hourlySteps$AM_PM <- ifelse(hour(hourlySteps$ActivityHour) < 12, " AM", " PM")
hourlySteps$ActivityHour<- as.ITime(hourlySteps$ActivityHour)

filter_time <- filter(hourlySteps, hour(ActivityHour) >= 7 & StepTotal == 0 & hour(ActivityHour)< 19)
print(filter_time)
