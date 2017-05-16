# May 1st, 2017
# STS 198

source("class_8.R")

# Questions from class -
# tapply review
# ordering by age
# subset returns 0 obs - How to avoid copying/pasting or writing by hand

# Looking at where we left off last time
head(distracted)

# How does tapply work?
# Key clarifications:
# 1. the first and second arguments must be
#   vectors/columns of the same length
# 2. the third argument is a function which is applied
#   to the subsets of the first argument
tapply(distracted$VEH_NO, distracted$STATE, sum)

# How to sort the ages - this takes a little effort
# Matt will upload code later to do this
# but you can also think of other plots that could do the same thing
table(bike$PBAGE)
# NAs are introduced by the conversion to numeric
ggplot(bike, aes(x = as.numeric(PBAGE))) +
    geom_point(stat = "count") +
    coord_flip()

################################################################################
# How can you avoid copying and pasting?
# Even copying and pasting can lead to problems
# First: get the list of the categories
unq_ped = unique(bike$PEDCGP)

# Next pull out the elements you are interested by index/position
unq_ped[c(5, 7, 13)]

# "Pedestrian in Roadway – Circumstances Unknown"
# "Dash/Dart-Out"                                
# "Unique Midblock"                              

# Here is a different set
bb = unique(bike$PEDCTYPE)[c(49,50)]
subset(bike, PEDCTYPE %in% bb)

# The above (pulling out by index) is better than copying and pasting
# because weird characters (like the double -- below) are preserved
vv = c("Backing Vehicle – Non-Trafficway – Parking Lot",
       "Waiting to Cross – Vehicle Turning")


tmp = subset(bike, PEDCGP %in% unq_ped[c(5,7,13)])

################################################################################
# Picking up from where we left off last class
# We previously subset the data to only include the rows
# where the distracted was "known"
head(known_dist)

# The categories of distraction
sort(table(known_dist$MDRDSTRD))

# Using the techniques above
aa = unique(known_dist$MDRDSTRD)
cell_var = aa[c(3,9,10)]

cell_dist = subset(known_dist, MDRDSTRD %in% cell_var)

# Why is Tenn so different?
ggplot(cell_dist, aes(x = sort_factor(STATE))) +
    geom_point(stat = "count") +
    coord_flip()

# What issues exist in these data?
# There are some biases -
# Selection bias
# reporting bias
# even though these data represent the entire population

