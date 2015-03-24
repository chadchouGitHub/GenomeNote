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
## treatment and control.
boxplot(dat,xlab="Group",ylab="Response",xlab="Group",ylab="Response",cex=0)
## boxplot make bar and lines from mean, SD, ....and Highest lowest...
stripchart(dat,vertical=TRUE,method="jitter",pch=16,add=TRUE,col=1)
## stripchart() put every number dots on the boxplot.





