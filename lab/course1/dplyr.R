##  dplyr tutorial
## If you don't have dplyer package. You need to install first.
library(dplyr)

## Data: mammals sleep :This data set contains 83 rows and 11 variables
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv"
if (!file.exists(filename)) download(url,filename)
msleep <- read.csv("msleep_ggplot2.csv")
head(msleep)
# Code book for the data set here!!!
# The columns (in order) correspond to the following:
        
# column name           Description
# name          	common name
# genus	                taxonomic rank
# vore          	carnivore, omnivore or herbivore?
# order	                taxonomic rank
# conservation	        the conservation status of the mammal
# sleep_total	        total amount of sleep, in hours
# sleep_rem	        rem sleep, in hours
# sleep_cycle	        length of sleep cycle, in hours
# awake	                amount of time spent awake, in hours
# brainwt       	brain weight in kilograms
# bodywt        	body weight in kilograms

#  Important dplyr verbs to remember

# dplyr verbs        Description
# select()	select columns
# filter()	filter rows
# arrange()	re-order or arrange rows
# mutate()	create new columns
# summarise()	summarise values
# group_by()	allows for group operations in the “split-apply-combine” concept

## select() ? Are select all use to select columns not rows? Yes. Use filter() for rows.
sleepData <- select(msleep, name, sleep_total) # by columns name
selectNoName<- select(msleep, -name) # select all columns but "name" column with "-" operator
selectFromNameToOrder<- select(msleep, name:order)# select from name column to order column with ":" operator.
selectWithString<- select(msleep, starts_with("sl"))# select columns with "sl" at begin. More others like ....
#
# ends_with() = Select columns that end with a character string
# contains() = Select columns that contain a character string
# matches() = Select columns that match a regular expression
# one_of() = Select columns names that are from a group of names

### Selecting rows using filter()

msleepOver16<- filter(msleep, sleep_total >= 16)
findOrderColumnMatch<- filter(msleep, order %in% c("Perissodactyla", "Primates")) # "%in%" is match(), At "order" column find match of c("Perissodactyla", "Primates")
## boolean operators (e.g. >, <, >=, <=, !=, %in%)



## Pipe operator: %>% 
## (Special operator in dplyr package, imports this operator from another package (magrittr))
## This operator allows you to pipe the output from one function to the input of another 


#---------------------------------------------------------------------#
head(select(msleep, name, sleep_total))
# This will show the same results as below.
#---------------------------------------------------------------------#
# The pipe operator input msleep into select() function, the output of select function will then input into head() function by  the second 
# pipe operator.
msleep %>% 
        select(name, sleep_total) %>% 
        head
#This will show same result as above.
#---------------------------------------------------------------------#


#--------------------arrange()--------------------------------#
##  re-order rows using arrange()

msleep %>% arrange(order) %>% head

# or write this w/o %>%

head(arrange(msleep, order))
#--------------------arrange()--------------------------------#
# practice with select() 
msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, sleep_total) %>% 
        head
# or write this w/o %>%
head(arrange(select(msleep,name, order, sleep_total),order, sleep_total))



# practice with select() and filter()


msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, sleep_total) %>% 
        filter(sleep_total >= 16)
# or write this w/o %>%
filter(arrange(select(msleep,name, order, sleep_total),order, sleep_total),sleep_total >= 16)



# use desc() descending order of select "column" in arrange() function
msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, desc(sleep_total)) %>% 
        filter(sleep_total >= 16)

## Compare to previous. 1 and 2 row switch. 3 and 4 row switch..

#---------------------------mutate()--------------------------------------------------------#

## The mutate() function will add new columns to the data frame.

msleep %>% 
        mutate(rem_proportion = sleep_rem / sleep_total) %>% #column name is "rem_proportion"
        head

## add more than one columns and separated by commas in the parameter.
msleep %>% 
        mutate(rem_proportion = sleep_rem / sleep_total, 
               bodywt_grams = bodywt * 1000) %>%
        head

#------------------------summarise()-------------------------------------------------------#

## The summarise() function will create summary statistics for a given column in the data frame

msleep %>% 
        summarise(avg_sleep = mean(sleep_total))


#----------------------group_by()--------------------------------------------------------#

msleep %>% 
        group_by(order) %>%
        summarise(avg_sleep = mean(sleep_total), 
                  min_sleep = min(sleep_total), 
                  max_sleep = max(sleep_total),
                  total = n())

test <- group_by(msleep,order) # "test" will be a "grouped_df" type. Not just regular DF. 
# PS: it look the same as DF by view() function. But it group by "order" column. So you can summarise() it.

head(test)

#----------------------group_by()--------------------------------------------------------#


