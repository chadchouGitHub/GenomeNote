## Exploratory Data Analysis 2

## Here describes EDA and summary statistics for "paired data".

install.packages("UsingR")
library(UsingR)
## When I first load UsingR, an error message show ggplot2 can't load. Try to unload and re-load, still not work.

### I refresh all package, and load UsingR again. the ggplot2 work. Here is the error message.

## Loading required package: Hmisc
## Loading required package: ggplot2
## Error : .onLoad failed in loadNamespace() for 'tcltk', details:
##         call: dyn.load(file, DLLpath = DLLpath, ...)
## error: unable to load shared object '/Library/Frameworks/R.framework/Versions/3.1/Resources/library/tcltk/libs/tcltk.so':
##         dlopen(/Library/Frameworks/R.framework/Versions/3.1/Resources/library/tcltk/libs/tcltk.so, 10): Library not loaded: /usr/X11/lib/libXft.2.dylib
## Referenced from: /usr/local/lib/libtk8.6.dylib
## Reason: image not found
## In addition: Warning messages:
##         1: package ‘UsingR’ was built under R version 3.1.2 
## 2: package ‘Hmisc’ was built under R version 3.1.2 
## 3: package ‘ggplot2’ was built under R version 3.1.3 
## Error: package ‘ggplot2’ could not be loaded

##---------------------------------------------------------------------------##

data("father.son") ## A classic examples is the father/son height data used by Galton
x=father.son$fheight
y=father.son$sheight
plot(x,y,xlab="Father's height in inches",ylab="Son's height in inches",
     main=paste("correlation =",signif(cor(x,y),2))) ## signif() is round(). "2" is two digi after point. But here is 
## "0.50" so it shows 0.5 only.

## Note correlation between x and y is 0.5 In this plot, we can see taller father has taller son.


## We motivate this statistic by trying to predict son’s height using the father’s.
## Suppose we are asked to guess the height of randomly select sons by tell you his father's high.




## Stratification

groups <- split(y,round(x)) ##split y by round(x)  ????
boxplot(groups)


print(mean(y[ round(x) == 72]))
## round(x)==72 will give a logic list T or L, and use T and F to select the y for mean.
## only x bwtween 71.50 ~72.49 will give 72
##  a <- y[ round(x) == 72]
##  b <- x[round(x)==72]
## I use this to line to check...


### Bi-variate normal distribution
## Not sure I understand this yet!!
## Here is something I may understand so far:
## By fix X in x, then Y will be normal distribution.
## Note: Fix a value x and look at all the pairs (X,Y) for which X=x. Generally, 
## in Statistics we call this exercise conditionion. We are conditioning Y on X.

groups <- split(y,round(x)) 
mypar2(2,2) ## You need to load library(rafalib) before to call mypar2()
for(i in c(5,8,11,14)){
        qqnorm(groups[[i]],main=paste0("X=",names(groups)[i]," strata"),
               ylim=range(y),xlim=c(-2.5,2.5))
        qqline(groups[[i]])
}


groups[[5]] ## group 63 i=5
groups[[8]] ## group 66 i=8
groups[[11]] ## group 69 i=11
groups[[14]] ## group 72 i=14
summary(round(x)) ## There are group 59 ~75 base on round(x)

## Here is correlation demo.
## (There is a very long  bala bala.........to define the corrleation... I don't get it so .. 
## going to check with other  reference)


x=(x-mean(x))/sd(x)
y=(y-mean(y))/sd(y)
means=tapply(y,round(x*4)/4,mean) ## How this work??? y and round(x*4) has same length Then what is the means for?
## It is a array, so each "x" has a group of y. It is the mean of each x group. So in the means array, only 25 groups 
## split by x
## Also in the tapply() round(x*4)/4 will become the name of array. (just like index. )

fatherheights=as.numeric(names(means)) ## So here we need to make name to number again to plot the number with y.
mypar2(1,1)
plot(fatherheights,means,ylab="average of strata of son heights",ylim=range(fatherheights))
abline(0,cor(x,y))


##  Spearman’s correlation (This is new.)

## Just like the average and standard deviation are not good summaries 
## when the data is not well approximated by the normal distribution, the correlation is not a good summary 
## when pairs of lists are not approximated by the bivariate normal distribution. 

a=rnorm(100);a[1]=10 ## random produce 100 number, and them assign the first element a[1] to 10.

b=rnorm(100);b[1]=11 ## random produce 100 numbers, and then make the b[1] to 11.

plot(a,b,main=paste("correlation =",signif(cor(a,b),2))) ## signif() is round(), so what is the different?

## By adding two very large a[1] b[1] into each a and b groups. We have cor() about 0.5, 
## but two group is not correlated.







