## Introduction
This code book describes the data structure and variables of ‘tidy.txt’, which is the output file created by run_analysis.R script after cleansing, processing and summarising the “Human Activity Recognition Using Smartphones Data Set” from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine Learning Repository</a>.

The Data Transformation Steps from the original dataset to output dataset are also described.

## Original Source Data Description 
This section is an extract reproduced from README.txt of the original UCI HAR dataset.

The dataset was collected and created from the experiments that was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain. 

For each window sample record of the full dataset, there are 1 subject, 1 activity, 561 features and 1152 raw signal measurements.

See 'features_info.txt' of the original UCI HAR Dataset which provides more details. 

A full description of this dataset is available at the site where the data was obtained: 
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The source data to be processed by this script was downloaded from this URL: 
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## Record Data Structure of the Output file ’tidy.txt’
‘tidy.txt’, the output file of run_analysis.R, is a space-separated file, which contains the average values of the 66 mean and standard variables grouped by activity and subject, which were extracted from the original UCI HAR Dataset.

Each record contains 68 columns as follows :
   
* activity 	- the activity performed for this window sample. The possible values are  ‘WALKING’, ‘WALKING_UPSTAIRS’,’WALKING_DOWNSTAIRS’,’SITTING’,’STANDING’,’LAYING’
* subject 	- the subject who performed the activity. Its range is from 1 to 30.
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


## Data Collection and Transformation Steps

1. Download the UCI HAR Dataset zip file from the Internet, if not already downloaded.

2. Unzip the downloaded UCI HAR Dataset zip file in the current working directory.

3. Load activity_labels.txt and features.txt and extract labels for use as Column Names in Steps 2 and 3.  
To make the names consistent for use as Column names, characters ‘(‘ and ‘)’ in the names are removed, and characters “-“ and “‘“ in the names are replaced by “_”.

4. Load and merge the 12 files that make up the Training dataset partition
The list of files loaded and merged are as follows :
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt
* train/Inertial Signals/body_acc_x_train.txt
* train/Inertial Signals/body_acc_y_train.txt
* train/Inertial Signals/body_acc_z_train.txt
* train/Inertial Signals/body_gyro_x_train.txt
* train/Inertial Signals/body_gyro_y_train.txt
* train/Inertial Signals/body_gyro_z_train.txt
* train/Inertial Signals/total_acc_x_train.txt
* train/Inertial Signals/total_acc_y_train.txt
* train/Inertial Signals/total_acc_z_train.txt

When loading features data (i.e. train/X_train.txt), the feature labels prepared in step 3 are used as Column Names.
When loading the activities data (i.e. train/y_train.txt), the activity codes are replaced by their corresponding human-readable activity labels. 
When loading the raw signals data, column Names for the raw signal measurements are prefixed by Signal Type (‘body_acc’, ‘body_gyro’, ‘total_acc’), Axis (x,y,z) and the reading sequence no (V1 to V128)

5. Load and merge the 12 files that make up the Test dataset partition
The list of files loaded and merged are as follows :
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* test/Inertial Signals/body_acc_x_test.txt
* test/Inertial Signals/body_acc_y_test.txt
* test/Inertial Signals/body_acc_z_test.txt
* test/Inertial Signals/body_gyro_x_test.txt
* test/Inertial Signals/body_gyro_y_test.txt
* test/Inertial Signals/body_gyro_z_test.txt
* test/Inertial Signals/total_acc_x_test.txt
* test/Inertial Signals/total_acc_y_test.txt
* test/Inertial Signals/total_acc_z_test.txt

When loading features data (i.e. test/X_test.txt), the feature labels prepared in step 3 are used as Column Names.
When loading the activities data (i.e. test/y_test.txt), the activity codes are replaced by their corresponding human-readable activity labels. 
When loading the raw signals data, column Names for the raw signal measurements are prefixed by Signal Type (‘body_acc’, ‘body_gyro’, ‘total_acc’), Axis (x,y,z) and the reading sequence no (V1 to V128)


6. Merge the Training and Test dataset partitions loaded in Steps 2 and 3 into one full dataset with all 1715 columns (including the raw signals)

7. Extract only the activity, subject, the 66 mean and standard deviation features for all the rows from the full dataset to create an intermediate tidy dataset.


8. From the intermediate dataset created in Step 7, calculate the average values of all 66 mean and standard by each activity and each subject and save the output to the final tidy dataset.
The column names for the average values in the final tidy dataset are the same as that of the column names for their corresponding mean and standard deviation features in the full dataset.

9. The final tidy dataset is then written out as a file ‘tidy.txt’ to the current working directory. 

