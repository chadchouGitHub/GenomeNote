
set.seed(779) ##for illustration
N=25
x<- rnorm(N,0,1)
y<- rnorm(N,0,1)
x[1]<-5;x[2]<-7
cat("t-test pval:",t.test(x,y)$p.value)
cat("Wilcox test pval:",wilcox.test(x,y)$p.value)
set.seed(779) ##for illustration
N=25
x<- rnorm(N,0,1)
y<- rnorm(N,0,1)

cat("t-test pval:",t.test(x,y)$p.value)
cat("Wilcox test pval:",wilcox.test(x,y)$p.value)
# Two t-test w/ or w/o outliner
# t-test pval: 0.04439948 ; t-test pval: 0.1589672
#wilcox test Wilcox test pval: 0.1310212; Wilcox test pval: 0.3066718

# Sow different  in pVal
#Wilcox test more ok with outliner.

#The basic idea is to 
#1) combine all the data, 
#2) turn the values into ranks, 
#3) separate them back into their groups, and 
#4) compute the sum or average rank and perform a test.




stripchart(list(x,y),vertical=TRUE,ylim=c(-7,7),ylab="Observations",pch=21,bg=1,cex=1.25)
abline(h=0)

xrank<-rank(c(x,y))[seq(along=x)]
yrank<-rank(c(x,y))[-seq(along=y)]
stripchart(list(xrank,yrank),vertical=TRUE,ylab="Ranks",pch=21,bg=1,cex=1.25)
ws <- sapply(x,function(z) rank(c(z,y))[1]-1)
text(rep(1.05,length(ws)),xrank,ws)

W <-sum(ws) 

#W is the sum of the ranks for the first group. Statistical theory 
#(based on CLT) tells us that this statistic is approximated by the normal distribution.


#we can construct a z-score as follows:

n1<-length(x);n2<-length(y)
Z <- (mean(ws)-n2/2)/ sqrt(n2*(n1+n2+1)/12/n1)
print(Z)


