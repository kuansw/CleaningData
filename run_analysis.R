# ------------------------ START OF SCRIPT run_analysis.R -------------------- #
# Script Name: run_analysis.R
#
# This R Script contains two functions, run_analysis() and load_HARdataset().
#
# run_analysis() is the main function that collects, extracts and transforms
# the full UCI HAR dataset for the UCI Samsung Galaxy S HAR experiment, and then
# generates a tidy dataset comprising only activity subject and 66 feature 
# variables for the average values of the recorded mean and standard deviation 
# features in the original dataset grouped by activity and subject.
#
# load_HARdataset() is a helper function that is called by run_analysis() to 
# navigate the dataset directory, load and merge the 12 raw data files which 
# comprise each dataset.
# ---------------------------------------------------------------------------- #

library(dplyr)

load_HARdataset <- function (DSname, feature_labels, activity_labels) {
    # ------------------------------------------------------------------------ #        
    # This is a helper function to load the HAR dataset partition, as specified 
    # by the argument DSname.  The data records for the DSname is stored in  
    # several files under a directory with same name as the DSname and its 
    # subdirectories.   
    #
    # The list of files that makes up the HAR dataset partition is as follows:
    # 1. subject_<DSname>.txt   - this file stores the subjects who carried out 
    #                             the experiment
    # 2. Y_<DSname>.txt         - this file stores the activities performed. 
    # 3. X_<DSname>.txt         - this file stores a 561-feature vector of
    #                             time and frequency domain variables.
    # 4. Nine files under the subdirectory "Inertial Signals", 
    #    4.1 total_acc_x_<DSname>.txt
    #    4.2 body_acc_x_<DSname>.txt
    #    4.3 body_gyro_x_<Dsname>.txt
    #    4.4 total_acc_y_<DSname>.txt
    #    4.5 body_acc_y_<DSname>.txt
    #    4.6 body_gyro_y_<Dsname>.txt
    #    4.7 total_acc_z_<DSname>.txt
    #    4.8 body_acc_z_<DSname>.txt
    #    4.9 body_gyro_z_<Dsname>.txt
    #
    #    Each of these nine files records 128 measurements of the following 
    #    signals in either X,Y or Z axis for that sample window :
    #    - the acceleration signals from the accelerometer (total acceleration)
    #    - the estimated body acceleration. 
    #    - Triaxial Angular velocity from the gyroscope. 
    #     
    # This helper function loads all the data from the 12 files listed 
    # above, and merged them into one wide dataset with 1715 columns, and
    # returns the merged dataset to the calling function.
    #
    # Arguments :
    #   DSname         :    Name of the dataset to be loaded.
    #   feature_labels :    Descriptive names to be used as column names for the
    #                       561 feature vector
    #   activity_labels:    Descriptive names for the activities to be when 
    #                       merging the activity dataset.
    # Returns:
    #   ds             :    a merged dataset comprising of subject, activity and 
    #                       1713 measurements
    # ------------------------------------------------------------------------ #

    
    # Change working directory to the dataset directory named DSname
    setwd(DSname)
    
    # Forms the subject filename based on naming convention subject_<DS Name>.txt
    # and load the subject data of the dataset into the dataframe
    fname <- paste("subject_",DSname,".txt",sep="")
    ds <- read.table(fname,col.names="subject")
    
    # Forms the activity filename based on naming convention Y_<DS Name>.txt
    # Load activity data file and map the data to their corresponding activity
    # labels
    fname <- paste("Y_",DSname,".txt",sep="")
    activities <- read.table(fname,col.names="code")
    activities$activity <- factor(activities$code,levels=activity_labels$code,
                                  labels=activity_labels$label)
    
    ds$activity <- activities$activity
    
    feature_classes <- rep("numeric", length(feature_labels))
    
    fname <- paste("X_",DSname,".txt",sep="")
    features <- read.table(fname, sep = "", header = FALSE,
                         colClasses=feature_classes, col.names=feature_labels)
    ds <- cbind(ds,features)
    
    # Now to load the 9 raw files under "Inertial Signals" subdirectory
    InertialSignals <- c("body_acc","total_acc","body_gyro")
    Axials <- c("x","y","z")
    
    for ( SigType in InertialSignals) {
        for ( Axis in Axials) {
            # Construct the filename to load by concatenating Signal Type, Axis
            # and DSname.
            fname <- paste0("Inertial Signals/",SigType,"_",Axis,"_",DSname,".txt")
            IS_data <- read.table(fname) 
            
            # Before joining these additional columns to the main dataframe,
            # add a prefix comprising the SignalType and Axial to the 128 
            # default column names V1 to V128 to make them unique.
            colnames(IS_data) <- paste0(SigType, "_", Axis, "_", colnames(IS_data))
            
            # Bind the Inertia Signal columns to the main HAR dataframe
            ds <- cbind(ds, IS_data)
        }
    }
    
    setwd("..")

    return(ds)
}


run_analysis <- function () {
    # ------------------------------------------------------------------------ #    
    # This is the main function of run_analysis.R script file.  
    #
    # It performs the following data collection, extraction and transformation 
    # steps :
    # 1.    Checks if the UCI HAR dataset zip file exists.  If not, it 
    #       downloads it from the internet.
    # 2.    Unzips the UCI HAR Dataset.
    # 3.    Reads activity_labels and features_labels and prepares them for use
    #       as descriptive label names and values.
    # 4.    Loads the Training and Test datasets using a helper function,
    #       'Load_HARdataset()'
    # 5.    Merges the Training and Test datasets into one full dataset with 
    #       subject, activity and 1713 measures.
    # 6.    Extract the 66 mean and standard deviation measures to form the
    #       first tidy output dataset.
    # 7.    Create a second tidy dataset with the average values of the mean 
    #       and standard deviation variables from the first tidy dataset
    # 8.    Outputs the grouped tidy dataset to file ???tidy.txt??? in the current
    #       working directory
    #
    # Arguments : None
    # Returns: None
    # Outputs:
    #   tidy.txt   :   a tidy dataset comprising of subject, activity and
    #                   66 average values of the mean and standard deviation 
    #                   features grouped by activity and subject.
    # ------------------------------------------------------------------------ #    
    
    cat("run_analysis started.\n")
    
    if (!file.exists("UCI_HAR_Dataset.zip")) {
        cat("1. Downloading UCI HAR Dataset from Internet into working directory\n")
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
        download.file(fileURL,destfile="UCI_HAR_Dataset.zip", method="curl")
    } else {
        cat("1. Found UCI HAR Dataset zip file in current directory\n")
    }

    cat("2. Unzipping the UCI HAR Dataset\n")
    unzip("UCI_HAR_Dataset.zip", overwrite = TRUE, exdir = ".")
    
    # Switching to the directory containing the downloaded and unzipped files
    setwd("./UCI HAR Dataset")
    
    cat("3. Reading activity_labels.txt and features.txt\n")        

    # Read activity labels from activity_labels.txt which will be used to map
    # activity codes to activity labels during the loading of HAR datasets
    activity_labels <- read.table("activity_labels.txt",
                                  col.names=c("code","label"))
    
    # Read feature labels from features.txt which will be used to map
    # feature code to feature labels.  These feature labels used 
    # for column names during the loading of HAR datasets
    features <- read.table("features.txt",col.names=c("code","name"))
    
    # Clean up the feature labels for use as column names by 
    # stripping '(' and ')', and replacing '-' and ',' with '_'
    feature_labels <- gsub("angle\\(","angle_",features$name)
    feature_labels <- gsub("\\(","",feature_labels)
    feature_labels <- gsub("\\)","",feature_labels)
    feature_labels <- gsub("-","_",feature_labels)
    feature_labels <- gsub(",","_",feature_labels)

    # Call helper function load_HARdataset() to load Training dataset
    cat("4. Loading the Samsung Galaxy S HAR Training Dataset\n")
    SSG_train <- load_HARdataset("train", feature_labels, activity_labels)

    # Call helper function load_HARdataset() to load Test dataset
    cat("5. Loading the Samsung Galaxy S HAR Test Dataset\n")
    SSG_test  <- load_HARdataset("test", feature_labels, activity_labels)

    # Merge both the Training and Test datasets to form a full dataset
    cat("6. Merging the Training and Test datasets into one full dataset.\n")
    SSG_full <- rbind(SSG_train, SSG_test)

    # Extract only those mean and stddev features using the select function
    # from the dplyr library.  It is assumed that meanFreq features are not
    # considered to be a mean feature and should be excluded.
    #
    cat("7. Selecting only mean and stddev features from the full dataset 
        into a new tidy dataset.\n")
    SSG_tidied <- select(SSG_full, matches("subject|activity|mean|std", 
                                               ignore.case=FALSE)) %>% 
                    select(-matches("meanFreq",ignore.case=FALSE))
    
    # Generate a new dataset which holds the average values of the mean and 
    # stddev features of the tidied dataset grouped by activity and subject.
    # Use dplyr package's summarise_each function to perform mean function on 
    # all mean and standard deviation columns.
    #
    cat("8. Generating a new dataset for the average values of mean and stddev 
        features grouped by acivity and subject.\n")
    SSG_grouped <- group_by(SSG_tidied, activity, subject) %>% 
                   summarise_each(funs="mean")

    # Switch out of the Dataset Directory and back to the parent directory and
    # write out the tidied grouped dataset to the output file, 'tidy.txt'
    #
    cat("9. Writing out the grouped tidied dataset to tidy.txt \n")
    setwd("..")
    write.table(SSG_grouped,"tidy.txt",sep=" ", row.names=FALSE, col.names=TRUE)

    cat("run_analysis completed.\n")
}
# ------------------------- END OF SCRIPT run_analysis.R --------------------- #
