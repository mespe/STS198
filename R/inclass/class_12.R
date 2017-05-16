# STS 198
# Review of tapply, lapply, split
# 10 May

#  Get some data
load("../../data/bike_FARS.Rda")

# Functions covered last time
# lapply()
# split()

# lapply is generic - we used split() to create a list to hand to lapply
# but lapply() will take a list not created by split(), or even some other
# objects (yes, lapply can take a vector as input as well)

################################################################################
# What is a list?

# A list is just a bunch of stuff collected together and given a name
# unlike a data.frame, the objects saved in a list can be of different lengths
# we can even store lists inside of lists

# A simple list with different data types and lengths
a = list(1:5, letters[6:20], "bob")

# What are the lengths?
lapply(a, length)

# Why did that work?  lapply() goes over each element in the input (first argument)
# and applies the function (second argument) to that piece
# so lapply(a, length) applied the length function to each element in a

# Long way to do this: 
length(a[[1]])
length(a[[2]])
length(a[[3]])

# what is the expected result?
length(a[1])

# Remember that the single "[" only goes down one level
# and returns the same type it took in - so my_list[1] returns a list
# my_list[1:3] returns a list with three elements
# This is helpful for subsetting a list

# What is the difference between these?
a[1] # vs.
a[[1]]

# As stated earlier, you can store a list inside a list
b = list(my_list = a, other_stuff = 3:10)
length(b)

b[[1]][[3]]

# Why would you do this? Why use lists?
# simulate some data
x = 1:10
y = rnorm(10, x*2)

# fit a linear model (don't worry about the details of this
mod = lm(y ~ x)

# A linear model has a lot of pieces - we want to store them all together
# under the same name so we can easily find them
# the result of lm() is a big list with sub-lists
str(mod)

# The summary() functions knows how to go through this and pull out the information we care about
summary(mod)

################################################################################
# But we are not modeling - why do we care about lists for this class?

# Example with bike data
# First split the bike data by state
bike_by_state = split(bike, bike$STATE)

# We can see how many observations there are by state
length(bike_by_state)

# We can look at the first 2 observations for each state
lapply(bike_by_state, head, n = 2)

# What if we want to know how many rows and columns there are in each piece?
# this is a bit of a mess - we have to look through a bunch of output to
# find the info we care about
str(bike_by_state)

# We can just return the thing we care about
lapply(bike_by_state, ncol)
lapply(bike_by_state, nrow)

# lapply becomes really useful when we define a custom function
# pull out the max for VEH_NO and PER_NO columns for each state
lapply(bike_by_state, function(x){
    c(max(x$VEH_NO), max(x$PER_NO))
})

# The long way to do this
c(max(bike_by_state[[1]]$VEH_NO), max(bike_by_state[[1]]$PER_NO))
c(max(bike_by_state[[1]]$VEH_NO), max(bike_by_state[[1]]$PER_NO))

# We can define this function outside of the lapply() function,
# but then we have to give it a name
# (I know bob is not the best name for this function)
bob = function(x){
    c(max(x$VEH_NO), max(x$PER_NO))
}

# This works the same as defining the function inside lapply()
lapply(bike_by_state, bob)

################################################################################
# One last new funciton - 
# apply()
# apply takes a data.frame as its 1st argument, and applies a function (third argument)
# to either the columns or rows - specified by the second argument
# you provide either 1 or 2 to say if you want the function applied by rows or columns
# 1 = row
# 2 = column

# Get the max value by column
apply(bike, 2, max)

# This makes more sense - the data are mostly numeric
apply(mtcars, 2, mean)

# You can combine an lapply() and apply()
# to split() into small subsets
# lapply over those data sets,
# and then summarize by row or column
lapply(bike_by_state, function(x) apply(x, 2, mean))

# This is a mess - follow the above example
lapply(bike_by_state, apply(2, unique))

# Just like lapply(), you can specify a custom function
apply(bike, 2, bob)

# Remember that tapply is easier when you only want to apply a function
# to a single column of the data set
# Only use lapply() if you need something more complicated
tapply(bike$PBSZONE, bike$STATE, unique)

################################################################################

# New Functions:
# lapply()
# split()
# apply()
