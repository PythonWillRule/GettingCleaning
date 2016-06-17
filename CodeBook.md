#Capstone Project 
#### for Getting & Cleaning Data Course
###### by Richard Wheeler

Analysis is performed by the R script called "run_analysis.R".  It writes out a file called "spresult.txt" which is the tidy data set of the smart phone measurment test and traning results. It also returns this result upon exiting the script.

#### Script Details

The script first begins by reading the "features.txt" file to use as column headings.  Using those names the first transformations begin here to replace the "()-" characters with "_" as R will convert them to periods.  The second transformation then replaces the "()" characters "".  The third transformation then repalces ")" to "" when any character is before the ")".  The forth transformation replaces the "-" with "_" when it is follow by any character or none.  The result is stored in the variable called "features".

The script next reads the activity labels from the "activity_labels.txt" file into a variable called "actlabels".  

Then script begins loading the "test" data beginning with reading the test subjects from "subject_test.txt" file into the "subjects" variable.  Next the test activities are read from the "y_test.txt" file into the "activities" variable.  The data frame "actlabels" is then merged with the "activities" data frame by the "activity" column into and replacing the "activities" variable.  Then the test measurements are read from the file "x_test.txt" into "testdata" variable using the "features" variable for the column names.  The script then adds two columns of "subjects"" and "activity label" from the "activities" data frame with the "testdata" data frame. Then the new column for activities is renamed to "activity".

The same steps are repeated again for the training data and the files used are "subject_train.txt", "y_train.txt" and "x_train.txt".  The resulting data frame is the "traindata" variable.
 
The next step is to merge the data frames "traindata" and "testdata" by the "subject" and using the "all" is true option.  The columns will have the suffix of either "_train" or "_test" added to distinquish which column goes with the subject and activity. The result is stored in the "spdata" data frame.

Now we ready to extract the mean and standard deviation measurements into the data frame variable "spmeanstd" using the "spdata" data frame. This was done with a grepl command to identify the columns to extract.

Next step is to calculate the averages for the extracted measurements.  Starting with the training data columns we use the aggregate command on the "spmeanstd" data frame. The na's are omitted and this done by the columns "subject" and "activity_train" and placed in data frame variable "spdattrain". Next we fix the column names for the by columns and then purge the "_train" suffixes from the other column names. Finally a "datasource" column is added so that we can know which original data set this measurement came from.

The same steps are followed for the test data columns in "spmeanstd" data frame and the result is stored in the "spdattest" data frame variable.

Now we have the data (spdattrain, spdattest) ready for the combining as the column names all match into the final data frame variable called "spresult".  Last data manipulation is to order by "subject".

Using "spresult" this is written to the file called "spresult.txt" and the function then returns ending the analysis and the script.

The 82 Variables used in the "spresult" dataset performed by the run_analysis.R script:  

- subject       - indentifier of the subject
- activity      - Descriptive name of one of the six activies performed by the subject  
- datasource    - indicates the dataset the measurement was drawn from either "test" or "train"  

The rest of the 79 variables are the averages calculated for each of the mean and standard deviation measurements extracted from the test and training data sets as described in the original code book which follows at the end of this variable list.  

- tBodyAcc.mean_X              
- tBodyAcc.mean_Y  
- tBodyAcc.mean_Z  
- tBodyAcc.std_X
- tBodyAcc.std_Y
- tBodyAcc.std_Z
- tGravityAcc.mean_X
- tGravityAcc.mean_Y
- tGravityAcc.mean_Z
- tGravityAcc.std_X
- tGravityAcc.std_Y
- tGravityAcc.std_Z
- tBodyAccJerk.mean_X
- tBodyAccJerk.mean_Y
- tBodyAccJerk.mean_Z
- tBodyAccJerk.std_X
- tBodyAccJerk.std_Y
- tBodyAccJerk.std_Z
- tBodyGyro.mean_X
- tBodyGyro.mean_Y
- tBodyGyro.mean_Z
- tBodyGyro.std_X
- tBodyGyro.std_Y
- tBodyGyro.std_Z
- tBodyGyroJerk.mean_X
- tBodyGyroJerk.mean_Y
- tBodyGyroJerk.mean_Z
- tBodyGyroJerk.std_X
- tBodyGyroJerk.std_Y
- tBodyGyroJerk.std_Z
- tBodyAccMag.mean
- tBodyAccMag.std
- tGravityAccMag.mean
- tGravityAccMag.std
- tBodyAccJerkMag.mean
- tBodyAccJerkMag.std
- tBodyGyroMag.mean
- tBodyGyroMag.std
- tBodyGyroJerkMag.mean
- tBodyGyroJerkMag.std
- fBodyAcc.mean_X
- fBodyAcc.mean_Y
- fBodyAcc.mean_Z
- fBodyAcc.std_X
- fBodyAcc.std_Y
- fBodyAcc.std_Z
- fBodyAcc.meanFreq_X
- fBodyAcc.meanFreq_Y
- fBodyAcc.meanFreq_Z
- fBodyAccJerk.mean_X
- fBodyAccJerk.mean_Y
- fBodyAccJerk.mean_Z
- fBodyAccJerk.std_X
- fBodyAccJerk.std_Y
- fBodyAccJerk.std_Z
- fBodyAccJerk.meanFreq_X
- fBodyAccJerk.meanFreq_Y
- fBodyAccJerk.meanFreq_Z
- fBodyGyro.mean_X
- fBodyGyro.mean_Y
- fBodyGyro.mean_Z
- fBodyGyro.std_X
- fBodyGyro.std_Y
- fBodyGyro.std_Z
- fBodyGyro.meanFreq_X
- fBodyGyro.meanFreq_Y
- fBodyGyro.meanFreq_Z
- fBodyAccMag.mean
- fBodyAccMag.std
- fBodyAccMag.meanFreq
- fBodyBodyAccJerkMag.mean
- fBodyBodyAccJerkMag.std
- fBodyBodyAccJerkMag.meanFreq
- fBodyBodyGyroMag.mean
- fBodyBodyGyroMag.std
- fBodyBodyGyroMag.meanFreq
- fBodyBodyGyroJerkMag.mean
- fBodyBodyGyroJerkMag.std
- fBodyBodyGyroJerkMag.meanFreq"

******************************************************************
#### Human Activity Recognition Using Smartphones Dataset
````
Version 1.0  

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
````
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#### Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

#### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
