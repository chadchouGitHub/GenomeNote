## Basic EDA for high-throughput data
## This practice need this three libraries
## Make sure you have them install.
library(rafalib)
library(genefilter)
library(GSE5859Subset)
## Load  practice Data from GSE5859Subset by using data() function.

data(GSE5859Subset)

### 

g <- factor(sampleInfo$group) ## subset sampleInfo to a list of group index, and use factor() function to conver 
## the type of variable from number to factor

results <- rowttests(geneExpression,g) ## t-tests and F-tests for rows or columns of a matrix,
## and return a dataFrame with three variable. PS: The first col is row name. It is not a variable col.
pvals <- results$p.value ## Take p.value col to pvals vector

##Null data: Make up a data set from rnorm() function with same size of geneExpression file
m <- nrow(geneExpression)
n <- ncol(geneExpression)
randomData <- matrix(rnorm(n*m),m,n)
nullpvals <- rowttests(randomData,g)$p.value ## "g" is the same length of dataSet martix in col number. 
## PS: Here is rowttests.
nullresults <- rowttests(randomData,g)
## NOTE Here we have same length of pVals and nullpvals


plot(results$dm,-log10(results$p.value), ylim=c(0, 20),
     xlab="Effect size",ylab="- log (base 10) p-values", ) ## What is effect size mean here?? Is dm mean the different in mean--average?
## dm is "the difference of the group mean".
abline(h=-log10(0.01)) ## I add a line to show the pVal=0.05


### NOTE: *****Many features with very small p-values but small effect sizes, as we see here, 
### are sometimes indicative of problematic data. *******

## What is the fake Data p-val looks like?
plot(results$dm,-log10(nullresults$p.value), ylim=c(0, 20),
     xlab="Effect size",ylab="- log (base 10) p-values")
### In the fake data, there many "features"--rows has p-val small than 0.05. 
## Maybe moren than practice Data Set. Also the dm also very small,too.

mypar2(1,2)



### p-value histograms

mypar2(1,2)
hist(nullpvals,ylim=c(0,1400))
hist(pvals,ylim=c(0,1400))

### We generate completely null data the histogram follows a uniform distribution. 
## With our original data set we see a higher frequency of smaller p-values.

## When we expect most hypothesis to be null and we don’t see a uniform p-value distribution, 
##it might be indicative of unexpected properties in samples, such as correlated samples.

## Note that if we permute (by mix up group 1 and 0) the outcomes and calculate p-values then, 
## if the samples are independent, we should see a uniform distribution. 
permg <- sample(g)  ## permute sample by group
permresults <- rowttests(geneExpression,permg)
hist(permresults$p.value)

## With these data we do not:


### Box plots:

### **** Below practice use different Data Set. It is complete Data Set in GSE5859
library(Biobase)
devtools::install_github("genomicsclass/GSE5859") ## This line use to install GSE5859 from gitHub.

library(GSE5859) 

data(GSE5859) 
class(e)
ge <- exprs(e) ##ge for gene expression ### No ideal about the "e" ## Where the e come from.
ge[,49] <- ge[,49]/log2(exp(1)) ##immitate error

library(rafalib)
mypar2(1,1)
boxplot(ge,range=0,names=1:ncol(e),col=ifelse(1:ncol(ge)==49,1,2))

qs <- t(apply(ge,2,quantile,prob=c(0.05,0.25,0.5,0.75,0.95))) ## Don't understand the "prob=..." for quantile or apply.
## t() is matrix transform. It make row become col, and col become row
## Below is not t() transformation

gsNoT <- apply(ge,2,quantile,prob=c(0.05,0.25,0.5,0.75,0.95)) 

mypar2(2,1)
matplot(qs,type="l",lty=1) ## Plot the columns of one matrix against the columns of another.




matplot(gsNoT,ylim=c(0, 200), type="l",lty=1)



gsNoT <- apply(ge,2,quantile,prob=c(0.05,0.25,0.5,0.75,0.95)) 

#### shist() is smooth histongram function??? I don't know how this help?

mypar2(1,1)
shist(ge,unit=0.5)


## Scatterplots and correlation are not the best tools to detect replication problems. 
##Note, for example, that 1,2,3,4 and 100,200,300,400 are two lists with very different values yet
## have perfect correlation.

x <- ge[,1]
y <- ge[,2]
mypar(1,2)


plot(x,y)


## a better plot is a rotation of the scatter plot 
## containing the differences (x-y) on the y-axis and 
## the averages ((x+y)/2 )on the x-axis. This plot is a refereed to as an MA-plot.
plot((x+y)/2,x-y)



## If Scatterplots are not good in replication problem, and MA-plot is better. What MA plot will do to
## the 1,2,3,4 and 100, 200, 300, 400 example?


x <- c(1,2,3,4)
y <- c(1000,2000,3000,4000)













