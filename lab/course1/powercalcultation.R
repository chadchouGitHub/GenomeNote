## Power calculation

library(downloader)
url<-"https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- "mice_pheno.csv"
if (!file.exists(filename)) download(url,destfile=filename)
dat <- read.csv(filename)
hfPopulation <- dat[dat$Sex=="F" & dat$Diet=="hf",3]
controlPopulation <- dat[dat$Sex=="F" & dat$Diet=="chow",3]
mu_hf <- mean(hfPopulation)
mu_control <- mean(controlPopulation)
print(mu_hf - mu_control)

### In t-Test of null hypothesis, we did not get p < 0.05. So we can't reject the null. 
### it mean we don't have enough to reject null. (Not enough power?)
### It is not tell use no difference between two group.


### I make extract practice to plot all p-value with each N=5 test and N=30 test.

### to see if any p will small than 0.05 in N=5 sample
N <- 15
B <- 250
pValue <- list()
for (i in 1:B) {
hf <- sample(hfPopulation,N)
control <- sample(controlPopulation,N)
tTest <- t.test(hf,control)
names(tTest)
pTemp <- tTest$p.value
print(pTemp)
pValue[i] <-pTemp
}
print(pValue)
plot(1:B,pValue)

###  type I error is defined as rejecting the null when we should not.
###  In p<0.05 we can make 1 error in every 20 test. It is type I error. false positive.

### Not reject the null when we should. This is called a type II error or a false negative. 

### NOTE: Good explain in type I and II error

## The above example is a type II (false native : when we should reject null, and we didn't)
## If we set the p<0.25, than we will reject null in this case, but we will have 1 out of 4 time 
## to male type I error.

## Note that there is nothing magical about 0.05 and 0.01. it is about what error you will risk.

####  Power calculation ###
N <- 12
alpha <- 0.5
B <- 2000

## define a function to calculate the possiblity of type II error (false negative)

reject <- function(N, alpha=0.05){
        hf <- sample(hfPopulation,N) 
        control <- sample(controlPopulation,N)
        pval <- t.test(hf,control)$p.value ## extract p.value directly from t.test result
        pval < alpha ## this return true of false to reject
}
rejections <- replicate(B,reject(N))

## Our power is just the proportion of times we correctly reject. 
## So with N=12 our power is only:
mean(rejections)

## compare different N in power calculation.


Ns <- seq(5, 50, 5)
## Here is define function in the sapply() function by include mean() to calculate rejection.
power <- sapply(Ns,function(N){
        rejections <- replicate(B, reject(N))
        mean(rejections)
})

plot(Ns, power, type="b")


N <- 30
alphas <- c(0.1,0.05,0.01,0.001,0.0001)
power <- sapply(alphas,function(alpha){
        rejections <- replicate(B,reject(N,alpha=alpha))
        mean(rejections)
})
plot(log10(alphas), power, xlab="log (base 10) alpha", type="b")

### Try to do Homework

N <-10
alphas <- c(0.1,0.05,0.01,0.001,0.0001)
power10 <- sapply(alphas,function(alpha){
        rejections <- replicate(B,reject(N,alpha=alpha))
        mean(rejections)
         })

plot(log10(alphas), power10, xlab="log (base 10) alpha", ylab="power", type="b",col=3)



N <-15
alphas <- c(0.1,0.05,0.01,0.001,0.0001)
power15 <- sapply(alphas,function(alpha){
        rejections <- replicate(B,reject(N,alpha=alpha))
        mean(rejections)
})
par(new = TRUE)
plot(log10(alphas), power15, xlab="log (base 10) alpha",ylab="power",axes = FALSE, type="b",col=2)

N <-25
alphas <- c(0.1,0.05,0.01,0.001,0.0001)
power15 <- sapply(alphas,function(alpha){
        rejections <- replicate(B,reject(N,alpha=alpha))
        mean(rejections)
})
par(new = TRUE) ## This line allow to add new feature in previous plot
plot(log10(alphas), power15, xlab="log (base 10) alpha",ylab="power",axes = FALSE, type="b",col=1)
legend("topleft", legend =c("power10","power15","power25"), col=3:1, pch=1) ## add legend 

# This is not a perfect solution for this homework, but I am OK with it.





