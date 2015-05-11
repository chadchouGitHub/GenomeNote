# Matrix Algebra Notation


# language of linear models:
# The main point of this entire exercise is to show how we can write the models above 
# using matrix notation and then explain how this is useful for solving the least squares equation.

##------check for math formular in the html file of the matrial online----------------

#

library(UsingR)
y=father.son$fheight
head(y)
n <- 25
tt <- seq(0,3.4,len=n) ##time in secs, t is a base function
X <- cbind(x1=tt,x2=tt^2)
head(X)
dim(X)







# Use matrix() to replace cbind()
# Number  fill by columns

N <- 100; p <- 5
X <- matrix(1:(N*p),N,p)
head(X)


# Number fill by row, when byrow = TRUE


N <- 100; p <- 5
X <- matrix(1:(N*p),N,p,byrow=TRUE)
head(X)