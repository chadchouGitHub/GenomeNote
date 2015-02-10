

# download a csv file from a url link. 
#assign  full url address to url variable
# tempfile() function to assign tempfile to new variable --filename (can be any name)
#This script will not have file save in disk. it only tempfile to keep.
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- tempfile()
download.file(url,destfile=filename,method="curl")
dat <- read.csv(filename)
# after install dagdata package, I can't find the package data. 
# This system.file function can return path of the package location.
# list file to show the files in the direction.
dir <- system.file(package="dagdata")
list.files(dir)
