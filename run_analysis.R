# Script for C3W4 Capstone Project by Richard Wheeler

runAnalysis <- function() {
    # First read in the features  and do some cleanup on their names
    features <- gsub("\\(\\)\\-","_",read.table("UCI HAR Dataset/features.txt", header = FALSE)[,2])
    features <- gsub("\\(\\)","",features)
    features <- gsub("*\\)","",features)
    features <- gsub("\\-*)","_",features)
    
    actlabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names=c("activity","label"))
    
    # Load Test Data steps
    subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names=c("subject"))
    activities <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names=c("activity"))
    testdata <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features)
   
    # Match the activity to the activity label and fix the column name
    activities <- as.data.frame(actlabels$label[match(activities$activity,actlabels$activity)])
    colnames(activities) = "activity"

    # bind it all together
    testdata <- cbind(subjects, activities, testdata)

    # Load Train Data Steps
    subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names=c("subject"))
    activities <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names=c("activity"))
    traindata <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features)

    # Match the activity to the activity label and fix the column name
    activities <- as.data.frame(actlabels$label[match(activities$activity,actlabels$activity)])
    colnames(activities) = "activity"
    
    # bind it all together
    traindata <- cbind(subjects, activities, traindata)
    
    # Merge the train & test data
    spdata <- merge(traindata,testdata, by="subject", all = TRUE, suffixes=c("_train","_test"))
    
    # Extract the mean & standard deviation measurements
    spmeanstd <- spdata[names(spdata)[grepl("subject|activity_|mean|std",names(spdata))]]
    
    # Get average of each variable for each ativity and each subject of train & test data frames
    spdattrain <- aggregate(spmeanstd[,3:81], by=list(spmeanstd$subject,spmeanstd$activity_train), mean, na.action = na.omit)
    setnames(spdattrain,"Group.1","subject")
    setnames(spdattrain,"Group.2","activity")
    names(spdattrain) = unlist(strsplit(names(spdattrain),"_train"))
    # add column for datasource
    spdattrain <- cbind(rep("train",nrow(spdattrain)),spdattrain)
    names(spdattrain)[1] = "datasource"
    spdattrain <- spdattrain[,c(2,3,1,4:82)]
    
    # now for the test data frame
    spdattest <- aggregate(spmeanstd[,83:161], by=list(spmeanstd$subject,spmeanstd$activity_test), mean, na.action = na.omit)
    setnames(spdattest,"Group.1","subject")
    setnames(spdattest,"Group.2","activity")
    names(spdattest) = unlist(strsplit(names(spdattest),"_test"))
    # add column for datasource
    spdattest <- cbind(rep("test",nrow(spdattest)),spdattest)
    names(spdattest)[1] = "datasource"
    spdattest <- spdattest[,c(2,3,1,4:82)]
    
    # time to combine results to a smaller tidy data set 
    spresult <- do.call(rbind, list(spdattrain, spdattest))
    spresult <- spresult[with(spresult, order(subject)),]

    # Write result to file
    write.table(spresult, file="spresult.txt", row.names = FALSE)
    
    return(spresult)
}
