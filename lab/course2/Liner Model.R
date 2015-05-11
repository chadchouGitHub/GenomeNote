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
lines(tt,d,col=2)
# Father son’s heights
#install.packages("UsingR")
library(UsingR)
x=father.son$fheight
y=father.son$sheight

plot(x,y,xlab="Father's height",ylab="Son's height")

# What if x, y has different length? Can the plot still work?

y <- y[1:1000]

# It will show
# Error in xy.coords(x, y, xlabel, ylabel, log) : 
# x' and 'y' lengths differ

## Random samples from multiple populations

dir <- system.file(package="dagdata")
filename <- file.path(dir,"extdata/femaleMiceWeights.csv")
dat <- read.csv(filename)

mypar2(1,1)
stripchart(Bodyweight~Diet,data=dat,vertical=TRUE,method="jitter",pch=3,main="Mice weights")


g <- 9.8 ## meters per second
n <- 25
tt <- seq(0,3.4,len=n) ##time in secs, t is a base function
f <- 56.67  - 0.5*g*tt^2
y <-  f + rnorm(n,sd=1)

plot(tt,y,ylab="Distance in meters",xlab="Time in seconds")
lines(tt,y,col=10)
lines(tt,f,col=1) # solid line representing the true trajectory
# Compare two different line here. One with rnorm() one don't.

# Find  least squares estimates (LSE) with this example.

tt2 <-tt^2
fit <- lm(y~tt+tt2) ## is this same as lm(y~tt) and lm(y~tt2) just one output to two ouput??? No!!!
fitTT<- lm(y~tt)
fitTT2 <- lm(y~tt2)
summary(fit)$coef
summary(fitTT)$coef
summary(fitTT2)$coef
# summary(fit)$coef
# Estimate Std. Error    t value     Pr(>|t|)
# (Intercept) 57.4039031  0.5658171 101.453115 6.995699e-31
# tt          -0.8406516  0.7707621  -1.090676 2.872176e-01
# tt2         -4.7380313  0.2189623 -21.638569 2.553833e-16
# > summary(fitTT)$coef
# Estimate Std. Error   t value     Pr(>|t|)
# (Intercept)  66.15215   1.827544  36.19729 8.774893e-22
# tt          -16.94996   0.921451 -18.39486 2.970806e-15
# > summary(fitTT2)$coef
# Estimate Std. Error   t value     Pr(>|t|)
# (Intercept) 56.882165 0.30343290 187.46209 3.945306e-38
# tt2         -4.968702 0.05693361 -87.27187 1.665949e-30




# The LSE
# Let’s write a function that computes the RSS for any vector β
# residual sum of squares (RSS)

# This function is caculate RRS need "y" and "tt" in the Global Environment first.
rss <- function(Beta0,Beta1,Beta2){
        r <- y - (Beta0+Beta1*tt+Beta2*tt^2)
        return(sum(r^2))
}


Beta2s<- seq(-10,0,len=100)
plot(Beta2s,sapply(Beta2s,rss,Beta0=55,Beta1=0),
     ylab="RSS",xlab="Beta2",type="l")
##Let's add another curve fixing another pair:
## The second is add a lines() not new plot So no ylab, and xlab. 
## New line use different color.
Beta2s<- seq(-10,0,len=100)

lines(Beta2s,sapply(Beta2s,rss,Beta0=65, Beta1=0),col=2)
# sapply() apply a function over a list or Vector.
# Here function is rrs which take 3 parameters. 
# Beta0 = 65 and Beta1 = 0. Beta2 = Beta2s (a list of numbers from -10 to 0. Total 100 numbers.)

# Can't sapply two parameters to rrs() function. Don't know what to do about this.


##   More on Galton (advanced)
## He noted that if he tabulated the number of father/son height pairs and followed all the x,y values having 
## the same totals in the table they formed an ellipses. 

### I need answer for this Homework:
# Homework what are β0 and β1 in terms of μx,μy,σx,σy, and ρ. 
# It turns out that the least squares estimate of β1 can be written in terms of 
# the sample correlation and standard deviations.








