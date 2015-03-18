## Monte Carlo Simulation

library(downloader)

url<-"https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/babies.txt"
filename <- tempfile()
download(url,destfile="babies.txt")
dat <- read.table("babies.txt",header=TRUE)
smokers <- sample(dat$bwt[dat$smoke==1],10)
nonsmokers <- sample(dat$bwt[dat$smoke==0],10)
mean(smokers)-mean(nonsmokers)

for(i in 1:10) {
        smokers <- sample(dat$bwt[dat$smoke==1],10)
        nonsmokers <- sample(dat$bwt[dat$smoke==0],10)
        cat("observed difference = ",mean(smokers)-mean(nonsmokers),"ounces\n")
}


###

ttestgenerator <- function(n) {
        # note that here we have a false "smokers" group where we actually
        # sample from the nonsmokers. this is because we are modeling the *null*
        smokers = sample(dat$bwt[dat$smoke==0], n)
        nonsmokers = sample(dat$bwt[dat$smoke==0], n)
        return((mean(smokers)-mean(nonsmokers))/sqrt(var(smokers)/n + var(nonsmokers)/n))
}
ttests <- replicate(1000, ttestgenerator(10))

hist(ttests)

qqnorm(ttests)
abline(1,0.125)

ttests <- replicate(1000, ttestgenerator(3))
qqnorm(ttests)
abline(0,1) ## Not really understand why use (0,1)


qs <- (seq(0,999)+0.5)/1000
qqplot(qt(qs,df=2*3-2),ttests,xlim=c(-6,6),ylim=c(-6,6))
abline(0,1)

## Parametric simulations for the observations

## When we can't have access to all real population, we use information from real population to create a similar 
## population with same information as real population. 
## As a example: We know mean and SD of real population, so we can make a population  wtih same mean and SD.

nonsmokerweights <- rnorm(5000, 
                          mean=mean(dat$bwt[dat$smoke==0]), 
                          sd=sd(dat$bwt[dat$smoke==0]))


ttestgenerator2 <- function(n) {
        # note that here we have a false "smokers" group where we actually
        # sample from the nonsmokers. this is because we are modeling the *null*
        smokers = sample(dat$bwt[dat$smoke==0], n)
        nonsmokers = sample(nonsmokerweights, n)
        return((mean(smokers)-mean(nonsmokers))/sqrt(var(smokers)/n + var(nonsmokers)/n))
}

ttests <- replicate(1000, ttestgenerator2(10))

hist(ttests)

qqnorm(ttests)
abline(0,1)

ttests <- replicate(1000, ttestgenerator2(3))
qqnorm(ttests)
abline(0,1) ## Not really understand why use (0,1)


qs <- (seq(0,999)+0.5)/1000
qqplot(qt(qs,df=2*3-2),ttests,xlim=c(-6,6),ylim=c(-6,6))
abline(0,1)

## Optional homework:
## 1. How different are the N(0,1) and t-distribution when degrees of freedom are 18? How about 4?
## Note: What is N(0,1)

## 2. For the case with 10 samples, what is the distribution of the sample median weight for smokers? 
## How does the mean, median of the distribution compare to the population median? 
## 3. Repeat the code above but simulated income for American and Canadians. Is the median income the same? 
## is the mean income the same?


