# Prep for class 9
# Major topics to cover:
# 1. Strats for writing short pieces
# 2. More exploration (briefly)
# 3. Talk about issues with the data, introduce the concept of bias
# 4. Prep for midterm (Wed)

# How to write short pieces:
# Start with the conclusions - it is easier to structure a piece
#  knowing where you are going

# load("../../data/distracted.Rda")
load(url("https://github.com/mespe/STS198/blob/master/data/distracted.Rda?raw=true"))

source("https://raw.githubusercontent.com/mespe/STS198/master/R/funs/sort_factor.R")

library(ggplot2)

source("../inclass/class_8.R")
ggplot(distracted, aes(x = MDRDSTRD)) +
    geom_bar() +
    coord_flip()

known_dist = subset(distracted, !MDRDSTRD %in% names(dist_tbl)[1:3])

nrow(known_dist)

# What are the most frequent distractions?
ggplot(known_dist, aes(x = sort_factor(MDRDSTRD))) +
    geom_point(stat = "count") +
    coord_flip()

# Is there variation between states?
ggplot(known_dist, aes(x = sort_factor(STATE))) +
    geom_point(stat = "count") +
    coord_flip()

unique(distracted$MDRDSTRD)

cell_vars = c("While Talking or Listening to Cellular Phone",
              "Other Cellular Phone Related",                                  
              "While Manipulating Cellular Phone")

cell_dist = subset(distracted, MDRDSTRD %in% cell_vars)
table(cell_dist$MDRDSTRD)

ggplot(cell_dist, aes(x = sort_factor(STATE))) +
    geom_point(stat = "count") +
    coord_flip()
