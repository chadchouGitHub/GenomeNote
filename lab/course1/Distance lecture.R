## Distance lecture

### 
library(devtools)
install_github("genomicsclass/tissuesGeneExpression")

library(tissuesGeneExpression)
data(tissuesGeneExpression)
table(tissue) ## There are two table() function in the R (for now in my r program).

## One is in the base package, one is in BiocGenerics package
## How I know this table() is belong to what package running here.????
## 

##  Distance in high dimensions

## # Note in the online ebook is very confuse by use g and i in sample and formaula. 
## There are not the sameple g or smaple i. It is dimension of g and i in the formular.

x <- e[,1]
y <- e[,2]
z <- e[,87]
sqrt(sum((x-y)^2))
## This is col1 (X)  and col2 (y) distance
sqrt(sum((x-z)^2))
## Same as before z  and z distance

sqrt( crossprod(x-y) ) ## Another way to do sqrt(sum((x-y)^2)). 
## It just avoid "^2"... Can see how it is fast?

sqrt( crossprod(x-z) )

### e is expression data in practice Data Set I just load in.
## It is matrix, and each col is sample, each row is feature or id....???

### The above x or y are col (know as sample with many rows: features).
### to compare two sample x y, we are interesting to know the x y distance. So we
## use sqrt(sum((x-y)^2)), it is definition by .......????


## To easy and fast to do this. We can use dist() function..but this function compute distance between rows
## We need to use t() to transform col to row.

d <- dist(t(e))
class(d)

as.matrix(d)[1,2] ##?? why is 1 and 2;  row 1 and col 2 ????? 
### [1,2] is x,y. in this matrix [2,1] will be the same as 1,2
### This is a samples by samples matrix (pairs of sample): So when x=y mean the same sample compare, 
## and the distance is "0"
## check the "f" vetcor .....



f <- as.matrix(d)
as.matrix(d)[2,1]

as.matrix(d)[1,87]


## f we run dist on e it will compute all pairwise distances between genes. 
## This will try to create a 22215×22215 matrix that may kill crash your R sessions.
## Because e has 22215 rows, but just has 189 col
## use str() to see how the "e"  havs.

str(e)


