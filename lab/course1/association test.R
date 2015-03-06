## Association tests

tab <- matrix(c(3,1,1,3),2,2)
rownames(tab)<-c("Poured Before","Poured After")
colnames(tab)<-c("Guessed before","Guessed after")
tab

fisher.test(tab,alternative="greater")


disease=factor(c(rep(0,180),rep(1,20),rep(0,40),rep(1,10)),
               labels=c("control","cases")) ## Make 20% of case in first 200, and 20% case 
                                            ## at another 50.
genotype=factor(c(rep("AA/Aa",200),rep("aa",50)),
                levels=c("AA/Aa","aa")) ## First 200 will be AA/Aa, and another 50 will be aa
dat <- data.frame(disease, genotype)
dat <- dat[sample(nrow(dat)),]##shuffle them up
head(dat)

## To create the appropriate two by two table we will use the function table.
table(genotype)

table(disease)

## If you you feed the function two factors it will tabulate all possible pairs and 
## create the two by two table:
## Note that you can feed table n factors and it will tabulate all n-tubles.


tab <- table(genotype,disease)

## odds ratio (OR)
##  if you are an “aa”: 10/40, the odds of having the disease 
## if you are an “AA/Aa”: 20/180, and take the ration: (10/40)/(20/180)
## Why it is not 10/(10+40) and 20/(20+180)???

p=mean(disease=="cases") ## mean() the logical results. (true is 1 and false is 0)
p ## (30/250)

### Totally no idea what is this????????

expected <- rbind(c(1-p,p)*sum(genotype=="AA/Aa"),
                  c(1-p,p)*sum(genotype=="aa"))
dimnames(expected)<-dimnames(tab)
expected

chisq.test(tab)

tab<-tab*10
tab

fit <- glm(disease~genotype,family="binomial",data=dat)
coeftab<- summary(fit)$coef
coeftab


