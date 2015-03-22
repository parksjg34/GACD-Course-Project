# GACD-Course-Project

##Data Source:

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Steps to satisfy the Course Project's definition:

    1. After loading and unzipping the data, data is aggregated (rbind and cbind functions) into a single dataset. 
    2. Columns with Mean or Standardization are extracted out into a new dataset title 'DataSetDefined'.
    3. Activity Names are supplied to 'DataSetDefined' from 'activiy_labels.txt' for descriptive purposes.
    4. Acronyms in data names are replaced with their descriptive properties (gsub function).
    5. TidyData set is created with averages (aggregate).

##Description of steps are documented in the code for ease of follow
