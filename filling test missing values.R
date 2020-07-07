setwd('C:/Users/Rohan/Desktop/ashrae-energy-prediction')

#building_metadata<-read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/building_metadata.csv')

#summary(building_metadata$floor_count)

#floor_count
#mean_floor_count<- mean(building_metadata$floor_count,na.rm=TRUE)
#rounded_mean_floor_count=round(mean_floor_count)
#building_metadata$floor_count[is.na(building_metadata$floor_count)] <- rounded_mean_floor_count
#summary(building_metadata$floor_count)

install.packages('rattle')
install.packages('rpart.plot')
library(rpart)
install.packages('RColorBrewer')

#year_built
#summary(building_metadata$year_built)
#fill_year_built<- rpart(year_built~primary_use+square_feet+floor_count,data=building_metadata[!is.na(building_metadata$year_built),],method='anova')
#building_metadata$year_built[is.na(building_metadata$year_built)]<-predict(fill_year_built,building_metadata[is.na(building_metadata$year_built),])
#summary(building_metadata$year_built)

weather_test <- read.csv('C:/Users/Rohan/Desktop/ashrae-energy-prediction/weather_test.csv')
#cloud coverage
summary(weather_test$cloud_coverage)
mean_cloud_coverage<-mean(weather_test$cloud_coverage,na.rm=TRUE)
rounded_mean_cloud_coverage=round(mean_cloud_coverage)
weather_test$cloud_coverage[is.na(weather_test$cloud_coverage)] <- rounded_mean_cloud_coverage
summary(weather_test$cloud_coverage)

#sea level pressure
weather_test$sea_level_pressure[is.na(weather_test$sea_level_pressure)]<-mean(weather_test$sea_level_pressure,na.rm=TRUE)
summary(weather_test$air_temperature)
#air temperature
weather_test$air_temperature[is.na(weather_test$air_temperature)]<-mean(weather_test$air_temperature,na.rm=TRUE)
summary(weather_test$air_temperature)


#Looking into the correlation cell filling up the missing columns with lower corrleations with mean
#after filling up the lower correlations with mean, filling up the higher correlations using decision tree
summary(weather_test$dew_temperature)
fill_dew_temp<-rpart(dew_temperature~sea_level_pressure+cloud_coverage+air_temperature,data=weather_test[!is.na(weather_test$dew_temperature),],method='anova')
weather_test$dew_temperature[is.na(weather_test$dew_temperature)]<-predict(fill_dew_temp,weather_test[is.na(weather_test$dew_temperature),])
summary(weather_test$dew_temperature)

#wind direction
summary(weather_test$wind_direction)
fill_wind_dir<-rpart(wind_direction~sea_level_pressure+dew_temperature+cloud_coverage+air_temperature,data=weather_test[!is.na(weather_test$wind_direction),],method='anova')
weather_test$wind_direction[is.na(weather_test$wind_direction)]<-predict(fill_wind_dir,weather_test[is.na(weather_test$wind_direction),])
summary(weather_test$wind_direction)

#precip_depth_1_hr
summary(weather_test$precip_depth_1_hr)
fill_precip_depth<-rpart(precip_depth_1_hr~sea_level_pressure+wind_direction+dew_temperature+cloud_coverage+air_temperature,data=weather_test[!is.na(weather_test$precip_depth_1_hr),],method='anova')
weather_test$precip_depth_1_hr[is.na(weather_test$precip_depth_1_hr)]<- predict(fill_precip_depth,weather_test[is.na(weather_test$precip_depth_1_hr),])
summary(weather_test$precip_depth_1_hr)

#wind speed
summary(weather_test$wind_speed)
fill_wind_speed<-rpart(wind_speed~air_temperature+cloud_coverage+dew_temperature+precip_depth_1_hr+sea_level_pressure+wind_direction+wind_speed,data=weather_test[!is.na(weather_test$wind_speed),],method='anova')
weather_test$wind_speed[is.na(weather_test$wind_speed)]<-predict(fill_wind_speed,weather_test[is.na(weather_test$wind_speed),])
summary(weather_test$wind_speed)

#library('mice')
#library('lattice')
#md.pattern(weatehr_test)

weather_test_save<-data.frame(site_id=weather_test$site_id,timestamp=weather_test$timestamp,
                          air_temperature=weather_test$air_temperature,cloud_coverage=weather_test$cloud_coverage,
                          dew_temperature=weather_test$dew_temperature,precip_depth_1_hr=weather_test$precip_depth_1_hr,
                          sea_level_pressure=weather_test$sea_level_pressure,wind_direction=weather_test$wind_direction,
                          wind_speed=weather_test$wind_speed)
write.csv(weather_test_save,file='weather_test_save.csv',row.names=FALSE)

#building_metadata_save<-data.frame(site_id=building_metadata$site_id,building_id=building_metadata$building_id,
#                                   primary_use=building_metadata$primary_use,square_feet=building_metadata$square_feet,
#                                   year_built=building_metadata$year_built,floor_count=building_metadata$floor_count)
#write.csv(building_metadata_save,file='building_metadata_save.csv',row.names=FALSE)
