# Download the data in the folder Project
if(!file.exists("./project")){
        dir.create("./project")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project/Dataset.zip",method="wininet")

# unzip the file
unzip(zipfile = "./project/Dataset.zip", exdir = "./project")

# Get the list of the files
myfilepath <- file.path("./project" , "UCI HAR Dataset")
#files<-list.files(myfilepath, recursive=TRUE)
#files

###############################
require(plyr)
require(dplyr)

# Build Directories and files
feature_file <- paste(myfilepath, "/features.txt", sep = "")
activity_labels_file <- paste(myfilepath, "/activity_labels.txt", sep = "")
x_train_file <- paste(myfilepath, "/train/X_train.txt", sep = "")
y_train_file <- paste(myfilepath, "/train/y_train.txt", sep = "")
subject_train_file <- paste(myfilepath, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(myfilepath, "/test/X_test.txt", sep = "")
y_test_file  <- paste(myfilepath, "/test/y_test.txt", sep = "")
subject_test_file <- paste(myfilepath, "/test/subject_test.txt", sep = "")


# 1.Merges the training and the test sets to create one data set.
# Load raw data
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

# Building the 7352 X 563 training data
train_data <- cbind(x_train,y_train, subject_train)
# Building the 2941 X 563 test data
test_data <- cbind(x_test,y_test,subject_test)

# Combining the training and test data to form a 10299 X 563 dataset
sensor_data <- rbind(train_data, test_data)

# Build sensor label
features <- read.table(feature_file, colClasses = c("character"))
labels <- rbind(features, c(562, "Subject"))
labels <- rbind(labels, c(563, "ID"))
names(sensor_data) <- labels[,2]


# 2.Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ID", names(sensor_data))]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(activity_labels_file, col.names = c("ID", "Activity"))
sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ID", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]

# 4. Appropriately labels the data set with descriptive names.
# Remove parentheses
names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE)
# Make syntactically valid names
names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))
# Make clearer names
names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))

# 5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
sensor_avg_by_act_sub = ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))
#View(sensor_avg_by_act_sub)
write.table(sensor_avg_by_act_sub, file = "./project/sensor_avg.txt")
