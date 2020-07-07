setwd('C:/Users/Rohan/Desktop/ashrae-energy-prediction')

weather_train<-read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/weather_train.csv')

#getting the timestamp separated into day,month, year

weather_train$timestamp[1]

weather_train$timestamp <- as.character(weather_train$timestamp)

strsplit(weather_train$timestamp[1], split='[- :]')
strsplit(weather_train$timestamp[1], split='[- :]')[[1]]
strsplit(weather_train$timestamp[1], split='[- :]')[[1]][3]

weather_train$Month <- sapply(weather_train$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][2]})
weather_train$Month <- sub(' ', '', weather_train$Month)
table(weather_train$Month)

weather_train$Day_date <- sapply(weather_train$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][3]})
weather_train$Day_date <- sub(' ', '', weather_train$Day_date)
table(weather_train$Day_date)

weather_train$year <- sapply(weather_train$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][1]})
weather_train$year <- sub(' ', '', weather_train$year)
table(weather_train$year)

#weather_train_time<- data.frame(site_id=weather_train$site_id,timestamp=weather_train$timestamp,
#                                air_temperature=weather_train$air_temperature,cloud_coverage=weather_train$cloud_coverage,
#                                dew_temperature=weather_train$dew_temperature,precip_depth_1_hr=weather_train$precip_depth_1_hr,
#                                sea_level_pressure=weather_train$sea_level_pressure,wind_direction=weather_train$wind_direction,
#                                wind_speed=weather_train$wind_speed,Month=weather_train$Month,Day_date=weather_train$Day_date,
#                                year=weather_train$year)
#write.csv(weather_train_time,file='weather_train_time.csv',row.names=FALSE)

#filling missing values with mean specific site_id

by(data=weather_train$air_temperature,INDICES=weather_train$site_id,FUN=mean,na.rm=TRUE)
#filling air temperature with site_id0

