# Getting-and-Cleaning-Data
Getting &amp; Cleaning Data Assignment Repository

This script cleans and manages the Samsung Smartphone data set.  The script will read the features file to get the names of all variables
(i.e. measurements) in the data.  The activities labels file is read to obtain activity descriptions to be matched to activity numbers.
The x-test file is read to obtain the measurements for each variable in the features file and the y-test file is read to obtain the 
activity number corresponding to each row.  The subjects file is read to obtain the participants corresponding to each row of 
observations.  The variables names are applied as column names to the new data frame containing the variable measurements and activity 
numbers.

The activities, participants and measurements data frames are column binded into a test data frame.  Measurements related to mean and 
and standard deviation are selected from this data frame via a search of column names.  This data frame is merged with the activity names
to map activity numbers (i.e. 1 through 6) with the corresponding activity.  "Test" is apended as a new column to each row to indicate
that records come from the test data in preperation for merging the test and train data sets.

The above process is followed for the train versions of files.  The two resultant data frames are row binded into one larger data frame 
with the same number of columns. Columns (i.e. measurements) are renamed to be more transparent in what they are measuring.  Details on 
this nomenclature can be found in the codebook. 

Finally, the data frame is summarized by participant and activity via the aggregate command, producing a new data frame with the means 
of each measurement by participant and activity.
