
# This is making a data frame for rats. Just name vairable as id, sex, weight, and length for each colums.
# The id made from paste0() function by glu rat with number 1 to 10. Note: There are paste0() and paste().
# The sex colum use factor() function. and take rep() to repeat male and female, 5 for each.
rats <- data.frame(
        id = paste0("rat", 1:10), 
        sex = factor(rep(c("female", "male"),each = 5)), 
        weight = c(2, 4, 1, 11, 18, 12, 7, 12, 19, 20), 
        length = c(100,105, 115, 130, 95, 150, 165, 180, 190, 175)
        )

# Make another data frame with smae rat id with different order, but each one have new secretID.
# This data frame use to practice the match two data set.
ratsTable <- data.frame(
        id = paste0("rat", c(6, 9, 7, 3, 5, 1, 10, 4, 8, 2)),
        secretID = 1:10
        )

# compare the match() function in cbind()
# Note: match() return the index of each elements in the first vector that match to second vector.
# Here is the describ from the from genomics Class:
# Remember that match gives you, for each element in the first vector, the index of the first match in the second vector.

wrongDemo <- cbind(rats, ratsTable)
# The match(ratsTable$id, rats$id) mean take ratsTable id to match rats id and return the index of match element in rats
# Then, use rats[ ] to rerange the rats with match return.
correctDemo <- cbind(rats[match(ratsTable$id, rats$id), ], ratsTable)

# Using merge() function to match and combind two data frame.
# Note: merge() take care everything and remove one additional id coloum.
# Question: What happen if there are some row has no match?
# Ans: It will disappear from the x argument (rats) 
# Because the "no match in the x (rats) will return N/A, so it will remove from the data frame. 
# merge() function use match(y,x) to to do the merge. 
ratsMerged <- merge(rats, ratsTable, by.x = "id", by.y = "id")
ratsMerged[order(ratsMerged$secretID), ]

# practice split(), tapply, and dpplyr
# split(x,f) vector or data frame ,x, containing values to be divided into groups by the second argument, f.
# Here is mean split weight vector by sex vector. (in Data frame each column is a vector.)
sp <- split(rats$weight, rats$sex)
# here sp is list contant 2 list
#
# lapply is Loop apply. Here it mean apply mean() function into each element (each list) in the sp.
lapply(sp, mean)

#tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)
tapply(rats$weight, rats$sex, mean)

# dplyr need to install package before loading library. (Why I feel I did install this package before?)
library(dplyr)

# When you load in dplyr, it will show some object be masked from xxx package....I guess it mean those 
# function will not working.
sexes <- group_by(rats, sex)
summarise(sexes, ave = mean(weight))


rats %.% group_by(sex) %.% summarise(ave = mean(weight))
# The functions work via simple substitution so that x %.% f(y) is translated into f(x, y).





