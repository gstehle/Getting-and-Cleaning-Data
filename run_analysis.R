run_analysis <- function() {
  
  library(dplyr)
  
  measurement_labels <- read.table("./Smartphone Data/UCI HAR Dataset/features.txt")
  activity_labels <- read.table("./Smartphone Data/UCI HAR Dataset/activity_labels.txt")
  names(activity_labels) <- (c("activity","activity_name"))
  
  test_data <- read.table("./Smartphone Data/UCI HAR Dataset/test/X_test.txt")
  test_activities <- read.table("./Smartphone Data/UCI HAR Dataset/test/y_test.txt")
  test_participants <- read.table("./Smartphone Data/UCI HAR Dataset/test/subject_test.txt")
  
  names(test_data) <- measurement_labels[,2]
  names(test_participants) <- "participant_number"
  names(test_activities) <- "activity"
  
  test_data <- cbind(test_activities, test_participants, test_data)
  test_data <- test_data[,c(1,2,grep(c("mean|std"),colnames(test_data),ignore.case = TRUE))]
  test_data <- merge.data.frame(test_data,activity_labels, by = "activity")
  test_data <- mutate(test_data, group = "test")
  
  train_data <- read.table("./Smartphone Data/UCI HAR Dataset/train/X_train.txt")
  train_activities <- read.table("./Smartphone Data/UCI HAR Dataset/train/y_train.txt")
  train_participants <- read.table("./Smartphone Data/UCI HAR Dataset/train/subject_train.txt")
  
  names(train_data) <- measurement_labels[,2]
  names(train_participants) <- "participant_number"
  names(train_activities) <- "activity"
  
  train_data <- cbind(train_activities, train_participants, train_data)
  train_data <- train_data[,c(1,2,grep(c("mean|std"),colnames(train_data),ignore.case = TRUE))]
  train_data <- merge.data.frame(train_data,activity_labels, by = "activity")
  train_data <- mutate(train_data, group = "train")
  
  merged_data <- rbind(test_data,train_data)
  
  colnames(merged_data) <- gsub("-mean\\(\\)",".mean",colnames(merged_data))
  colnames(merged_data) <- gsub("-std\\(\\)",".stdev",colnames(merged_data))
  colnames(merged_data) <- gsub("-X",".x",colnames(merged_data))
  colnames(merged_data) <- gsub("-Y",".y",colnames(merged_data))
  colnames(merged_data) <- gsub("-Z",".z",colnames(merged_data))
  colnames(merged_data) <- gsub("BodyAccJerk",".body.jerk",colnames(merged_data))
  colnames(merged_data) <- gsub("BodyGyroJerk",".body.angular.jerk",colnames(merged_data))
  colnames(merged_data) <- gsub("GravityAcc",".gravity.acceleration",colnames(merged_data))
  colnames(merged_data) <- gsub("BodyAcc",".body.acceleration",colnames(merged_data))
  colnames(merged_data) <- gsub("BodyGyro","body.angular.acceleration",colnames(merged_data))
  colnames(merged_data) <- gsub("-meanFreq\\(\\)",".mean.freq",colnames(merged_data))
  colnames(merged_data) <- gsub("t\\.","time.",colnames(merged_data))
  colnames(merged_data) <- gsub("f\\.","frequency.",colnames(merged_data))
  colnames(merged_data) <- gsub("tbody\\.","time.",colnames(merged_data))
  colnames(merged_data) <- gsub("fbody\\.","frequency.",colnames(merged_data))
  colnames(merged_data) <- gsub("Mag",".magnitude",colnames(merged_data))
  colnames(merged_data) <- gsub("angle\\(","angle.",colnames(merged_data))
  colnames(merged_data) <- gsub("_",".",colnames(merged_data))
  colnames(merged_data) <- gsub("\\).",".",colnames(merged_data))
  colnames(merged_data) <- gsub("\\)","",colnames(merged_data))
  colnames(merged_data) <- gsub("\\,",".",colnames(merged_data))
  
  write.csv(merged_data, ".//Out2.csv")
  merged_data2 <- read.csv(".//Out2.csv")
  
  summarized_data <- aggregate(merged_data2[,-c(1:3,90:91)], by = list(activity = merged_data2$activity.name, participant = merged_data2$participant.number), FUN = mean)
  
  write.table(summarized_data, file= ".//Out3.txt", row.names = FALSE)

  
  }