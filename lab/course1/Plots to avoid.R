## Plots to avoid

library(UsingR)

pie(browsers,main="Browser Usage (August 2013)") ## No tell where is the "browsers"

## So I use example in the pie() help
## Example of pie()

require(grDevices) ## loading "grdevices" into r
pie(rep(1, 24), col = rainbow(24), radius = 0.9)

pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry",
                      "Apple", "Boston Cream", "Other", "Vanilla Cream")
pie(pie.sales) # default colours
## I am going to make my own browsers vector
browsers <- c(1,9,20,26,44)
names(browsers) <- c("Opera", "Safari", "Firefox","IE","Chrome")

barplot(browsers,main="Browser Usage (August 2013)")

## Now I can use browsers to draw pie or bar.....
