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






















