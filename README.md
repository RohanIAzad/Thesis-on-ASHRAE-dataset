# Thesis-on-ASHRAE-dataset: Project Overview
* Created a tool that would help engineers from American Society of Heating, Refrigeration and Air-conditioning Engineers (ASHRAE) determine what energy saving technology is worth investing in.
* The dataset was provided by ASHRAE and can be found here https://www.kaggle.com/c/ashrae-energy-prediction/data. There were 20 million records for the training set and 40 million records for the test sets
* The flowchart at the end provides an understanding of the problem.
  * ![](image/Algorithm.PNG)
* Optimized Linear, Lasso, ridge regression using GridSearchCV to come up with the best performing model, Also made use of Support Vector Regressor, Decision Tree, Ensemble methods, Bagging regressor, gradient boosting. 
* There were 4 meter readings in the dataset. Analysis for each of those meter readings were done separately and then teh predictions were merged into one csv file.

#Code and Resources Used

__Python packages: pandas, numpy,matplotlib,seaborn, sklearn,

# Features in the dataset

|train        |building_metadata|weather_train     |test       |
|-------------|-----------------|------------------|-----------|                                         
|building_id  | site_id         |site_id           |building_id|                    
|meter        | building_id     |timestamp         |meter      |            
|tmestamp     | primary_use     |air_temperature   |timestamp  |           
|meter reading| square feet     |cloud_coverage    |           |  
|             | year_built      |dew_temperature   |           |
|             | floor_count     |precip_depth_1_hr |           |
|             |                 |sea_level_pressure|           |
|             |                 |wind_direction    |           |
|             |                 |wind_speed        |           |
                                   

# Data cleaning
* Splitting timestamp to create year, month, day in RStudio
* Made us eof pandas concat and merged 3 subsets of data (train, building_metadata, weather_train) to create 1 tarinig set and test set (test,building_metadata, weather_test)
* Checked for missing values and filled those accordingly using RStudio, python, excel.

# EDA
There were 4 types of meters in the dataset. Their counts are shown below-

![](image/Count of meter types.JPG)

Analysing EDA it was found that the outliers were coming from building_id 1099 which was being used for education situated in site_id 13 and the meter type was steam.

![](image/Total meter reading reading VS timestamp.JPG)
   
   
  


There were a lot of missing values in the dataset. 
The weather_train and weather_test has information about 16 site ids. So, taking the mean of each column with missing values and using the mean to replace the missing values will not be accurate. So, missing values from building_metadata was filled using RStudio (Refer to “filling missing values.R” for training set and refer to “filling test missing values.R” for test set) and then information about weather_train and weather_test was filled using python pandas library  (refer to “Testing train data filling by mean 1.ipynb” and “Testing test data filling by mean 1.ipynb”). 
Also, the timestamp column was divided into year, month, day columns in RStudio. Refer to “Filling missing values.R” for training set and “Filling test missing values.R” for test set. The output was saved as “weather_train_time.csv” and “weather_test_time.csv” respectively which was used as the input for “Testing train data filling by mean 1.ipynb” and “Testing test data filling by mean 1.ipynb” respectively.
After merging the 3 subsets, (train, building_metadata_save, weather_train3) and for test set (test, building_metadata_save, weather_test2) there were 4 types of meter readings. 
They are- 0: Electricity, 1: Chilled water, 2: Steam, 3: Hot water
The calculations were divided into 4 parts based on these meter types.

Feature engineering was also attempted to test if the performance improved. But adding information about seasons, beaufort scale did not imrpove the predictions. Lots of outliers were coming from steam portion of the dataset as can be seen in the "ASHRAE data visualization". So, Steam with outliers deleted was also trained to see if the performance improved and it did.  

The individual files are called:
1. ASHRAE Chilled water.ipynb
2. ASHRAE Chilled water (Feature engineering).ipynb
3. ASHRAE Steam.ipynb
4. ASHRAE Steam(deleting outliers).ipynb
5. ASHRAE Electricity.ipynb
6. ASHRAE Hot water.ipynb.

Data loading and data preparation for all the fiels in the list above is the same. But training and test split is different depending on the meter type. Also, the algorithms that were best for predicting meter readings in KWH each of the meter types were different. 

The simplified algorithm for the training phase is shown below.



