library(dplyr)
library(stringr)
library(tidyverse)

# get GDD, KDD and crop timing data ----------------------------------------------------------

# GDD, KDD
cerrado_timeseries <- read.csv('~/Documents/R-code/Avery Work/Cerrado_GDD_KDD.csv')

# crop timing

#specificPoly_data <- read.csv('~/Documents/R-code/Crop Timing Visualization/FOI_stats.csv')
#cropTiming_double_plant <- read.csv('~/Documents/R-code/Crop Timing Visualization/double_plant_50km_MT.csv')
#cropTiming_double_harvest <- read.csv('~/Documents/R-code/Crop Timing Visualization/double_harvest_50km_MT.csv')
#cropTiming_single_plant <- read.csv('~/Documents/R-code/Crop Timing Visualization/single_plant_50km_MT.csv')
#cropTiming_single_harvest <- read.csv('~/Documents/R-code/Crop Timing Visualization/single_harvest_50km_MT.csv')
cropTiming_double <- read.csv('~/Documents/R-code/Crop Timing Visualization/double_50km_MT.csv') #just pasted plant and harvest csvs together
cropTiming_single <- read.csv('~/Documents/R-code/Crop Timing Visualization/single_50km_MT.csv')

# extract timeseries information from the GEE export

extract_timeseries <- function(series) {
  
    series <- series %>% as.character() %>% 
      str_replace_all('\\[', '') %>% 
      str_replace_all('\\]', '') %>% 
      str_replace_all('[ ]', '') %>% 
      strsplit(split = ',')
  
  return(series[[1]] %>% as.numeric())
}

ms_to_date = function(ms, t0="1970-01-01", timezone) {
  ## ms: a numeric vector of milliseconds (big integers of 13 digits)
  sec = ms / 1000
  return(as.Date(as.POSIXct(sec, origin=t0, tz = timezone)))
}

cerrado_GDD <- extract_timeseries(cerrado_timeseries$'GDD')
cerrado_KDD <- extract_timeseries(cerrado_timeseries$'KDD')
date_millis <- extract_timeseries(cerrado_timeseries$'Date')
date <- ms_to_date(date_millis, timezone = 'America/Belem') #sapply(date_millis, ms_to_date)
DOY <- format(date, '%j') %>% as.numeric() 
Year <- format(date, '%Y') %>% as.numeric()
cropYear_character <- cropTiming_double$Year %>% as.character()

# create KDD, GDD data frame for plotting
cerrado_DF <- data.frame(cerrado_GDD, cerrado_KDD, date_millis, date, DOY, Year)
colnames(cerrado_DF) <- c('GDD', 'KDD', 'Date_Millis', 'Date', 'DOY', 'Year')

# change DOY since Aug 1 of previous year to DOY since Jan 1 of current (actual) year
cropTiming_double_DF <- data.frame(cropTiming_double, cropYear_character)
colnames(cropTiming_double_DF) <- c('index', 'Count', 'DOY_sinceAug1', 'Harvest_Year', 'geo','Harvest_Year_Character')
cropTiming_double_DF$index <- NULL
cropTiming_double_DF$geo <- NULL
cropTiming_double_DF <- transform(cropTiming_double_DF, DOY_sinceJan1_actualYear = 
                                    ifelse(DOY_sinceAug1<= 152, DOY_sinceAug1 + 213, DOY_sinceAug1 - 152))
cropTiming_double_DF <- transform(cropTiming_double_DF, Actual_Year = 
                                    ifelse(DOY_sinceAug1<= 152, Harvest_Year - 1, Harvest_Year))
Actual_Year_Character <- cropTiming_double_DF$Actual_Year %>% as.character()
cropTiming_double_DF$Actual_Year_Character <- Actual_Year_Character

# basic plot 

min_date <- as.Date('2000-01-01', '%Y-%m-%d')
max_date <- as.Date('2000-12-01', '%Y-%m-%d')

plot <- ggplot(data = cerrado_DF, aes(x=Date)) +
  geom_line(aes(y = GDD, color = 'GDD')) +
  geom_line(aes(y = KDD, color = 'KDD')) +
  #scale_y_continuous(sec.axis = sec_axis(~.*1, name = "KDD")) +
  labs(title = 'Cerrado', x = 'Date', y = 'GDD') +
  scale_color_discrete(name = 'Legend') +
  scale_x_date(limits = c(min_date, max_date)) + #scale_x_date()
  theme_bw()

#print(plot)

# DOY plot for groups of years
start_year <- 2000
end_year <- 2010

cerrado_DOY_yearGroup1 <- subset(cerrado_DF, 
                                 Year >= start_year & 
                                 Year <= end_year) %>% 
                          group_by(DOY) %>% 
                          summarise(avg_GDD = mean(GDD), avg_KDD = mean(KDD)) %>%
                          data.frame()
cropTiming_double_yearGroup1 <- subset(cropTiming_double_DF, Actual_Year >= start_year & Actual_Year <= end_year)


plot <- ggplot(data = cerrado_DOY_yearGroup1, aes(x=DOY)) +
  geom_line(aes(y = avg_GDD, color = 'GDD')) +
  geom_line(aes(y = avg_KDD, color = 'KDD')) +
  labs(title = 'Cerrado', x = 'DOY', y = 'degree-days') +
  scale_color_discrete(name = 'Legend') +
  geom_point(data = cropTiming_double_yearGroup1, aes(y = Count, x = DOY_sinceJan1_actualYear, color = Actual_Year_Character)) +
  theme_bw()

print(plot)

