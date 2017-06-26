# CleaningDataCourseProject

The script run_analysis.R downloads accelerometer data from Galaxy smartphones to the current working directory, then prepares two(2) 
data.frame objects named df and aggdf:

df is a data.frame with 10,299 observations of 69 variables.
  Each observation consists of a subject noted by 'subject_id', 66 various measurements from the subject's smartphone's accelerometer,
  and a label indicating the activity in which the subject was engaged during the measurements (denoted by 'activity' and 'activity_code').
  The 66 measurements in df are a subset of the total 561 measurements available from the data source, corresponding to 
  mean values or standard deviations as noted by 'mean()' and std()', respectively, in the files features.txt and features_info.txt.
  
aggdf is a data.frame with 180 observations and 68 variables.
  The first two columns of aggdf denote an activity and subject_id and the last 66 columns correspond to smartphone measurements 
  as mentiond above in the description of df.
  Each observation in aggdf denotes the mean measurement value of each measurement for a given activity and subject.
  There are (30 x 6) = 180 observations because the data contain measurements from 30 subjects engaging in 6 activities.
