This dataset included in this repository is for Coursera Data Science Specialization at Johns Hopkins University, Getting and Cleaning Data, Peer Review Assignment. 


The original data is obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file tidyData.R contains the transformed data; run_analysis.R contains the codes, written in R, of how I achieved this. 

-----------------------------------------
R version used: R.4.0.2
R packages used: data.table, plyr

I: Getting and Reading Data
a. Download the original file using download.files
b. Set working directory
c. Use read.table function from data.table package to read:
	1.subject_test/txt and subject_train.txt and combine them using rbind; name it as "subject"
	2.y_train.txt and y_test.txt and combine them using rbind; name it as "label"
	3.X_train.txt and X_test.txt and combine them using rbind; name it as "featureValues"
	4.activity_labels.txt and features.txt, which contains the range of activities and features that are measured; name them as "activitylabels" and "featurenames". 

II: Processing the Activity and Subject columns
a. using names() function to assign "activitylabels" and "label" column names to allow them to be joined using join function. So that the activity labels become associated with activity names, which are more descriptive. Extract the column that contains activity names and name it as "Activity" 
b. Name the "subject" column "Subject"

III: Extracting and Changing Feature Names
a. Express the second column of "featurenames" as a character vector
b. Using grep function to identify either pattern of "mean ()" and "std ()" in the vector, name the position vector created "positions"
c. Subset the "featureValues" with "positions", so that only the measurements about means and standard deviations are kept, name the resulting DF as "featureUseful"
d. Use gsub function to transform feature names to more descriptive ones:
	1. "t" is replaced with "time" and "f" "frequency"
	2. "Acc" is replaced with "Acceleration"
	3. "Mag" is replaced with "Magnitude"
	4. "Gyro" is replaced with "Gyroscope"

IV: Merging the data
a. Use cbind function twice to combine "subject", "activityMonitored", and "featureUseful"

V: Creating new dataset and get average per activity per feature
a. The function aggregate is used. 
b. Use write.table function to write the new dataset into the working directory.






