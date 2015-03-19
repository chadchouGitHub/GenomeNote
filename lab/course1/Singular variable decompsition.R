## Singular Value Decomposition

## What is Singular Value Decomposition? I have no idea.....

## All I need to know for now is...
## The main mathematical result we use to achieve dimension reduction is the singular value decomposition (SVD).

## Example: Note it was 100 random number, I make it 10. It is fast and easy to look by eye.
x <- rnorm(10)
y <- rnorm(10)
z <- cbind(x,x,x,y,y)

## z is a 5x100 matrix

SVD <- svd(z)
## svd() out put a list content d, u, and v varible with different elements inside.
## I think the d,u,v is With:
## Y=UVD...?? (Y is z here)
## U is an m×n orthogonal matrix
## V is an n×n orthogonal matrix
## D is an n×n "diagonal" matrix


round(SVD$d,2) ## There is no big different w/ or w/o round()

### Note: We can use svd() information to re-build a new z matrix very similar to z.

newz <- SVD$u[,1:2] %*% diag(SVD$d[1:2]) %*% t(SVD$v[,1:2]) ## How this work??? %*%  is Matrix product (Matrix 
## multiplication) , binary. Check online to see how to do this. Basicly is using two matrix to make one matrix.

 deltaZ<- abs(newz-z)

max(abs(newz-z)) ## This just try to show you very small difference between two matrix.


## Now let us see how SVD help us in Data analysis.

## Make sure you have all the package install before you load the library.
library(tissuesGeneExpression)
data(tissuesGeneExpression)

set.seed(1) ## set seed to have random number the same every time.
ind <- sample(nrow(e),500) ## Why need nrow(e)? This is mean 1:nrow(e). 
## If x has length 1, is numeric (in the sense of is.numeric) 
## and x >= 1, sampling via sample takes place from 1:x.

## Below is use ind to pick e matrix by row ,"1" in the apply() mean row for matrix vector. 
## than apply scale function. finalize wit t() transform.

Y <- t(apply(e[ind,],1,scale)) ## standardize data for illustration

## Now we have Y matrix. We can use scd() to make s to have all u v d.

s <- svd(Y)
U <- s$u
V <- s$v
D <- diag(s$d) ##turn it into a matrix

## With u v d, we can make new Y very similar to Y (Yhat)

Yhat <- U %*% D %*% t(V)
resid <- Y - Yhat
max(abs(resid))

i <- sample(ncol(Y),1) # random pick up a "i", it will use for col in the plot. 
## (So the sample range is col number  in the sample() function. )

plot(Y[,i],Yhat[,i]) ## compare two martix at any col in the plot. they are similar
abline(0,1)

boxplot(resid)


plot(s$d)

d <- s$d ## I try to see the length of d (It is the same as col number.???)

## Here is going to remove the last 4 col by a k variable. k= col number -4
## When make new Y matrix Yhat. We will only take 1 to K col to multiplication matrix.
k <- ncol(Y)-4
Yhat <- U[,1:k] %*% D[1:k,1:k] %*% t(V[,1:k])

## Why the new matrix Yhat still has 189 col, when we only use k col to do matrix production?

## So far I see, as long as the v, u, d are Y's svd(), it can always re-assemble a new Y matrix, but include 
## all col will give most similar matrix to Y. But you can take few off from v,u,d.


resid <- Y - Yhat 
Range <- quantile(Y,c(0.01,0.99)) ## use quantile to set the range of y axis.
boxplot(resid,ylim=Range,range=0) ## I don't know how the range=0 help in the plot?

boxplot(resid,ylim=Range)

plot(s$d^2/sum(s$d^2)*100,ylab="Percent variability explained") ## variablity explained??? 
## I don't know why "s$d^2/sum(s$d^2)".

plot(s$d^2/sum(s$d^2),ylab="Percent variability explained")

plot(cumsum(s$d^2)/sum(s$d^2)*100,ylab="Percent variability explained",ylim=c(0,100),type="l")
## We can also make cumulative plot



## Note: Why in "d" the first and second element take most part of precentage in the "d" total.
## What is this mean? Does this mean half of the col (elements: 189) in "d" can skip?


## Below example shows that you only need 94 col from u,v d to make new Y (Yhat).
## I don't know how it decide to use 94. I think it is about half of col (189/2).
k <- 94
Yhat <- U[,1:k] %*% D[1:k,1:k] %*% t(V[,1:k])
resid <- Y - Yhat
boxplot(resid,ylim=Range,range=0)
boxplot(resid[,1:10],ylim=Range, range=0) ## Note: resid is a 500x189 matrix each col have 500 numbers. So 
## I use another line to look just first 10 col of resid. The 189 cols are too small to see the box.

## Therefore, by using only half as many dimensions we retain most of the variability in our data
## Note: This is call half dimensions...

## Note: Here is how to see the variability in two Y and Yhat matrix.

var(as.vector(resid))/var(as.vector(Y)) # as.vector() will convert Y and resid to a group of numbers, not matrix. 
## So we can use var() to get variation of each grroup. 
## Note: the resid is Y-Yhat, so the fraction of resid's var in Y's var will tell us how much the difference the
## Yhat has from Y matrix.
## [1] 0.03914882

## We say that we "explain 96% of the variability". ****** So NOT keep the 96% similiarity.****

## We can use D to know this w/o to make Yhat and resid matrix.

1-sum(s$d[1:k]^2)/sum(s$d^2)


##  SVD not for two highly correction col. Here is a example.



m <- 100
n <- 2
x <- rnorm(m)
e <- rnorm(n*m,0,0.01)
Y <- cbind(x,x)+e  ## e was add to every element in this matrix, so the 200 numbers are different by "e".
## But the col 1 and col 2 are highly correlated. 
Y1 <-  cbind(x,x) ## I use Y1 to compare to Y w/o "e". Two colunms are the same.

cor(Y) ## We can use cor() function to see how they are correlated between each col pair.

rowMeans(Y)

d <- svd(Y)$d
d[1]^2/sum(d^2)

## We only explain 1% of variability of this matrix.


m <- 100
n <- 25
x <- rnorm(m)
e <- rnorm(n*m,0,0.01)
Y <- replicate(n,x)+e
d <- svd(Y)$d

cor(Y) ## This will be 25x25 matrix here. All are 0.99999
sum(d[1:20]^2/sum(d^2))

sum(d[1]^2/sum(d^2))

## Check for vraicbility, there is no big different between "1:20" and just "1".




























