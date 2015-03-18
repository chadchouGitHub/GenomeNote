## Introduction to Advanced Statistics for the Life Sciences
library(rafalib)
mypar2()

## Data organized in three tables
## sampleInfo
## geneExpression: This is a matrix, but have 8793 rows. Just like geneAnnotation.
## geneAnnotation

##can be isntalled with:
library(devtools)
install_github("genomicsclass/GSE5859Subset")
library(GSE5859Subset)
data(GSE5859Subset) ##this loads the three tables
dim(geneExpression)

head(sampleInfo)


sampleInfo$group
head(geneExpression)
## sampleInfo match to colnames of geneExpression
match(sampleInfo$filename,colnames(geneExpression)) ## This return the index of variable at second parameter.

dim(geneAnnotation)
head(geneAnnotation)
##  geneAnnotation match to rownames of geneExpression
head(match(geneAnnotation$PROBEID,rownames(geneExpression)))










