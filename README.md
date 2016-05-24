##Getting and Cleaning Data

###Intro
This is the repository containing the final project for the Getting and Cleaning Data course in the Coursera Data Science track of courses.


###Data
This data pertains to personal fitness trackers. There is a test and a training set for each variable located in the ./UCI HAR Dataset/Test or ./UCI HAR Dataset/Train folders. The data is stored in the X_(test or train).txt is the variable values, while the y\_(test or train).txt are the activity type being preformed. The induvidual being recorded is stored in the subject_(test or train).txt file in the ./UCI HAR Dataset/(Test or train) folders. Finally the tested variables are stored in ./UCI HAR Dataset/features.txt and the activity descriptions are stored in the ./UCI HAR Dataset/activity_labels.txt

###r_Analysis.R
This script merges the Traning and Test data sets togeather, extracts the mean and standard deviations of the each variable, and finally averages each observation of a given activity for each induvidual. The results are stored in tidy.txt. The script must run in this directory just above UCI HAR Dataset/.

###CodeBook.md
Further explains the R Script.