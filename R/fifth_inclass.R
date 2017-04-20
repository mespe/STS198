# Plotting with ggplot2
# Apr 17, 2017
# STS 198

# Load the package we need with the library command
# Remember, the package has to be installed first,
# and will need to be reloaded each new R session
library(ggplot2)

load("../data/health_costs.rda")

# The basic structure of ggplot is:
ggplot(health, aes(x = Average.Total.Payments))

# This builds the plot and tells ggplot which variables
# go on the x and y axes, but does not fill in the "middle"
# To fill in the middle, we need to give it a geom (geometry)

# The most basic geom is the histogram
ggplot(health, aes(x = Average.Total.Payments)) +
    geom_histogram()

# If we want to compare groups, we can do this inside the function
ggplot(health, aes(x = Average.Total.Payments,
                   fill = Provider.City == "SACRAMENTO")) +
    geom_histogram()

# This is not quite right - there are so many less Sacramento values
# that you cannot see them on the plot
# A density plot solves this issue
ggplot(health, aes(x = Average.Total.Payments,
                   fill = Provider.City == "SACRAMENTO")) +
    geom_density(alpha = 0.5)

# Looking at only the Sacramento data
sac = subset(health, Provider.City == "SACRAMENTO")

# Even though the density plot worked well with the
# question: how does Sacramento compare to the rest of the US?
# If does not work well here
ggplot(sac, aes(x = Average.Total.Payments,
                fill = Provider.Name)) +
    geom_density(alpha = 0.4)

# There are too many groups on top of eachother
# We can try just colored lines without the fill
ggplot(sac, aes(x = Average.Total.Payments,
                color = Provider.Name)) +
    geom_density(alpha = 0.5)

# Not much better
# What we really want is each category grouped together
# and then the categories side-by-side
# Boxplots are good for this
ggplot(sac, aes(x = Provider.Name,
                y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_boxplot()

ggplot(sac, aes(x = Provider.Name,
                y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_violin()

# Boxplots work well for a categorical and a numeric value
# but don't work with 2 numeric values
# scatterplots are better to compare two numeric variables
# Just like before, we can color the point by group
ggplot(sac, aes(x = Average.Covered.Charges,
                y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_point() 

# To help us see the relationships between the groups
# we can add a smoother
ggplot(sac, aes(x = Average.Covered.Charges,
                y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_point() +
    geom_smooth()

# The last plot is still really busy
# there are too many points at the low values
# one way to deal with this is to separate the
# the different facilities into separate plots
ggplot(sac, aes(x = Average.Covered.Charges,
                y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_point(aes(size = Total.Discharges)) +
    geom_smooth() +
    facet_wrap(~Provider.Name)

################################################################################

# Lets look at the heart data again
sort(unique(sac$DRG.Definition))

# Here I used a new function, the %in% operator
# %in% just returns TRUE in each position of the vector
# on the left side are in the right side
var = c("291 - HEART FAILURE & SHOCK W MCC",
        "292 - HEART FAILURE & SHOCK W CC",                                      
        "293 - HEART FAILURE & SHOCK W/O CC/MCC")                                    
# Doesn't look like a function
sac_heart = subset(sac, DRG.Definition %in% var)

# same as (DRG.Def == var[1]) | (DRG.Def == var[2]) | ...

ggplot(sac_heart, aes(x = Provider.Name,
                      y = Average.Total.Payments,
                      color = Provider.Name)) +
    geom_boxplot()

