# STS 198 class 13
# Spring 2017

# Load data
# Change these lines to the location where you downloaded the data sets
polls = read.csv("../../data/2016_election/2016_preelection_polls.csv")
results = read.csv("../../data/2016_election/2016_State_level_Presidential_results.csv")

# source functions - 
source("../funs/mapUSA.R")
source("../funs/state2abb.R")

# Testing the basic mapping function
plotMap(polls$trump, polls$state)

# Start with a question: How do you plot if the results are stored in a list
# with one value per element in the list?
# Create a list with one thing in each element
ans = tapply(polls$undecided, polls$end.date, mean, na.rm = TRUE,
             simplify = FALSE)
# First try - see if the coersion function as.data.frame
# knows what to do in this case
# Kinda works? It looks right when printed to the console
tryA = as.data.frame(ans)

# Try plotting
ggplot(tryA, aes(x = rownames(tryA),
                  y = ans)) +
    geom_point()

# didn't work - why not?
str(tryA)
# Looks like we have a data frame with lists as sub-elements
# not what we were expecting

# tryB - try unlisting the list
# unlist() is a function that deconstructs the list
# effectively "dumping out" all the elements into a single "bucket"
tryB = unlist(ans)

# This looks better - it is now a vector
str(tryB)

# can make this into a data.frame
final = as.data.frame(tryB)

# At last, we can plot
ggplot(data = NULL, aes(x = rownames(final),
                        y = final$tryB)) +
    geom_point() +
    geom_smooth() +
    theme_bw()

################################################################################
# (SIDE NOTE) Dealing with the NaNs

# What is a NaN?
# NaN stands for Not a Number - how did this happen?

# Let's look at one
# Figure out the NaN
subset(polls, end.date == "2015-08-01")

# Ah ha - there is only one value of undecided here, and it is NA
# When we take mean(NA, na.rm = TRUE), it removes the only value
# hence we get NaN
# ("na.rm = TRUE" mean to remove the NA values before the computation
#   It is an argument in sum(), mean(), median(), and others...

# Since we know what caused this, we are comfortable removing it
tryB = subset(tryB, !is.nan(tryB))

# If starting from the list
lapply(ans, is.nan)

# Gets the number of NaNs in the list
# Use sapply to simplify to a vector
table(sapply(ans, is.nan))

################################################################################

# Let's look at the polling data
# I do not expect that you have done all this -
# This is mostly to give you some of the methods and techniques
# in case you need them

################################################################################

# Start with a simple plot

ggplot(polls, aes(y = trump,
                  x = as.Date(end.date))) +
    geom_point() +
    facet_wrap(~population)

# The different populations are creating some funny things in the plot
# We can create every possible population subset at once
by_pop = split(polls, polls$population)
names(by_pop)

# How many rows are in each population
lapply(by_pop, nrow)

# Likely Voters is the largest, and is typically the most meaningful
# (Separating people by party makes more sense in the primary stages)
likely = by_pop[["Likely Voters"]]

# Again start simple
ggplot(likely, aes(x = as.Date(end.date),
                   y = trump))+
    geom_point()

# What if we wanted to use the total # of people, not the percentages?
lapply(by_pop, function(x) {
    sum((x$trump/100) * x$number.of.observations, na.rm = TRUE)
    })

# Just want to look at the last month - 
var = as.character(sort(unique(likely$end.date))[209:234])

last_month = subset(likely, end.date %in% var)

# This plot started very basic, and elements were added incrementally
# It is not finished - needs some polish
# but it is very useful for investigating what might be happening here
ggplot(last_month, aes(x = as.Date(end.date),
                       y = trump)) +
    geom_point(color = "red") +
    geom_smooth(color = "red", se = FALSE) +
    geom_point(aes(y = clinton), color = "blue") +
    geom_smooth(aes(y = clinton), color = "blue", se = FALSE) +
    theme_bw() +
    geom_hline(yintercept= 50, type = "dashed") +
    facet_wrap(~state) +
    ylim(c(25,75))

# How many observations in each state?
sort(table(last_month$state), decreasing = TRUE) #Interesting - some states were not polled very much

# Look at a basic plot of these data
plotMap(last_month$trump, last_month$state) + scale_fill_gradient(low = "blue", high = "red")


################################################################################
# If we want to compare to the state-level results, we need to somehow compare between the two data sets
# This is not so easy - one data set uses the full state names, while the other
# uses an abbreviation.

# I created some functions to do the conversion
state2abb(results$State)

# Create a new column - lower case "state"
# this name has to match the column in the other data set in order for
# ggplot to put the correct line with the correct panel
results$state = state2abb(results$State)

# Finally, putting it all together
ggplot(last_month, aes(x = as.Date(end.date),
                       y = trump)) +
    geom_point(color = "red") +
    # geom_smooth(color = "red", se = FALSE) +
    geom_point(aes(y = clinton), color = "blue") +
    # geom_smooth(aes(y = clinton), color = "blue", se = FALSE) +
    theme_bw() +
    geom_hline(yintercept= 50, type = "dashed") +
    facet_wrap(~state) +
    ylim(c(25,75)) +
    geom_hline(data = results, aes(yintercept = Trump_pct), color = "red") + 
    geom_hline(data = results, aes(yintercept = Clinton_pct), color = "blue")
