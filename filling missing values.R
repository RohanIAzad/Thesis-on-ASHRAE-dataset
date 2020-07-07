setwd('C:/Users/Rohan/Desktop/ashrae-energy-prediction')

building_metadata<-read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/building_metadata.csv')

summary(building_metadata$floor_count)

#floor_count
mean_floor_count<- mean(building_metadata$floor_count,na.rm=TRUE)
rounded_mean_floor_count=round(mean_floor_count)
building_metadata$floor_count[is.na(building_metadata$floor_count)] <- rounded_mean_floor_count
summary(building_metadata$floor_count)

install.packages('rattle')
install.packages('rpart.plot')
library(rpart)
install.packages('RColorBrewer')

#year_built
summary(building_metadata$year_built)
fill_year_built<- rpart(year_built~primary_use+square_feet+floor_count,data=building_metadata[!is.na(building_metadata$year_built),],method='anova')
building_metadata$year_built[is.na(building_metadata$year_built)]<-predict(fill_year_built,building_metadata[is.na(building_metadata$year_built),])
summary(building_metadata$year_built)

weather_train <- read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/weather_train.csv')
#cloud coverage
summary(weather_train$cloud_coverage)
mean_cloud_coverage<-mean(weather_train$cloud_coverage,na.rm=TRUE)
rounded_mean_cloud_coverage=round(mean_cloud_coverage)
weather_train$cloud_coverage[is.na(weather_train$cloud_coverage)] <- rounded_mean_cloud_coverage
summary(weather_train$cloud_coverage)

#sea level pressure
weather_train$sea_level_pressure[is.na(weather_train$sea_level_pressure)]<-mean(weather_train$sea_level_pressure,na.rm=TRUE)
summary(weather_train$air_temperature)
weather_train$air_temperature[is.na(weather_train$air_temperature)]<-mean(weather_train$air_temperature,na.rm=TRUE)
summary(weather_train$air_temperature)


#Looking into the correlation cell filling up the missing columns with lower corrleations with mean
#after filling up the lower correlations with mean, filling up the higher correlations using decision tree
summary(weather_train$dew_temperature)
fill_dew_temp<-rpart(dew_temperature~sea_level_pressure+cloud_coverage+air_temperature,data=weather_train[!is.na(weather_train$dew_temperature),],method='anova')
weather_train$dew_temperature[is.na(weather_train$dew_temperature)]<-predict(fill_dew_temp,weather_train[is.na(weather_train$dew_temperature),])
summary(weather_train$dew_temperature)

#wind direction
summary(weather_train$wind_direction)
fill_wind_dir<-rpart(wind_direction~sea_level_pressure+dew_temperature+cloud_coverage+air_temperature,data=weather_train[!is.na(weather_train$wind_direction),],method='anova')
weather_train$wind_direction[is.na(weather_train$wind_direction)]<-predict(fill_wind_dir,weather_train[is.na(weather_train$wind_direction),])
summary(weather_train$wind_direction)

#precip_depth_1_hr
summary(weather_train$precip_depth_1_hr)
fill_precip_depth<-rpart(precip_depth_1_hr~sea_level_pressure+wind_direction+dew_temperature+cloud_coverage+air_temperature,data=weather_train[!is.na(weather_train$precip_depth_1_hr),],method='anova')
weather_train$precip_depth_1_hr[is.na(weather_train$precip_depth_1_hr)]<- predict(fill_precip_depth,weather_train[is.na(weather_train$precip_depth_1_hr),])
summary(weather_train$precip_depth_1_hr)

#wind speed
summary(weather_train$wind_speed)
fill_wind_speed<-rpart(wind_speed~air_temperature+cloud_coverage+dew_temperature+precip_depth_1_hr+sea_level_pressure+wind_direction+wind_speed,data=weather_train[!is.na(weather_train$wind_speed),],method='anova')
weather_train$wind_speed[is.na(weather_train$wind_speed)]<-predict(fill_wind_speed,weather_train[is.na(weather_train$wind_speed),])
summary(weather_train$wind_speed)

#library('mice')
#library('lattice')
#md.pattern(weatehr_train)

weather_train_save<-data.frame(site_id=weather_train$site_id,timestamp=weather_train$timestamp,
                          air_temperature=weather_train$air_temperature,cloud_coverage=weather_train$cloud_coverage,
                          dew_temperature=weather_train$dew_temperature,precip_depth_1_hr=weather_train$precip_depth_1_hr,
                          sea_level_pressure=weather_train$sea_level_pressure,wind_direction=weather_train$wind_direction,
                          wind_speed=weather_train$wind_speed)
write.csv(weather_train_save,file='weather_train_save.csv',row.names=FALSE)

building_metadata_save<-data.frame(site_id=building_metadata$site_id,building_id=building_metadata$building_id,
                                   primary_use=building_metadata$primary_use,square_feet=building_metadata$square_feet,
                                   year_built=building_metadata$year_built,floor_count=building_metadata$floor_count)
write.csv(building_metadata_save,file='building_metadata_save.csv',row.names=FALSE)
