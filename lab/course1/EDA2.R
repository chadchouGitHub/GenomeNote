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

















