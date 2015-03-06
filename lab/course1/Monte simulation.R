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
abline(0,1)


qs <- (seq(0,999)+0.5)/1000
qqplot(qt(qs,df=2*3-2),ttests,xlim=c(-6,6),ylim=c(-6,6))
abline(0,1)




