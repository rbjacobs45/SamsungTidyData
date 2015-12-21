# Getting and Cleaning Data Course Project
## Description of "run_analysis.R" Script
In order to use this script, the Samsung activity recognition data set must be contained in the current working directory within a folder called "UCI HAR Dataset". Additionally, the user must have the "dplyr" R package installed. The order of operations is as follows:

1. The script clears the stored objects, loads the "dplyr" package, and sets the working directory. The third line of the script can be commented out or modified for the user's desired working directory.
2. The script checks to see whether the "UCI HAR Dataset" directory exists. If it does exist, then the script proceeds; otherwise, the script will stop and throw an error message.
3. The names of all features are loaded and the script converts the vector to character type.
4. The test data files are loaded and combined into one data frame.
5. The training data files are loaded and combined into one data frame.
6. The test data and training data are merged into one data frame.
7. The names of the mean and standard deviation variables are modified to make them easier to interpret.
8. The names of all activities are loaded and the script converts the vector to character type.
9. The activity labels replace the activity IDs in the "data" frame.
10. Only the features that are mean and standard deviations are extracted and a new data frame called "tidyData1" is created.
11. The averages of each feature are calculated for each activity and subject and stored in"tidyData2"
12. The "tidyData2" data frame is written to a file called "tidyData.txt" in the current working directory.

## Code Book
### Data Set Description
The data contained in the file “tidyData.txt” include mean and standard deviation of all inertial measurements that have been averaged for each activity and each subject in the experiment. Each row in the data set represents a different subject and activity setting. 

### Experimental Design
Refer to the “README.txt” file contained in the data set package, or visit http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for details about the experimental design.

### Variable Name Descriptions
* “subject_id” specifies the ID number of the subject that performed a given activity in each row of the data set.
* “activity” specifies one of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) that each subject performed.
* Variable names that contain the first letter “t” are time-domain quantities, and variable names that contain the first letter “f” are frequency-domain quantities.
* “Body” denotes the body motion components of the quantities, and “Gravity” denotes the gravitational motion components of the quantities.
* “Acc” denotes an acceleration variable.
* “Gyro” denotes an angular velocity variable.
* “Jerk” denotes a variable that is the time derivative of the linear or angular acceleration. Units depend on which type of acceleration it is.
* “Mean” denotes that the variable is the mean of the signal, and “Sd” denotes that the variable is the standard deviation of the signal.
* “X”, “Y”, and “Z” at the end of a variable name denotes the axis in which the signal was measured.
* “Mag” denotes the Euclidean norm instead of a particular axis.
* All feature variables are normalized (thus they do not have units) and bounded within [-1,1].
