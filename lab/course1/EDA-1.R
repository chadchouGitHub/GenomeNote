##   Exploratory Data Analysis 1

## EDA

##   Histograms

## 
## install.packages("UsingR") ## I have this package installed already.
library(UsingR)
x=father.son$fheight
## One approach is to simply list out all the numbers for the alien to see. 
## Here are 20 randomly selected heights of 1,078.

round(sample(x,20),1)


hist(x)
bins <- seq(floor(min(x)),ceiling(max(x))) ## No different w/ or w/o bins

hist(x,breaks=bins,xlab="Height",main="Adult men heights") ## No different w/ or w/o breaks
hist(x,xlab="Height",main="Adult men heights")

## 
###   Empirical Cummulative Density Function: This is not a graphic function.
### Use this function to make a vector, and plot the vector to become a cummuative curve.
### Note ecdf() return a function vector

myCDF <- ecdf(x) 

## We will evaluate the function at these values:
xs<-seq(floor(min(x)),ceiling(max(x)),0.1) 
### and then plot them:
plot(xs,myCDF(xs),type="l",xlab="x=Height",ylab="F(x)")








