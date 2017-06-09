## Office hours
# 28 Apr 2017
library(ggplot2)

load("../../data/bike_FARS.Rda")

most_freq_pos = tapply(bike$PEDPOS, bike$STATE, function(x)
    names(sort(table(x), decreasing = TRUE))[1])

most_freq_pos = as.data.frame(most_freq_pos)

table(most_freq_pos)

ggplot(most_freq_pos, aes(x = most_freq_pos)) +
    geom_bar() +
    coord_flip()

ggplot(bike, aes(x = PEDPOS)) +
    geom_bar() +
    coord_flip() +
    facet_wrap(~STATE)

ggplot(most_freq_pos, aes(x = most_freq_pos,
                          y = row.names(most_freq_pos))) +
    geom_point()

# 1. subset to only accidents in travel lane
# 2. plot

travel_lane = subset(bike, PEDPOS == "Travel Lane")

ggplot(travel_lane, aes(x = PBSWALK)) +
    geom_bar() +
    facet_wrap(~STATE)
   
