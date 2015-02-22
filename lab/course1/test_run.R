## construct a t-statistic for "scratch".
## With CTL...

##  
## A first important step is to identify which rows (variable) are associated with treatment and control
##
library(downloader)
url <- "http://journals.plos.org/plosbiology/article/asset?unique&id=info:doi/10.1371/journal.pbio.0020259.sd006"
filename <- tempfile()
download(url,destfile=filename)
dat <- read.csv("journal.pbio.0020259.sd005.csv")
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

## In statistics: The standard deviation of the distribution of a random variable is
## "The standard error of the random variable." --SE.

## We do not know the population standard deviation. So we use the sample standard deviation as an estimate. 
## In R we simply use the sd function
##?? Why it did not have squar root with "length(control)"?
sd(control)/length(control)

## Variance of the difference of two random variables is the sum of it's variances

se <- sqrt( var(treatment)/length(treatment) + var(control)/length(control) )

##  if we divide a random variable by it's SE, we get a new random variable with SE=1 Why????

tstat <- diff/se 

## This ratio is what we call the t-statistics. It's the ratio of two random variables. 

righttail <- 1-pnorm(abs(tstat)) 
lefttail <- pnorm(-abs(tstat))
pval <- lefttail + righttail
print(pval)


##  CLT works for large samples, but is 12 large enough? 
## A rule of thumb for CLT is that 30 is a large enough sample size 
## (but this is just a rule of thumb).

########################### Below Here is t-distribution #################

library(rafalib)

mypar2(1,2)
qqnorm(treatment);qqline(treatment,col=2)
qqnorm(control);qqline(control,col=2)

## Statistical theory tells us that distribution of the random variable tstat follows a t-distribution. 
## This is a much more complicated distribution than the normal 
## that depends on another parameter called -- degrees of freedom. 

t.test(treatment,control)

## 
## As a preview we point out that the test based on the 
## CLT approximation is more likely to incorrectly reject the null (false positive) while 
## the t-distribution is more likely to incorrectly accept the null (false negative).

## alternative hypothesis: true difference in means is not equal to 0 ---this is nothing to do with result.
## It just show you the alternative hypothesis in t-test.



dat <- read.csv(filename)
controlIndex <- which(dat$Diet=="chow")
treatmentIndex <- which(dat$Diet=="hf")
control <- dat[controlIndex,2]
treatment <- dat[treatmentIndex,2]
t.test(treatment,control)

require(graphics)

t.test(1:10, y = c(7:20))      # P = .00001855
t.test(1:10, y = c(7:20, 200)) # P = .1245    -- NOT significant anymore

## Classical example: Student's sleep data
plot(extra ~ group, data = sleep)
## Traditional interface
with(sleep, t.test(extra[group == 1], extra[group == 2]))
## Formula interface
t.test(extra ~ group, data = sleep)


## Read txt file in a folder into a DF

directory <- "your.work.directoty" # where your data files are. 
# It depends on your OS (Windows, Linux, MacOS)
ndirectory <- "your.new.directory"
files <- dir(directory)
files.to.read <- paste(directory, files, sep="/") 
files.to.write <- paste(ndirectory, files, sep="/")

for(i in 1:length(files.to.read) )
{
        d <- read.table(files.to.read[i], header=TRUE)
        temp <- d[c(1,seq(100, 9000, by=100)), ]
        write.table(temp, file=files.to.write[i], 
                    row.names=FALSE)
}






















