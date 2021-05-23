# Transformation Performed
1. Train and test data from source are merged into a single dataframe
2. Only keep measurements on the mean and standard deviation for each measurement
3. Repace activity number to descriptive activty names
4. Average of each variable for each activity and subject are saved in tidy_df.txt in working directory

# Result data
Saved in "tidy_df.txt" in working directory. To load, use read.table("./tidy_df.txt")

## Variables
subject: 1 through 30 represent volunteers who participated in the original study

activity: 6 activies labels are recorded. 

The rest of the columns are the average values of various signal measurement. Time series meeasurements are denoted with prefix 't'. Frequency domain signals transformed from FFT are denoted with prefix 'f'. The variables are averaged and denoted with:
- mean(): Mean value
- std(): Standard deviation
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
