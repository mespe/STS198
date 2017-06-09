load("../../data/bike_FARS.Rda")
source("../funs/sort_factor.R")

my_var = unique(bike$PEDLOC)[1:3]

my_var = unique(bike$PEDLOC)[c(1, 2, 3)]

int_acc = subset(bike, PEDLOC %in% my_var)

library(ggplot2)

ggplot(int_acc, aes(x = PEDLOC)) +
    geom_bar()

ggplot(int_acc, aes(x = PEDLOC)) +
    geom_bar() +
    facet_wrap(~sort_factor(STATE, decreasing = TRUE)) +
    coord_flip()

ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
table(mtcars$cyl)

ggplot(mtcars, aes(x = 1:nrow(mtcars),
                   y = cyl,
                   color = cyl %in% c(4,6))) +
    geom_point()
