## Confidence Intervals

library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- tempfile()
## This if() skip the {} for the download() function.
if (!file.exists(filename)) download(url,destfile=filename)       
dat <- read.csv(filename)
chowPopulation <- dat[dat$Sex=="F" & dat$Diet=="chow",3]

## We can get average or mean directly from the chowPopulation vector.
mu_chow <- mean(chowPopulation)
print(mu_chow)

## But most of time we will not have total population in hand. 
## So we took sample to see how much different between sample average in total population average.

N <- 5
hf <- sample(chowPopulation,N)
## Standard error (SE) is always small than standard diviation (SD). 
se <- sd(hf)/sqrt(N) ## standard error
print(se)

pnorm(2)-pnorm(-2)
## pnorm() take quantiles of SD or SE and return probabilities
## qnorm() take probabilities and return quantiles of SD or SE.
Q <- qnorm(1- 0.05/2)
interval <- c(mean(hf)-Q*se, mean(hf)+Q*se )
interval

## Which covers μX or mean(chowPopulation). 
## However, we can take another sample and we might not be as lucky. 
## In fact the theory tells us that we will cover μX 95% of the time. 

library(rafalib)

B <- 250
mypar2(1,1)
plot(mean(chowPopulation)+c(-3.5,3.5),c(1,1),type="n",
     xlab="weight",ylab="interval",ylim=c(1,B))
abline(v=mean(chowPopulation))
for(i in 1:B){
        hf <- sample(chowPopulation,N)
        se=sd(hf)/sqrt(N)
        interval <- c(mean(hf)-Q*se, mean(hf)+Q*se )
        ## covered is logical vector to check the interval with real mean. to see if real mean 
        ## cover within interval. 
        covered<-mean(chowPopulation)<= interval[2] & mean(chowPopulation)>=interval[1]
        print (covered) ## this line I use to see what the covered have in the value.
        color <- ifelse(covered,1,2) # use ifelse() to decide the color value 1 for ture 
        ## 2 for false
        print(color) ## this I use to see waht is the color value "1" or "2"
        lines( interval, c(i,i),col=color) ## lines() is draw a line between points.
        ## interval is two element vector, and c(i,i) also two elements vector.
        ## each serve as x and y to give the lines() functions to draw the line between 2 points.
}



## Connection between confidence intervals and p-values

## Does the confidence interval cover the 0 ?
## ??? Not very clear in this.  But in T-test. It is the difference of the mean between two groups.
## So Cover 0 will mean no difference in this interval?????
## 95% cf is +/- 2 SD or +/-2 SE in t-state???
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv"
if (!file.exists(filename)) download(url,destfile=filename)
dat <- read.csv(filename)
controlIndex <- which(dat$Diet=="chow")
treatmentIndex <- which(dat$Diet=="hf")
control <- sample(dat[controlIndex,2], 10)
treatment <- sample(dat[treatmentIndex,2], 10)
t.test(treatment,control)

t.test(treatment,control,conf.level=0.948)





