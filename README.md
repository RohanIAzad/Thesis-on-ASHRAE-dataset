# Thesis-on-ASHRAE-dataset
There were a lot of missing values in the dataset. 
The weather_train and weather_test has information about 16 site ids. So, taking the mean of each column with missing values and using the mean to replace the missing values will not be accurate. So, missing values from building_metadata was filled using RStudio (Refer to “filling missing values.R” for training set and refer to “filling test missing values.R” for test set) and then information about weather_train and weather_test was filled using python pandas library  (refer to “Testing train data filling by mean 1.ipynb” and “Testing test data filling by mean 1.ipynb”). 
Also, the timestamp column was divided into year, month, day columns in RStudio. Refer to “Filling missing values.R” for training set and “Filling test missing values.R” for test set. The output was saved as “weather_train_time.csv” and “weather_test_time.csv” respectively which was used as the input for “Testing train data filling by mean 1.ipynb” and “Testing test data filling by mean 1.ipynb” respectively.
After merging the 3 subsets, (train, building_metadata_save, weather_train3) and for test set (test, building_metadata_save, weather_test2) there were 4 types of meter readings. 
They are- 0: Electricity, 1: Chilled water, 2: Steam, 3: Hot water
The calculations were divided into 4 parts based on these meter types.
The individual files are called:
1. ASHRAE GPU-Chilled water.ipynb
2. ASHRAE GPU-Chilled water (Feature engineering).ipynb
3. ASHRAE GPU-Steam.ipynb
4. ASHRAE GPU-Steam(deleting outliers).ipynb
5. ASHRAE GPU-Electricity.ipynb
6. ASHRAE GPU-Hot water.ipynb.
Finally, a cleaner and final version of chilled_water notebook has been uploaded as “ASHRAE-final chilled water.ipynb”

