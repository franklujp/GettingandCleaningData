CodeBook for Getting and Cleaning Data
======================================

Project CodeBook From Week3's Project
---------------------------------------
The script `run_analysis.R` will perform 5 steps require by the project guideline and detailled below.
Prior to completing those steps, `run_analysis.R` will read the zip file from the repository, unzip it, then select the necessary file needed by the project.

1. All data will be read in the following variable `x_train`, `y_train`, `subject_train`, `x_test`, `y_test`, and `subject_test`. Then merged using `cbind()` and `rbind()` functions the entire data are merged and stored in `sensor_data`(Build the 7352 X 563 training data and Build the 2941 X 563 test data, the Combine the training and test data to form a 10299 X 563 dataset) and the column labels are build. 
2. Then, columns with the mean and standard deviation measures are extracted from the dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
3. Then, the activity names are actracted from the activity file and affixed to the dataset.
4. Labels are replaced with descriptive names.
5. Finally, the tiday data is save a file name `sensor_avg`

Variables

- `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
- `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
- `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
- A similar approach is taken with activity names through the `activities` variable.
- `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
- Finally, `sensor_avg.txt` contains the required data with tab delimiter. 
