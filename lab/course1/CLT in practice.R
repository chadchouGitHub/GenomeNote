
## CLT in practice: The last practice is t-distribution practice. Here will use CLT to repeat the same thing
## , but hope to see the sample size different in the ??????

## Load this data have 846 obs. not just 24 for previous practice.
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- tempfile()
download(url,destfile=filename)
dat <- read.csv(filename)
head(dat)

## This data have male and female mice in Sex variable (First col)
## Below is look into Female mice only. (Total F is 425 obs)
## Take value from Bodyweight when Sex=="F"
hfPopulation <- dat[dat$Sex=="F" & dat$Diet=="hf",3] 
controlPopulation <- dat[dat$Sex=="F" & dat$Diet=="chow",3]
## Caculate the diff of two group
mu_hf <- mean(hfPopulation)
mu_control <- mean(controlPopulation)
print(mu_hf - mu_control)


x<-controlPopulation ## x is controlPopulation. Doing this just to make below code simple.
N<-length(x)
## Compute the population standard deviations with population variance.
popvar <- mean((x-mean(x))^2)
##  Note that we do not use the R function sd because this is to compute the population 
##  based estimates that divide by the sample size - 1.
##  ***** So to be mathematically correct we do not use sd or var. ******
identical(var(x),popvar) ## the variance is different.

identical(var(x)*(N-1)/N, popvar)

## So to be mathematically correct we do not use sd() or var()
## Define a new function for this.

popvar <- function(x) mean( (x-mean(x))^2)
popsd <- function(x) sqrt(popvar(x)) 

## Use the new function to get sd of hfpopulation

sd_hf <- popsd(hfPopulation)
sd_control <- popsd(controlPopulation)

## Number of sample: Ns sample() will take Ns to sample the hfPopulation or controlPopulation.
## use sapply() and define a function in sapply().
## use replicate() to repeat 1000 time for each n took from Ns.
Ns <- c(1,3,6,9,12,25,50,75,100)
B <- 1000 #number of simulations
res <-  sapply(Ns,function(n){
        replicate(B,mean(sample(hfPopulation,n))-mean(sample(controlPopulation,n)))
})
## res become a matrix *** not a data frame ****

library(rafalib)
## seq(along=Ns) in here is the same as 1:4 for the "for()" loop function
mypar2(3,3)
for(i in seq(along=Ns)){
        title <- paste("N=",Ns[i],"Avg=",signif(mean(res[,i]),3),"SD=",signif(popsd(res[,i]),3)) ##popsd defined above
        qqnorm(res[,i],main=title)
        qqline(res[,i],col=2)
}

## Here is where the sample size starts to matter more.
## Here  we use var() in simple(population) not the popvar(), the function we define early. 

Ns <- c(3,12,25,50)
B <- 10000 #number of simulations
##function to compute a t-stat
computetstat <- function(n){
        y<-sample(hfPopulation,n)
        x<-sample(controlPopulation,n)
        (mean(y)-mean(x))/sqrt(var(y)/n+var(x)/n)
}
res <-  sapply(Ns,function(n){
        replicate(B,computetstat(n))
})
mypar2(2,2)
for(i in seq(along=Ns)){
        qqnorm(res[,i],main=Ns[i])
        qqline(res[,i],col=2)
}

