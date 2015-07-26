# Getting and Cleaning Data

## Course Project
This readme markdown describes the information of scripts, which are tidy.txt, CodeBook.md and run_analysis.R in this repo.

The R script "run_analysis.R" does the following processes:
1. Download the dataset if it does not already exist in the working directory
2. Get the lists of activity labels and features of data
3. Extract the mean and standard deviation of data by features
4. Get the training and testing data respectively from the source
5. Merge both training and testing data
6. Transform the "activity" and "subject" columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The codebook describes the variables available in the data "tidy.txt"

The tidy.txt is the processed data after running "run_analysis.R"




