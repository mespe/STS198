# Office hours
# May 9th

# Difference between apply functions

# sapply
# tapply
# lapply

# tapply - table apply,
# splits the data, then applies a function to each subset

tapply(mtcars$mpg, mtcars$cyl, median)

#  the alternate way to do this
mpg_by_cyl = split(mtcars$mpg, mtcars$cyl)
a = lapply(mpg_by_cyl, median)

# sapply - "s" stands for simplify
b = sapply(mpg_by_cyl, median)

c = lapply(mpg_by_cyl, unique)

lapply(c, min)

x = 1:10
y = rnorm(10, x * 2)

mod = lm(y ~ x)

summary(mod)
anova(mod)

################################################################################
# Why split and lapply

by_cyl = split(mtcars, mtcars$cyl)

lapply(by_cyl, summary) # every column at once

# Really inefficient to summarize every column
tapply(mtcars$mpg, mtcars$cyl, summary) # only mpg column
tapply(mtcars$am, mtcars$cyl, summary) # only am column
tapply(mtcars$disp, mtcars$cyl, summary)

# More advanced - using custom functions
lapply(by_cyl, function(x) summary(lm(mpg ~ wt, data = x)))

################################################################################

load("../../data/airline_delay2016.rds")

tmp = subset(airline, ORIGIN == "SMF" & ARR_DELAY >= 15 & DEST_STATE_ABR == "CO")

write.csv(tmp, file = "~/tmp.csv")

med_by_state = tapply(airline$ARR_DELAY, airline$DEST_STATE_ABR, mean, na.rm = TRUE)

air_split = split(airline, airline$DEST_STATE_ABR)

# Example that would be difficult in Excel
sort(table(unlist(lapply(names(air_split), function(x) {
    tmp = subset(air_split[[x]], ARR_DELAY >= med_by_state[x])
    names(sort(table(tmp$ORIGIN)))[1:5]
    }))), decreasing = TRUE)
