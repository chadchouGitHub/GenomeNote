# Introduction to Linear Models
library(rafalib)

mypar2()
# Objects falling
set.seed(1)
g <- 9.8 ## meters per second
n <- 25
tt <- seq(0,3.4,len=n) ##time in secs, t is a base function
d <- 56.67  - 0.5*g*tt^2 + rnorm(n,sd=1)

plot(tt,d,ylab="Distance in meters",xlab="Time in seconds")

# Father son’s heights
#install.packages("UsingR")
library(UsingR)
x=father.son$fheight
y=father.son$sheight

plot(x,y,xlab="Father's height",ylab="Son's height")
