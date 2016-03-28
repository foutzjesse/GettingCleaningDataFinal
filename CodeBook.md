#Data
This data consists of accelerometer and gyroscope data from the Human Activity Recognition Using Smartphones Dataset.
Mean and standard deviation data from several test subjects for each of the three spatial axes were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
This data also has a fast Fourier transform applied. In the final product, all this data is averaged and broken down by the activity being performed. The magnitude was also calculated for each field using the Euclidean norm.

#Variables
The columns have been named in as user-friendly a way as is practical. Since it is the symbol for standard deviation, "s" is used to denote the column of standard deviation data.

#Operations
Data was combined between the training and test data sets, and all non-mean and non-standard-deviation data was removed (activity label excepted), as were duplicate columns. Column names were made more descriptive, and the data was averaged.
