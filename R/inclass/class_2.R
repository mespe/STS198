# Second class - in class script

# functions we have covered so far:
# ls()
# head()
# tail()
# length()
# unique()

# Load the data - don't worry about these functions for now
load(url("https://github.com/mespe/STS198/blob/master/data/health_costs.rda?raw=true"))

# Lets take a quick look at the top and bottom of the data using head() and tail()
head(health)
tail(health)

# How many states are there? We expect 50
unique(health$Provider.State)
# Seems DC is included, so we have 51

# Can we get the number of observations by state?
# table() does the trick
# table() creates table of the number of observations in each category
table(health$Provider.State)

# By default, it is sorted alphabetically - not really helpful here
# We want to sort by the number of observations
# ther than try to pick out the highest and lowest counts by hand
# Save the table so we can manipulate it without re-typing the command
stateTbl = table(health$Provider.State)

# sort() helps us, and can return the output as either decreasing or increasing
# We can save the sorted table as well
sortTbl = sort(stateTbl, decreasing = TRUE)

# We want to look at only the top 10
# In R, there are often multiple ways to get the same result
# Using head() and modifying the default argument "n"
head(sortTbl, n = 10)

# Using indexing
# the ":" operator creates an sequence from the first number to the second
# This does the same as head(sortTbl, n = 10)
sortTbl[1:10]

# We can also create a vector of items we want to subset
# c(1,5,3,9) creates an vector with 4 items, whose values are 1,5,3,9
# when this vector is used inside the "[ ]", it extracts the values at those indices
# this is useful for pulling out items that are not in sequence
sortTbl[c(1,5,3,9)]
# Is FL is higher than expected? - check into this

######### What else do we want to check? #####
# we want to look at the range of values in each column
# summary() is a helpful function
# although it does not return much for the character vectors
summary(health)

# There is a really high discharges number - can we find out which one that is?
# "==" is a logical operator. It compares every element of the left-hand side
# to the value on the right-hand side
# the output is a logical vector (a vector composed of TRUE or FALSE)

# the which() function takes this logical vector and returns which indices are TRUE
# We can use this to explore the characteristics of the really high discharge
health$Provider.State[which(health$Total.Discharges == 3383)]
health$Provider.Name[which(health$Total.Discharges == 3383)]
health$DRG.Definition[which(health$Total.Discharges == 3383)]

# We will learn a more efficient way of doing this next week

# How many cities are there?
length(unique(health$Provider.City))
# This is misleading - some cities share names
# Be Careful - city is not unique
# Zip code has a related issue - there can be multiple zip codes for each city 
length(unique(health$Provider.Zip.Code))

# what we really want is to see how many unique values of CITY STATE there are

# this doesn't work - why not? What did c() do?
tail(c(health$Provider.City, health$Provider.State))

# This seems to do what we want
# the paste() function takes character vectors, and puts them together
length(unique(paste(health$Provider.City, 
                    health$Provider.State)))

############### End of material from class #############

# New functions covered:
#
# table()
# sort()
# summary()
# which()
# c()
# paste()
# "==" (logical comparison)
# "[" (subset)
