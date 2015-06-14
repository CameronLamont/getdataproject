---
title: "Code Book"
output: html_document
---

##Features Selected

*Adapted from features_info.txt provided with input data set.*

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

For readability and compatibility, names were substituted as follows:

* t Prefix -> TimeDomainSignal. Prefix
* f Prefix -> FrequencyDomainSignal. Prefix
* Acc -> Acceleration
* Gyro -> Gyroscope
* Mag -> Magnitude
* () removed
* \- replaced by .

###Base Feature Names
|Feature                                            |
|:--------------------------------------------------|
|TimeDomainSignal.BodyAcceleration.XYZ              |
|TimeDomainSignal.GravityAcceleration.XYZ           |
|TimeDomainSignal.BodyAccelerationJerk.XYZ          |
|TimeDomainSignal.BodyGyroscope.XYZ                 |
|TimeDomainSignal.BodyGyroscopeJerk.XYZ             |
|TimeDomainSignal.BodyAccelerationMagnitude         |
|TimeDomainSignal.GravityAccelerationMagnitude      |
|TimeDomainSignal.BodyAccelerationJerkMagnitude     |
|TimeDomainSignal.BodyGyroscopeMagnitude            |
|TimeDomainSignal.BodyGyroscopeJerkMagnitude        |
|FrequencyDomainSignal.BodyAcceleration.XYZ         |
|FrequencyDomainSignal.BodyAccelerationJerk.XYZ     |
|FrequencyDomainSignal.BodyGyroscope.XYZ            |
|FrequencyDomainSignal.BodyAccelerationMagnitude    |
|FrequencyDomainSignal.BodyAccelerationJerkMagnitude|
|FrequencyDomainSignal.BodyGyroscopeMagnitude       |
|FrequencyDomainSignal.BodyGyroscopeJerkMagnitude   |

###Calculations for each Feature
The set of variables that were estimated from these signals are: 

|Field Name|Calcluation|
|:---------|-----------|
|mean| Mean value       |
|std| Standard deviation|

###Linkage Keys
These features were linked and averaged (mean()) with the subject and corresponding activity:

|Y (Source)|Activity (Target)          |
|:-|--------------------|
|1 |WALKING             |
|2 |WALKING_UPSTAIRS    |
|3 |WALKING_DOWNSTAIRS  |
|4 |SITTING             |
|5 |STANDING            |
|6 |LAYING              |

##Output File : output[%Y%m%d_%H%M].txt
|Feature                                                  |Description                                      |
|:--------------------------------------------------------|-------------------------------------------------|
|subjectid                                                |Subject ID corresponding to the measurements     |
|activity                                                 |Corresponding Activity Name for the measurements |
|TimeDomainSignal.BodyAcceleration.mean.X                 |Average of Mean Time Domain Signal for Body Acceleration along X Axis|
|TimeDomainSignal.BodyAcceleration.mean.Y                 |Average of Mean Time Domain Signal for Body Acceleration along Y Axis|
|TimeDomainSignal.BodyAcceleration.mean.Z                 |Average of Mean Time Domain Signal for Body Acceleration along Z Axis|
|TimeDomainSignal.BodyAcceleration.std.X                  |Average Standard Deviation of Time Domain Signal for Body Acceleration along X Axis|
|TimeDomainSignal.BodyAcceleration.std.Y                  |Average Standard Deviation of Time Domain Signal for Body Acceleration along Y Axis|
|TimeDomainSignal.BodyAcceleration.std.Z                  |Average Standard Deviation of Time Domain Signal for Body Acceleration along Z Axis|
|TimeDomainSignal.GravityAcceleration.mean.X              |Average of Mean Time Domain Signal for Gravity Acceleration along X Axis|
|TimeDomainSignal.GravityAcceleration.mean.Y              |Average of Mean Time Domain Signal for Gravity Acceleration along Y Axis|
|TimeDomainSignal.GravityAcceleration.mean.Z              |Average of Mean Time Domain Signal for Gravity Acceleration along Z Axis|
|TimeDomainSignal.GravityAcceleration.std.X               |Average Standard Devition of Domain Signal for Gravity Acceleration along X Axis|
|TimeDomainSignal.GravityAcceleration.std.Y               |Average Standard Devition of Domain Signal for Gravity Acceleration along Y Axis|
|TimeDomainSignal.GravityAcceleration.std.Z               |Average Standard Devition of Domain Signal for Gravity Acceleration along Z Axis|
|TimeDomainSignal.BodyAccelerationJerk.mean.X             |Average of Mean Time Domain Signal for Body Jerk Acceleration along X Axis|
|TimeDomainSignal.BodyAccelerationJerk.mean.Y             |Average of Mean Time Domain Signal for Body Jerk Acceleration along Y Axis|
|TimeDomainSignal.BodyAccelerationJerk.mean.Z             |Average of Mean Time Domain Signal for Body Jerk Acceleration along Z Axis|
|TimeDomainSignal.BodyAccelerationJerk.std.X              |Average Standard Deviation of Time Domain Signal for Body Jerk Acceleration along X Axis|
|TimeDomainSignal.BodyAccelerationJerk.std.Y              |Average Standard Deviation of Time Domain Signal for Body Jerk Acceleration along Y Axis|
|TimeDomainSignal.BodyAccelerationJerk.std.Z              |Average Standard Deviation of Time Domain Signal for Body Jerk Acceleration along Z Axis|
|TimeDomainSignal.BodyGyroscope.mean.X                    |Average of Mean Time Domain Signal for Body Gyroscope along X Axis|
|TimeDomainSignal.BodyGyroscope.mean.Y                    |Average of Mean Time Domain Signal for Body Gyroscope along Y Axis|
|TimeDomainSignal.BodyGyroscope.mean.Z                    |Average of Mean Time Domain Signal for Body Gyroscope along Z Axis|
|TimeDomainSignal.BodyGyroscope.std.X                     |Average Standard Deviation of Time Domain Signal for Body Gyroscope along X Axis|
|TimeDomainSignal.BodyGyroscope.std.Y                     |Average Standard Deviation of Time Domain Signal for Body Gyroscope along Y Axis|
|TimeDomainSignal.BodyGyroscope.std.Z                     |Average Standard Deviation of Time Domain Signal for Body Gyroscope along Z Axis|
|TimeDomainSignal.BodyGyroscopeJerk.mean.X                |Average of Mean Time Domain Signal for Body Gyroscope Jerk along X Axis|
|TimeDomainSignal.BodyGyroscopeJerk.mean.Y                |Average of Mean Time Domain Signal for Body Gyroscope Jerk along Y Axis|
|TimeDomainSignal.BodyGyroscopeJerk.mean.Z                |Average of Mean Time Domain Signal for Body Gyroscope Jerk along Z Axis|
|TimeDomainSignal.BodyGyroscopeJerk.std.X                 |Average Standard Deviation of Time Domain Signal for Body Gyroscope Jerk along X Axis|
|TimeDomainSignal.BodyGyroscopeJerk.std.Y                 |Average Standard Deviation of Time Domain Signal for Body Gyroscope Jerk along Y Axis|
|TimeDomainSignal.BodyGyroscopeJerk.std.Z                 |Average Standard Deviation of Time Domain Signal for Body Gyroscope Jerk along Z Axis|
|TimeDomainSignal.BodyAccelerationMagnitude.mean          |Average of Mean Time Domain Signal for Body Acceleration Magnitude|
|TimeDomainSignal.BodyAccelerationMagnitude.std           |Average Standard Deviation of Time Domain Signal for Body Acceleration Magnitude|
|TimeDomainSignal.GravityAccelerationMagnitude.mean       |Average Mean Time Domain Signal for Gravity Acceleration Magnitude|
|TimeDomainSignal.GravityAccelerationMagnitude.std        |Average Standard Deviation of Time Domain Signal for Gravity Acceleration Magnitude|
|TimeDomainSignal.BodyAccelerationJerkMagnitude.mean      |Average of Mean Time Domain Signal for Body Jerk Acceleration Magnitude|
|TimeDomainSignal.BodyAccelerationJerkMagnitude.std       |Average Standard Deviation of Time Domain Signal for Body Acceleration Jerk Magnitude|
|TimeDomainSignal.BodyGyroscopeMagnitude.mean             |Average of Mean Time Domain Signal for Body Gyroscope Magnitude|
|TimeDomainSignal.BodyGyroscopeMagnitude.std              |Average Standard Deviation of Time Domain Signal for Body Gyroscope Magnitude|
|TimeDomainSignal.BodyGyroscopeJerkMagnitude.mean         |Average of Mean Time Domain Signal for Body Gyroscope Jerk Magnitude|
|TimeDomainSignal.BodyGyroscopeJerkMagnitude.std          |Average Standard Deviation of Time Domain Signal for Body Gyroscope Jerk Magnitude|
|FrequencyDomainSignal.BodyAcceleration.mean.X            |Average of Mean Frequency Domain Signal for Body Acceleration along X axis|
|FrequencyDomainSignal.BodyAcceleration.mean.Y            |Average of Mean Frequency Domain Signal for Body Acceleration along Y axis|
|FrequencyDomainSignal.BodyAcceleration.mean.Z            |Average of Mean Frequency Domain Signal for Body Acceleration along Z axis|
|FrequencyDomainSignal.BodyAcceleration.std.X             |Average Standard Deviation of Frequency Domain Signal for Body Acceleration along X axis|
|FrequencyDomainSignal.BodyAcceleration.std.Y             |Average Standard Deviation of Frequency Domain Signal for Body Acceleration along Y axis|
|FrequencyDomainSignal.BodyAcceleration.std.Z             |Average Standard Deviation of Frequency Domain Signal for Body Acceleration along Z axis|
|FrequencyDomainSignal.BodyAccelerationJerk.mean.X        |Average of Mean Frequency Domain Signal for Body Acceleration Jerk along X axis|
|FrequencyDomainSignal.BodyAccelerationJerk.mean.Y        |Average of Mean Frequency Domain Signal for Body Acceleration Jerk along Y axis|
|FrequencyDomainSignal.BodyAccelerationJerk.mean.Z        |Average of Mean Frequency Domain Signal for Body Acceleration Jerk along Z axis|
|FrequencyDomainSignal.BodyAccelerationJerk.std.X         |Average Standard Deviation of Frequency Domain Signal for Body Acceleration Jerk along X axis|
|FrequencyDomainSignal.BodyAccelerationJerk.std.Y         |Average Standard Deviation of Frequency Domain Signal for Body Acceleration Jerk along Y axis|
|FrequencyDomainSignal.BodyAccelerationJerk.std.Z         |Average Standard Deviation of Frequency Domain Signal for Body Acceleration Jerk along Z axis|
|FrequencyDomainSignal.BodyGyroscope.mean.X               |Average of Mean Frequency Domain Signal for Body Gyroscope along X axis|
|FrequencyDomainSignal.BodyGyroscope.mean.Y               |Average of Mean Frequency Domain Signal for Body Gyroscope along Y axis|
|FrequencyDomainSignal.BodyGyroscope.mean.Z               |Average of Mean Frequency Domain Signal for Body Gyroscope along Z axis|
|FrequencyDomainSignal.BodyGyroscope.std.X                |Average Standard Deviation of Frequency Domain Signal for Body Gyroscope along X axis|
|FrequencyDomainSignal.BodyGyroscope.std.Y                |Average Standard Deviation of Frequency Domain Signal for Body Gyroscope along Y axis|
|FrequencyDomainSignal.BodyGyroscope.std.Z                |Average Standard Deviation of Frequency Domain Signal for Body Gyroscope along Z axis|
|FrequencyDomainSignal.BodyAccelerationMagnitude.mean     |Average of Mean Frequency Domain Signal for Body Acceleration Magnitude|
|FrequencyDomainSignal.BodyAccelerationMagnitude.std      |Average Standard Deviation of Frequency Domain Signal for Body Acceleration Magnitude|
|FrequencyDomainSignal.BodyAccelerationJerkMagnitude.mean |Average of Mean Frequency Domain Signal for Body Acceleration Jerk Magnitude|
|FrequencyDomainSignal.BodyAccelerationJerkMagnitude.std  |Average Standard Deviation of Frequency Domain Signal for Body Acceleration Jerk Magnitude|
|FrequencyDomainSignal.BodyGyroscopeMagnitude.mean        |Average of Mean Frequency Domain Signal for Body Gyroscope Magnitude|
|FrequencyDomainSignal.BodyGyroscopeMagnitude.std         |Average Standard Deviation of Frequency Domain Signal for Body Gyroscope Magnitude|
|FrequencyDomainSignal.BodyGyroscopeJerkMagnitude.mean    |Average of Mean Frequency Domain Signal for Body Gyroscope Jerk Magnitude|
|FrequencyDomainSignal.BodyGyroscopeJerkMagnitude.std     |Average Standard Deviation of Frequency Domain Signal for Body Gyroscope Jerk Magnitude|
