# Third class - subsetting
# STS 198
# 10 Apr 2017

# functions previously covered:
# ls()
# head()
# tail()
# length()
# unique()
# table()
# sort()
# summary()
# which()
# c()
# paste()
# "==" (logical comparison)
# "[" (subset)


# Picking up from last class
# lets look at the healthcare data again
load(url("https://github.com/mespe/STS198/blob/master/data/health_costs.rda?raw=true"))

# refresher - what variables are we dealing with
summary(health)

# Last time we used very clunky method to subset the data
# to find the observation with really high discharge #s
which(health$Total.Discharges == 3383)
health$Provider.Name[112970]

# But what if there are lots of records which match
# We can save the matching indices as a variable to avoid entering them by hand
idx = which(health$Total.Discharges >= 70)
health$Provider.Name[idx]

# But this is not helpful when we want multiple variables

###### Introducing the subset() function ####
# It takes a data frame and a set of logical conditions to subset by
sac_health = subset(health, Provider.City == "SACRAMENTO")

# Verify that it resulted in only obs for Sacramento
table(sac_health$Provider.City)

# We can look at this subset of the data 
# and compare it to the full dataset
summary(sac_health)
summary(health)

# The same tricks we used before can be used with this subset data
sac_proc = table(sac_health$DRG.Definition)
length(unique(health$DRG.Definition))
length(unique(sac_health$DRG.Definition))

# What if we want to look at only one condition
# We can assign this to a variable to avoid having to retype the full thing
variable = "292 - HEART FAILURE & SHOCK W CC"

# But subsetting again, we get just Sacramento obs which also have "HEART FAILURE..."
sac_heart_fail = subset(sac_health, DRG.Definition == variable)

# Again, we can use the same functions to look at these data
summary(sac_heart_fail)


# What if we want to compare to the national average for this procedure
# we can use the same variable and same methods to subset
all_heart_fail = subset(health, DRG.Definition == variable)
summary(all_heart_fail)

# we can use more logical conditions than "==" to subset
# there are many options: 
# == is equal to
# != is not equal to
nrow(subset(health, Provider.City != "SACRAMENTO"))

# >= and <= or > and <
# Are used with numeric or integer values
# Does not make sense with character vectors
subset(health, Average.Covered.Charges > 8e5)

# What if we want multiple conditions in the subset
# Example: Want discharges between 42.78 and 100
# We can subset twice, but this is pretty clunky
sub1 = subset(health, Total.Discharges > 42.78)
sub2 = subset(sub1, Total.Discharges < 100)

# We can combine comparisons using & and |
# & is logical "and"
# | is logical "or"
# (| is often referred to as the "pipe" and is above the enter key on most keyboards)
# Use "()" around each part of the comparison
my_subset = subset(health, (Total.Discharges > 42.78) & (Total.Discharges < 100) & (Provider.City == "SACRAMENTO"))
summary(my_subset)

# The "()" are important here to ensure you get 
# Total.Discharges less than 42.78 or greater than 100 
# and only Sacramento
# Moving the "()" changes the results
my_subset = subset(health, ((Total.Discharges < 42.78) | (Total.Discharges > 100)) & (Provider.City == "SACRAMENTO"))

# We can use these statements to get the number of obs that match 
# the conditions using the table() function
table(((health$Total.Discharges < 42.78) | (health$Total.Discharges > 100)) & (health$Provider.City == "SACRAMENTO"))
table(health$Average.Covered.Charges > 100000)

# Just like before, which() gives us the row #s that match
which(((health$Total.Discharges < 42.78) | (health$Total.Discharges > 100)) & (health$Provider.City == "SACRAMENTO"))


####### Brief demo of using "&" ####
a = 1:5
b = 10:14

# The statements inside the "()" are made first, then "&"
# returns TRUE everywhere the value at position i in both a and b are TRUE
(a < 4) & (b > 11)

# "|" returns TRUE in the position if either a or b or both are TRUE
(a < 4) | (b > 11)

##### End in class section ####

# New functions
# subset()
# !=
# >= 
# <= 
# &
# |
