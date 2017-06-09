# Class 8 - divide and conquer
# 26 Apr 2017
# STS198

# Data
load(url("https://github.com/mespe/STS198/blob/master/data/distracted.Rda?raw=true"))

# Convenience function
source(url("https://raw.githubusercontent.com/mespe/STS198/master/R/funs/sort_factor.R"))

library(ggplot2)

ggplot(distracted, aes(x = sort_factor(STATE))) +
    geom_bar() +
    coord_cartesian(xlim = c(40:51)) +
    coord_flip() +
    theme_bw() 

dist_tbl = table(distracted$MDRDSTRD)

dist_tbl = sort(dist_tbl, decreasing = TRUE)

known_dist = subset(distracted, !MDRDSTRD %in% names(dist_tbl)[1:3])

unique(known_dist$MDRDSTRD)

ggplot(known_dist, aes(x = sort_factor(STATE))) +
    geom_bar() +
    coord_cartesian() +
    coord_flip() +
    theme_bw() 

ggplot(known_dist, aes(x = sort_factor(MDRDSTRD))) +
    geom_bar() +
    coord_cartesian() +
    coord_flip() +
    theme_bw() 

ggplot(known_dist, aes(x = sort_factor(MDRDSTRD))) +
    geom_bar() +
    coord_cartesian() +
    coord_flip() +
    theme_bw() +
    facet_wrap(~STATE)


################################################################################

sort(tapply(distracted$VEH_NO, distracted$STATE, max))

results = tapply(distracted$MDRDSTRD, distracted$STATE, table)

str(results)

class(results)
results[[1]]

names(results)
results["Alabama"]

head(results)

a = lapply(results, function(x) sort(x)[1])

table(sapply(a, names))

