## Permutation tests

## When we don't have enough information to make "fake" population to simulation. For example, we only have mean or 
## SD. So we need to come up a population to test. This is Permutation test.

## Example 
## We only have mean from each group "smoke" and "None Smoke"
dat <- read.table("babies.txt", header=TRUE)
set.seed(0)
N <- 50
smokers <- sample(dat$bwt[dat$smoke==1],N)
nonsmokers <- sample(dat$bwt[dat$smoke==0],N)
obs <- mean(smokers)-mean(nonsmokers)

## Is the observed difference significant?  (We can't use t-test or CLT. We don't have SD or SE)

## Take advantagge of premutation test. If there is no different between group, shuffling the data 
## should have no effect in result.
## So shuffing male and female in the group.

## shuffing data 1000 times, every time take "N" sample to smoke or none smoke group.
## return different of mean
avgdiff <- replicate(1000, {
        all <- sample(c(smokers,nonsmokers)) ## Here is shuffing data
        smokersstar <- all[1:N]
        nonsmokersstar <- all[(N+1):(2*N)]
        return(mean(smokersstar) - mean(nonsmokersstar))
})

## draw the hist and put obs on the hist(avgdiff)
hist(avgdiff)
abline(v=obs)

## How many of the null means are bigger than the observed value? 
## That proportion would be the p-value for the null.

mean(abs(avgdiff) > abs(obs))  ## mean of logic return, true is 1 and false is 0




