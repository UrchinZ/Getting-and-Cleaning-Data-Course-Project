install.packages("dplyr")
library(dplyr)

# Download dataset from source. Make sure there are more than 100 Mb in your space 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI HAR Dataset")){
    download.file(url, dest="./dataset.zip", mode="wb")
    unzip ("./dataset.zip")
    file.remove("./dataset.zip")
}
# Format dataseet
## Read in data values
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

## Appropriately labels the data set with descriptive variable names.
subject_name <- "subject"
X_features_names <- read.table("./UCI HAR Dataset/features.txt")$V2
y_name <- "activity_label"
colnames(df) <- c(subject_name, X_features_names, y_name)
print("Dataframe merged")

# Extracts only the measurements on the mean and standard deviation for each measurement. 
interest <- X_features_names[grep("mean|std", X_features_names)]
length(interest)
df <- df[,c(subject_name, interest, y_name)]

# Uses descriptive activity names to name the activities in the data set
activity_df <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_df) <- c(y_name,'activity')
df <- left_join(df, activity_df, by=c(y_name))
df <- select(df, -y_name)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_df <- df %>% group_by(subject, activity) %>% summarise(across(everything(), mean))
write.table(tidy_df, file="./tidy_df.txt")
# result <- read.table("./tidy_df.txt")

# Cleanup
unlink("./UCI HAR Dataset", recursive=TRUE) 