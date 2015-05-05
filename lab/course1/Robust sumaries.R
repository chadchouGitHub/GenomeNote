# Robust summaries and log transformation

# All these function are in the base package.

set.seed(1)
x=c(rnorm(100,0,1)) ##real distribution
x[23] <- 100 ##mistake made in 23th measurement
boxplot(x)

mean(x)
sd(x)

#> mean(x)
#[1] 1.108142  ## it is random  number from 0 to 1, how the mean is bigger than 1. Because one outliner "100"
# is big enough to mess up the mean.
#> sd(x)
#[1] 10.02938  # So does the SD.

#----The Median Absolute Deviance-- mad()------------------------------#
# The median absolute deviace (MAD) is a robust summary for the standard deviation.
#defined by computing the differences between each point and the median and taking 
# the median of their absolute values:
# 1.4826median{|Xi−median(Xi)|} The "1.4826 " just  a scale factor that guarantees an unbiased. ????

mad(x)
# [1] 0.8857141 Not sure how much close to real mean, but make much more sense.



#--------------------------Spearman correlation---------------------------#

# This is compare to correlation.

set.seed(1)
x=c(rnorm(100,0,1)) ##real distribution
x[23] <- 100 ##mistake made in 23th measurement
y=c(rnorm(100,0,1)) ##real distribution
y[23] <- 84 ##similar mistake made in 23th measurement
library(rafalib)
mypar(1,1)
plot(x,y,main=paste0("correlation=",round(cor(x,y),3)),pch=21,bg=1,xlim=c(-3,100),ylim=c(-3,100))
abline(0,1)

# The correlation=0.99 is caculate from cor(x,y) But real cor is not 0.99
set.seed(1)
x1=c(rnorm(100,0,1)) ##real distribution
y1=c(rnorm(100,0,1)) ##real distribution

library(rafalib)
mypar(1,1)
plot(x1,y1,main=paste0("correlation=",round(cor(x1,y1),3)),pch=21,bg=1,xlim=c(-3,3),ylim=c(-3,3))
abline(0,1)

# The real cor is 0.001, if there is no outline


# Below use spearman cor to compare to cor including outliner.

# To apply spearman cor the cor() need to assign method="spearman"
mypar(1,2)
plot(x,y,main=paste0("correlation=",round(cor(x,y),3)),pch=21,bg=1,xlim=c(-3,100),ylim=c(-3,100))
plot(rank(x),rank(y),main=paste0("correlation=",round(cor(x,y,method="spearman"),3)),pch=21,bg=1,xlim=c(-3,100),ylim=c(-3,100))
abline(0,1)

# The real cor w/o outliner is 0.001 when outline (100,84) point in this 100 points (all between 0 to 1)
# the cor become 0.99, but the spearman cor is 0.066 much more sense.

hist(ratios) # Where is this data set?????

#log(x/y)=log(x)−log(y)=−(log(y)−log(x))=log(y/x)

x <- 2^(-5:5) ##this 1/32,1/16,1/8,...,1,2,...,32
mypar2(1,2)
plot(x)
abline(h=1)
plot(log2(x))
abline(h=0)

#------------------------------------------------------
x=2^seq(1,5)
y=c(rev(1/x),1,x)
Names=c(paste0("1/",rev(x)),1,x)
mypar(1,1)
plot(seq(along=y),y,xlab="",ylab="",type="n",xaxt="n")
text(seq(along=y),y,Names,cex=1.5)
abline(h=1)
#------------------------------------------------------

plot(seq(along=y),y,xlab="",ylab="",type="n",log="y",xaxt="n")
text(seq(along=y),y,Names,cex=1.5)
abline(h=1)


