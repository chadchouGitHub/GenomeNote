## Plots to avoid

library(UsingR)

pie(browsers,main="Browser Usage (August 2013)") ## No tell where is the "browsers"

## So I use example in the pie() help
## Example of pie()

require(grDevices) ## loading "grdevices" into r
pie(rep(1, 24), col = rainbow(24), radius = 0.9)

pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry",
                      "Apple", "Boston Cream", "Other", "Vanilla Cream")
pie(pie.sales) # default colours
## I am going to make my own browsers vector
browsers <- c(1,9,20,26,44)
names(browsers) <- c("Opera", "Safari", "Firefox","IE","Chrome")

barplot(browsers,main="Browser Usage (August 2013)")

## Now I can use browsers to draw pie or bar.....

## Avoid bad grapic like...
## Bar is better than pie, and don't do 3D graphic, obfuscate the plot,
## No donut pie..

## Barplots as data summaries
## I agree with this, but not sure what to do.... or what it mean at second sentence.

## While barplots are useful for showing percentages, 
## they are incorrectly used to display data from two groups begin compared.
## Much more informative is to summarizing with a boxplot.

## load a fig1.RData dataset to show boxplot. 
## How can I look this RData dataset? 

## Use load() to read RData. In this case, it load x, y, z into Global Environment

library("downloader")
filename <- "fig1.RData"
url <- "https://github.com/kbroman/Talk_Graphs/raw/master/R/fig1.RData"
if (!file.exists(filename)) download(url,filename)
load(filename)
library(rafalib)
mypar2(1,1)
dat <- list(Treatment1=x,Control=y, Treatment2=z) ## Make list vector w/ x and y and name each as 
## treatment and control. I add z into the plot for practice...
boxplot(dat,xlab="Group",ylab="Response",xlab="Group",ylab="Response",cex=0)
## boxplot make bar and lines from mean, SD, ....and Highest lowest...
stripchart(dat,vertical=TRUE,method="jitter",pch=16,add=TRUE,col=1)
## stripchart() put every number dots on the boxplot.


##A quick look at the data demonstrates that this difference is mostly driven by just two points. 


## Although, a boxplot give many information. But the scale also need to be fit for
## data.
## A version showing the data in the log-scale is much more informative.
library(downloader)
url <- "https://github.com/kbroman/Talk_Graphs/raw/master/R/fig3.RData"
filename <- "fig3.RData"
if (!file.exists(filename)) download(url, filename)
load(filename)
library(rafalib)
mypar2(1,2)
dat <- list(Treatment=x,Control=y)
boxplot(dat,xlab="Group",ylab="Response",xlab="Group",ylab="Response",cex=0)
stripchart(dat,vertical=TRUE,method="jitter",pch=16,add=TRUE,col=1)
boxplot(dat,xlab="Group",ylab="Response",xlab="Group",ylab="Response",log="y",cex=0)
##  "log": character indicating if x or y or both coordinates should be plotted 
## in log scale.
stripchart(dat,vertical=TRUE,method="jitter",pch=16,add=TRUE,col=1)

## Show the scatterplot not just the regression line
## Don't hides the scatter
url <- "https://github.com/kbroman/Talk_Graphs/raw/master/R/fig4.RData"
filename <- "fig4.RData"
if (!file.exists(filename)) download(url, filename)
load(filename)
mypar2(1,2)
plot(x,y,lwd=2,type="n")
fit <- lm(y~x)
abline(fit$coef,lwd=2)
b <- round(fit$coef,4)
text(74, 200, paste("y =", b[1], "+", b[2], "x", "(Bad example)"), adj=c(0,0.5))
rho <- round(cor(x,y),4) # 0.8567
text(78, 187,expression(paste(rho," = 0.8567")),adj=c(0,0.5))

plot(x,y,lwd=2)
fit <- lm(y~x)
abline(fit$coef,lwd=2)


## High correlation does not imply replication

## Here are example:
library(Biobase)
source("http://www.bioconductor.org/biocLite.R")
biocLite("SpikeInSubset")
library(SpikeInSubset)
data(mas95) ## this data is in SpikeInSubset library or Biobase library


## Before you run this code, you will need to install package from Bioconductor
mypar2(1,2)
r <- exprs(mas95)[,1] ##original measures were not logged
g <- exprs(mas95)[,2]
plot(r,g,lwd=2,cex=0.2,pch=16,
     xlab=expression(paste(E[1])),
     ylab=expression(paste(E[2])), 
     main=paste0("corr=",signif(cor(r,g),3)))
abline(0,1,col=2,lwd=2)
f <- function(a,x,y,p=0.95) mean(x<=a & y<=a)-p
a95 <- uniroot(f,lower=2000,upper=20000,x=r,y=g)$root
abline(a95,-1,lwd=2,col=1)
text(8500,0,"95% of data below this line",col=1,cex=1.2,adj=c(0,0))
r <- log2(r)
g <- log2(g)
plot(r,g,lwd=2,cex=0.2,pch=16,
     xlab=expression(paste(log[2], " ", E[1])),
     ylab=expression(paste(log[2], " ", E[2])),
     main=paste0("corr=",signif(cor(r,g),3)))
abline(0,1,col=2,lwd=2)







