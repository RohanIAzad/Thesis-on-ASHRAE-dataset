setwd('C:/Users/Rohan/Desktop/ashrae-energy-prediction')

weather_test<-read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/weather_test.csv')

#getting the timestamp separated into day,month, year

weather_test$timestamp[1]

weather_test$timestamp <- as.character(weather_test$timestamp)

strsplit(weather_test$timestamp[1], split='[- :]')
strsplit(weather_test$timestamp[1], split='[- :]')[[1]]
strsplit(weather_test$timestamp[1], split='[- :]')[[1]][3]

weather_test$Month <- sapply(weather_test$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][2]})
weather_test$Month <- sub(' ', '', weather_test$Month)
table(weather_test$Month)

weather_test$Day_date <- sapply(weather_test$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][3]})
weather_test$Day_date <- sub(' ', '', weather_test$Day_date)
table(weather_test$Day_date)

weather_test$year <- sapply(weather_test$timestamp, FUN=function(x) {strsplit(x, split='[- :]')[[1]][1]})
weather_test$year <- sub(' ', '', weather_test$year)
table(weather_test$year)

weather_test_time<- data.frame(site_id=weather_test$site_id,timestamp=weather_test$timestamp,
                                air_temperature=weather_test$air_temperature,cloud_coverage=weather_test$cloud_coverage,
                                dew_temperature=weather_test$dew_temperature,precip_depth_1_hr=weather_test$precip_depth_1_hr,
                                sea_level_pressure=weather_test$sea_level_pressure,wind_direction=weather_test$wind_direction,
                                wind_speed=weather_test$wind_speed,Month=weather_test$Month,Day_date=weather_test$Day_date,
                                year=weather_test$year)
write.csv(weather_test_time,file='weather_test_time.csv',row.names=FALSE)

#filling missing values with mean specific site_id

#by(data=weather_train$air_temperature,INDICES=weather_train$site_id,FUN=mean,na.rm=TRUE)
#filling air temperature with site_id0

