## Introduction

The purpose of this script run_analysis.R is to to collect, load, clean and transform a data set, and create a cleansed and tidied dataset with a subset of features needed for future analysis.

This assignment uses the “Human Activity Recognition Using Smartphones Data Set” from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine Learning Repository</a>, a popular repository for machine learning datasets, which contains data collected and processed from the experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years, performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

At each sample window, 128 readings of the accelerometer and gyroscope signals are captured at 3 axes (X, Y, Z), and a vector of 561 features was obtained by processing and calculating variables from the time and frequency domain. See ‘README.txt’ and ’features_info.txt' provided in the dataset for more details. 

In summary, each record in the HAR dataset consists of the following 1715 columns:
* An identifier of the subject who carried out the experiment.
* An activity label. 
* A 561-feature vector with time and frequency domain variables. 
* 128 readings of acceleration from the accelerometer (total acceleration) x 3 axes
* 128 readings of body acceleration (Estimated) x 3 axes
* 128 readings of Angular velocity from the gyroscope x 3 axes


A full description of this dataset is available at the site where the data was obtained: 
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The source data to be processed by this script was downloaded from this URL: 
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## Contents of the Script

This R Script contains two functions, run_analysis() and load_HARdataset().

run_analysis() is the main function that performs the following data collection, extraction and transformation steps :
	1. Checks if the UCI HAR dataset zip file exists.  If not, it 
    	   downloads it from the internet.
	2. Unzips the UCI HAR Dataset.
	3. Reads activity_labels and features_labels and prepares them for use
	   as descriptive label names and values.
	4. Loads the Training and Test datasets using a helper function,
	   'Load_HARdataset()'
	5. Merges the Training and Test datasets into one full dataset with 
	   subject, activity and 1713 measures.
	6. Extract the 66 mean and standard deviation measures to form the
	   first tidy output dataset.
	7. Create a second tidy dataset with the average values of the mean 
	   and standard deviation variables from the first tidy dataset
	8. Outputs the grouped tidy dataset to the file ‘tidy.txt’ in the current 
	   working directory


load_HARdataset() is a helper function that is called by run_analysis() to load, cleanse and merge the 12 data files comprising each dataset partition within this HAR dataset.  The data records for the dataset partition are stored in several space-separated files under a directory with same name as the dataset partition’s name and its subdirectories.   

The list of files that makes up the HAR dataset is as follows:
 1. subject_<DSname>.txt   - this file stores the subjects who carried out 
                             the experiment
 2. Y_<DSname>.txt         - this file stores the activities performed. 
 3. X_<DSname>.txt         - this file stores a 561-feature vector of time and frequency domain variables.
 4. Nine files under the subdirectory "Inertial Signals"
    - total_acc_x_<DSname>.txt
    - body_acc_x_<DSname>.txt
    - body_gyro_x_<Dsname>.txt
    - total_acc_y_<DSname>.txt
    - body_acc_y_<DSname>.txt
    - body_gyro_y_<Dsname>.txt
    - total_acc_z_<DSname>.txt
    - body_acc_z_<DSname>.txt
    - body_gyro_z_<Dsname>.txt

    Each row of these nine files records 128 measurements of the following signals in either X,Y or Z axis :
    - the acceleration signals from the accelerometer (total acceleration)
    - the estimated body acceleration. 
    - Triaxial Angular velocity from the gyroscope. 
     
This helper function loads all the data from the 12 files listed above, and merged them into one wide dataset with 1715 columns, and returns the merged dataset to the calling function.


## Running the Script

1. Check that your computer has Internet connectivity if the UCI HAR Dataset is not yet downloaded into the current working directory.
2. Source the script run_analysis.R
3. Run the function run_analysis()
4. Check that the output file ‘tidy.txt’ is created in the current working directory

## Checking the Output file ’tidy.txt’
Check the output file tidy.txt, which contains the average values of the 66 mean and standard variables grouped by activity and subject, in the working directory.  It should have a header and 180 data rows with 68 columns as follows :
   
* activity 
* subject 
* tBodyAcc_mean_X
* tBodyAcc_mean_Y
* tBodyAcc_mean_Z
* tBodyAcc_std_X
* tBodyAcc_std_Y
* tBodyAcc_std_Z
* tGravityAcc_mean_X
* tGravityAcc_mean_Y
* tGravityAcc_mean_Z
* tGravityAcc_std_X
* tGravityAcc_std_Y
* tGravityAcc_std_Z
* tBodyAccJerk_mean_X
* tBodyAccJerk_mean_Y
* tBodyAccJerk_mean_Z
* tBodyAccJerk_std_X
* tBodyAccJerk_std_Y
* tBodyAccJerk_std_Z
* tBodyGyro_mean_X
* tBodyGyro_mean_Y
* tBodyGyro_mean_Z
* tBodyGyro_std_X
* tBodyGyro_std_Y
* tBodyGyro_std_Z
* tBodyGyroJerk_mean_X
* tBodyGyroJerk_mean_Y
* tBodyGyroJerk_mean_Z
* tBodyGyroJerk_std_X
* tBodyGyroJerk_std_Y
* tBodyGyroJerk_std_Z
* tBodyAccMag_mean
* tBodyAccMag_std
* tGravityAccMag_mean
* tGravityAccMag_std
* tBodyAccJerkMag_mean
* tBodyAccJerkMag_std
* tBodyGyroMag_mean
* tBodyGyroMag_std
* tBodyGyroJerkMag_mean
* tBodyGyroJerkMag_std
* fBodyAcc_mean_X 
* fBodyAcc_mean_Y
* fBodyAcc_mean_Z
* fBodyAcc_std_X
* fBodyAcc_std_Y
* fBodyAcc_std_Z
* fBodyAccJerk_mean_X
* fBodyAccJerk_mean_Y
* fBodyAccJerk_mean_Z
* fBodyAccJerk_std_X
* fBodyAccJerk_std_Y
* fBodyAccJerk_std_Z
* fBodyGyro_mean_X
* fBodyGyro_mean_Y
* fBodyGyro_mean_Z
* fBodyGyro_std_X 
* fBodyGyro_std_Y
* fBodyGyro_std_Z
* fBodyAccMag_mean 
* fBodyAccMag_std
* fBodyBodyAccJerkMag_mean
* fBodyBodyAccJerkMag_std
* fBodyBodyGyroMag_mean
* fBodyBodyGyroMag_std
* fBodyBodyGyroJerkMag_mean
* fBodyBodyGyroJerkMag_std

Please refer to CodeBook.md provided with this submission for descriptions of the data variables and transformations performed.


