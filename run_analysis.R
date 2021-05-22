library(dplyr)
# 1. Merges the training and the test sets to create one data set.
### Get data values
path <- "./UCI HAR Dataset/"
type <- c("train", "test")
subject <- c("subject", "X", "y")

df <- NULL
for (t in type){
    print(paste("reading folder", t))
    mydata <- list()
    for (s in subject){
        filename <- paste(path, t, "/", s, "_", t, ".txt", sep="")
        print(paste("reading table", filename))
        mydata[[s]] <- read.table(filename)
    }
    df_type <- data.frame(mydata)
    df <- rbind(df, df_type)
}

### Get data feature names
subject_name <- "subject"
X_features_names <- read.table("./UCI HAR Dataset/features.txt")$V2
y_name <- "activity_label"
colnames(df) <- c(subject_name, X_features_names, y_name)
print("Dataframe merged")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
interest <- X_features_names[grep("mean|std", X_features_names)]
length(interest)
df <- df[,c(subject_name, interest, y_name)]
# 3. Uses descriptive activity names to name the activities in the data set
activity_df <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_df) <- c(y_name,'activity')
df <- left_join(df, activity_df, by=c(y_name))
df <- select(df, -y_name)
# 4. Appropriately labels the data set with descriptive variable names. 
# Already done in step 1
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_df <- df %>% group_by(subject, activity) %>% summarise(across(everything(), mean))

