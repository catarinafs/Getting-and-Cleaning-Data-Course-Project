#create a file to place the data
if(!file.exists("./R/data")){dir.create("./R/data")}

#download the data
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./R/data/DatasetW4.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./R/data/datasetW4.zip",exdir="./R/data")

# It unzips a Dir called 'UCI HAR Dataset' containing:
        #Dir: "test":
                #Txt: "subject_test", "X_test", "Y_test"
                #Dir: "Inertial Signals":
                        #Txt:"body_acc_x_test", "body_acc_y_test", "body_acc_z_test",
                            #"body_gyro_x_test", "body_gyro_y_test", "body_gyro_z_test",
                            #"total_acc_x_test", "total_acc_y_test", "total_acc_z_test"
        #Dir: "train":
                #Txt: "subject_train", "X_train", "Y_train"
                #Dir: "Inertial Signals":
                        #Txt:"body_acc_x_train", "body_acc_y_train", "body_acc_z_train",
                            #"body_gyro_x_train", "body_gyro_y_train", "body_gyro_z_train",
                            #"total_acc_x_train", "total_acc_y_train", "total_acc_z_train"
        #Txt: "activity_labels", "features", "features_info", "README"

#Read test datasets
        xtest<-read.table("./R/data/UCI HAR Dataset/test/X_test.txt")
        ytest<-read.table("./R/data/UCI HAR Dataset/test/Y_test.txt")
        subjtest<-read.table("./R/data/UCI HAR Dataset/test/subject_test.txt")

#Read train datasets
        xtrain<-read.table("./R/data/UCI HAR Dataset/train/X_train.txt")
        ytrain<-read.table("./R/data/UCI HAR Dataset/train/Y_train.txt")
        subjtrain<-read.table("./R/data/UCI HAR Dataset/train/subject_train.txt")
        
# Read feature file:
        features<-read.table("./R/data/UCI HAR Dataset/features.txt")
        #variables of X
        
# Read activity labels:
        act_labels<-read.table("./R/data/UCI HAR Dataset/activity_labels.txt")
        
#Label the variables
        colnames(xtrain)<-features[,2]
        colnames(xtest)<-features[,2]
        
        colnames(ytest)<-"activityID"
        colnames(ytrain)<-"activityID"
        
        colnames(subjtest)<-"subjID"
        colnames(subjtrain)<-"subjID"

#Merge the training and the test sets to create one data set.  
        merge_test<-cbind(subjtest,ytest,xtest)
        merge_train<-cbind(subjtrain,ytrain,xtrain)
        merge_all<-rbind(merge_train,merge_test)
        
#Define a vector with all variables names
        varNames<-colnames(merge_all)
        
#Create a vector that will search for ID, mean and Std in the variables
        search_id_mean_std<-( grepl("subjID",varNames) | 
                              grepl("activityID",varNames) |
                              grepl("mean(.*)",varNames)| 
                              grepl("std(.*)",varNames) )

#Subset data from merge_all when serach_id_mean_std=TRUE
        data_mean_std<-merge_all[,search_id_mean_std==TRUE]
        
#Use descriptive activity names
        activityNames<-merge(act_labels,data_mean_std,by="activityID",all=TRUE)
      
#Second data with the average of each variable for each activity and each subject 
        data_by<-aggregate(.~subjID+activityID+activityType, activityNames,mean)
        data_by<-data_by[order(data_by$subjID,data_by$activityID),]
      
#Create Txt files with the datasets created
        write.table(activityNames,"TidyData.txt",row.names = FALSE)
        write.table(data_by,"TidyDataBy.txt",row.names = FALSE)
        
        