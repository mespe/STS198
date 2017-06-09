# Office hours -

load("../../data/CA_arrivals2016.rda")

library(ggplot2)

ls()

ggplot(CAarrivals, aes(x = CARRIER, 
                       y = ARR_DELAY,
                       fill = CARRIER)) +
    geom_boxplot()
in       
