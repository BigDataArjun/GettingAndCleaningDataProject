###Code Book

The following tasks are implemented in the script,

* Merges the training and the test sets to create one data set

* Extracts only the measurements on the mean and standard deviation for each measurement -
To perform this a vector of classes is generated with combination of numeric and NULL values, this vector is used in read.table function in colClasses, so that we can only extract the mean and std values from the text file directly.

* Uses descriptive activity names to name the activites in the data set -
To achieve this merge() function is used and the sort parameter of the function was set to FALSE to preserve the order.

* Appropriately labels the data set with descriptive activity names -
My interpretation towards this was to name the columns of the dataset appropriately. For this col.names parameter of read.table() function is used.

* Creates a second, independent tidy data set with the average of each variable for each activity and the each subject - 
My interpretation towards this was to generate average values for every activity for every subject so we have 30 subjects and 6 activities which generates 180 records. 
For this reshape2 package is used. Please refer comments in the code.
