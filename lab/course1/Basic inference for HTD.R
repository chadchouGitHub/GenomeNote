## Basic inference for high-throughput data

## This library is in the github. use devlop tool to download from github deposit

library(rafalib)
library(GSE5859Subset)
g <- sampleInfo$group ## put group col into a list.

e<- geneExpression[25,] ## Take 25th row of geneExpression (Why the id  disappear? ?? Because geneExpression 
##  is matrix????)

mypar2(1,2)
qqnorm(e[g==1])
qqline(e[g==1])
qqnorm(e[g==0])
qqline(e[g==0])

## Still not very understand "qqnorm"
## The qq-plots show that the data is well approximated by the normal approximation 
## NOTE: Check out Wiki for Q-Q plot What the Q-Q plot try to say about the data. 
##

t.test(e[g==1],e[g==0])
## Make our own t-test function to check
myttest <- function(x) t.test(x[g==1],x[g==0],var.equal=TRUE)$p.value
pvals <- apply(geneExpression,1,myttest) ## for a matrix 1 indicates rows, 2 indicates columns, 
                                         ##  c(1, 2) indicates rows and columns
sum(pvals<0.05)

set.seed(1)
m <- nrow(geneExpression)
n <- ncol(geneExpression)
randomData <- matrix(rnorm(n*m),m,n) ## Make m*n 
nullpvals <- apply(randomData,1,myttest)
sum(nullpvals<0.05)


library(genefilter)
results <- rowttests(geneExpression,factor(g))
max(abs(pvals-results$p)) ### What is this?????? No ideal





## Install Bioconductor ?? or genefilter in bioconductor???
## The first line use source() function to get a r script from bioconductor website
source("http://www.bioconductor.org/biocLite.R")
biocLite("genefilter") ## use this function to install package from bioconductor.





