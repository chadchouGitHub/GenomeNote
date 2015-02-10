## Central Limit Theorem and the t-distribution

## 5% values of larger than 2 (in absolute value)
## I still don't understand this
1-pnorm(2)+pnorm(-2)

## pnrom() use to caculate p-value????


library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- tempfile()
download(url,destfile=filename)
dat <- read.csv(filename)
controlPopulation <- dat[dat$Sex=="F" & dat$Diet=="chow",3]
hfPopulation <- dat[dat$Sex=="F" & dat$Diet=="hf",3]

library(rafalib)
mypar2(1,2)
hist(hfPopulation)
hist(controlPopulation)

## use qq-plots to confirm that the distribution are relatively close to being normally distributed.

mypar2(1,2)
qqnorm(hfPopulation);qqline(hfPopulation)
qqnorm(controlPopulation);qqline(controlPopulation)





