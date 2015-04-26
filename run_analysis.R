library(reshape2)

#setup directory with data
datadir<-"./UCI HAR Dataset/"
clean_file <- "cleandata.txt"


# Returns an interim dataframe for a single dataset.
get.data <- function(name) {
  # Setup the file paths.
  
  features_name <- file.path(datadir, name ,paste("X_", name, ".txt", sep = ""))
  activities_name <- file.path(datadir,name, paste("Y_", name, ".txt", sep = ""))
  subjects_name <- file.path(datadir,name, paste("subject_", name, ".txt", sep = ""))
  

  # Read the features table.
  cat("reading features: ",features_name,"\n")
  t <- read.table(features_name)
  names(t) <- features_columns$name
  
  data <- t
  
  # Read the activities list.
  cat("reading features: ",activities_name,"\n")
  t <- read.table(activities_name)
  names(t) <- c("activity")
  data <- cbind(data, activity = t$activity)
  
  # Read the subjects list.
  cat("reading subjects: ",subjects_name,"\n")
  t <- read.table(subjects_name)
  names(t) <- c("subject")
  data <- cbind(data, subject = t$subject)
  
  # Return the data
  data
}


# 1. Merges the training and the test sets to create one data set.


features_columns<-read.table(file.path(datadir,"features.txt"))
names(features_columns)<-c("id","name")
  

  
  # Read the data.
print("Reading datasets.")
test <- get.data("test")
train <- get.data("train")
  
  # Join the data.
print ("Joining datasets.")
merges_data <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

print ("Extracts only the measurements on the mean and standard deviation")
extracted_columns<-features_columns[grepl("mean[()]|std",features_columns$name),]
extracted_table<-cbind(merges_data$subject,merges_data$activity,merges_data[extracted_columns$id])
colnames(extracted_table)[1]='subject'
colnames(extracted_table)[2]='activity'

#3.Uses descriptive activity names to name the activities in the data set
  activities<-read.table(file.path(datadir,"activity_labels.txt"))
  names(activities)<-c("id","name")
  extracted_table$activity <- factor(extracted_table$activity, levels = activities$id, labels = activities$name)

#4.Appropriately labels the data set with descriptive variable names. 
# made in the function get()

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  data_melt <- melt(extracted_table, id = c("subject", "activity"))
  data_mean <- dcast(data_melt, subject + activity ~ variable, mean)
  
  # Set the clean data.
  clean_data <- data_mean
  
  # Save the clean data.
  clean_file_name <- file.path(getwd(), clean_file)
  cat("Saving clean data to:", clean_file_name,"\n")
  write.table(clean_data, clean_file_name, row.names = FALSE, quote = FALSE)

