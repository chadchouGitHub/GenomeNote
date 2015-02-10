## construct a t-statistic for "scratch".


##  
## A first important step is to identify which rows (variable) are associated with treatment and control
##
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- tempfile()
download(url,destfile=filename)
dat <- read.csv(filename)
head(dat) ##quick look at the data 
str(dat) ## This also can tell you what rows (variable) are associated with treatment and control.

## Below lines only put index of each obs to a vector. It does not subsetting any date from dat. ****

controlIndex <- which(dat$Diet=="chow")
treatmentIndex <- which(dat$Diet=="hf")

## Because controIndex and treatmentIndex only have index from "dat", so we only can use it to select obs 
## from "dat". We can do any caculation directly on controlIndex and treatmentIndex. (It is nothing to do with 
## "dat".)

## So here we use controlIndex and treatmentIndex to subseting "dat"

control <- dat[controlIndex,2]
treatment <- dat[treatmentIndex,2]
diff <- mean(treatment)-mean(control)
print(diff)


