# Class 8 - divide and conquer
# 26 Apr 2017
# STS198

# Data
load(url("https://github.com/mespe/STS198/blob/master/data/distracted.Rda?raw=true"))

# Convenience function
source(url("https://raw.githubusercontent.com/mespe/STS198/master/R/funs/sort_factor.R"))

library(ggplot2)

# Starting to explore the data to better understand what we are looking at
ggplot(distracted, aes(x = MDRDSTRD)) +
    geom_bar()
# This is pretty cluttered - coord_flip make it easier to read
ggplot(distracted, aes(x = MDRDSTRD)) +
    geom_bar() +
    coord_flip()

# Bar plots are :
# 1. Very popular -
# 2. Misleading - they give each point area, when it only has 1 dimension
#
# point plots are better - but use barcharts if that is what your audience
# expects or wants. Just know that generally point plots are better
ggplot(distracted, aes(x = sort_factor(MDRDSTRD))) +
    geom_point(stat = "count") +
    coord_flip()

# What are the top causes of distraction?
dist_tbl = sort(table(distracted$MDRDSTRD), decreasing=TRUE)

# There are three categories that are some type of unknown/not distracted
# Including these dwarfs the other causes
# Let's look at only the points where it was known the driver was distracted
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

# what about the top distraction between different states?
ggplot(known_dist, aes(x = sort_factor(MDRDSTRD))) +
    geom_point(stat = "count") +
    coord_flip() +
    facet_wrap(~STATE)

#  Big plot - does not display nice on a low-res display
#  but still informative.
#  Shows
#  1. there is variation between states
#  2. not every state has all types of distraction
#  3. the top distraction varies by state
#
#  How do we explore this further?

# Top distractions, across all states
table(known_dist$MDRDSTRD)

# What if we want to know what the top distraction was
# in each state? We can do this by just subsetting repeatedly
CA = subset(known_dist, STATE == "California")

sort(table(CA$MDRDSTRD), decreasing = TRUE)[1:4]

#  Can we do it all at once?
# NEW FUNCTION - tapply
# tapply takes an X, and an index to group by, and then
# applies a function to each sub-group of X
# table is a specialized version of this that applies a count function
# to each group
# But now we can apply any function

# Max number of vehicles by state
sort(tapply(known_dist$VEH_NO, known_dist$STATE, max))

# Mean
sort(tapply(known_dist$VEH_NO, known_dist$STATE, mean))

# Sum
sort(tapply(known_dist$VEH_NO, known_dist$STATE, sum))

# But we can also provide our own functions!
################################################################################
# WARNING - this is more advanced, and you can safely ignore this for now if
# you find it confusing/overwhelming
################################################################################

# Remember a function is something with a name
# which you provide some input to.
# It does something with the input
# and then returns something

# to get the top distraction, we need to
# 1. Create a table of the frequency of each distraction
# 2. sort so that the most frequent distraction is first
# 3. take the name of the first item

# EXAMPLE
# function(x){
#     my_table = table(x) # Step 1
#     my_table = sort(my_table, decreasing = TRUE) # Step 2
#     names(my_table)[1] # Step 3
# }

# We can do this in a single line inside tapply
result = tapply(known_dist$MDRDSTRD, known_dist$STATE, function(x)
    names(sort(table(x), decreasing=TRUE))[1])

# whats the difference
table(tapply(known_dist$MDRDSTRD, known_dist$STATE, function(x)
    sort(names(table(x)), decreasing=TRUE)[1:3]))

# If the function provided to tapply returns more than one item
# your output will be multi-dimensional
# Right now we don't know how to deal with this, so be careful
# Eventually we will get there, but for now, try to only use functions
# which return a single value for each group

################################################################################
