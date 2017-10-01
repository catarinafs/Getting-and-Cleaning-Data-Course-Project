# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project

This repository contains 5 files:
1. README.md - Explain the steps to get the required dataset
2. CodeBook.md - Explain the variables from original dataset, the new objects, and the steps I did to get from original dataset to the required dataset for the project
3. run_analysis.R - R code that I created.
4. TidyData - tidy dataset with descriptive variable names
5. TidyDataBy.txt - dataset with average of each variable 

  Steps to get the required dataset
  =============================
  The script was created in RStudio - R version 3.4.1 (2017-06-30) -- "Single Candle"
  
1. create a file to place the data if it doesn't exists
2. download the data
3. Unzip data
4. Read unziped files onto R
5. Label the columns of the datasets
6. Merge the training and the test sets to create one data set.  
7. Define a vector with all variables names  
8. Create a vector that will search for ID, mean and Std in the variables
9. Subset data from merge_all when serach_id_mean_std=TRUE
10. Use descriptive activity names     
11. Second data with the average of each variable for each activity and each subject 
12. Create Txt files with the datasets created

more detailed description is provided in the script
