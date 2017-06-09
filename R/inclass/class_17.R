# Class 17
# STS 198
#

load("../../data/sac_apts.Rda")       

# Picking up where we left off - remove the "$"
new_price = gsub("\\$", "", sacApts$price)
new_price = as.numeric(new_price)

# Create a new column
sacApts$new_price = new_price

# BR column as well
sacApts$BR = as.numeric(gsub("BR", "", sacApts$BR))

# Cleaning lat and long
# First, take a look
summary(sacApts$lat)

# Plotting is nice for spatial data
library(ggmap)

qmplot(long, lat, data = sacApts)

# But we can also treat it as numeric data
# it is clear there are some extreme values
quantile(sacApts$long, na.rm = TRUE)

# Are the missing values the same % across groups?
table(is.na(sacApts$long), sacApts$BR)

# Converting to %
lat_tbl = table(is.na(sacApts$lat), sacApts$BR)
# These two are the same
lat_tbl[2,] / colSums(lat_tbl)
lat_tbl[2,] / apply(lat_tbl, 2, sum)

# Q: Does it matter if you convert to integers?
BR_int = as.integer(sacApts$BR)
table(BR_int >= 2.0)

################################################################################
# factors: a new data type
# cut(): "bins" continuous data into categories
# allows you to compare groups of continuous data
#
# cut() takes a vector (numeric) and a series of breaks
# breaks can either be the the values where you want it the cuts to be made
# need one more than the # of categories
# or the number of categories you want

# Rather than do this...
under1k = subset(sacApts, price <= 1000)

# We can do this:
price_fact = cut(sacApts$new_price, breaks = c(0, 1000, 2000, 4000, 10000, 1e8))
price_fact = cut(sacApts$new_price, breaks = 10)

# The categories are called levels
levels(price_fact)
table(price_fact)

# Good default is to use the quantiles
# You will end up with groups of equal #
p2 = cut(sacApts$new_price, breaks = quantile(sacApts$new_price,
                                              probs = seq(0,1,0.1),
                                              na.rm = TRUE))
table(p2)

sacApts$p2 = p2

# This is helpful with plotting groups of categorical data
library(ggplot2)
ggplot(sacApts, aes(x = p2,
                    y = BR))+
    geom_boxplot()

# You can specify your own labels
price_fact = cut(sacApts$new_price, breaks = c(min(sacApts$new_price, na.rm = TRUE),
                                               1151, 2000,
                                               4000, 10000,
                                               max(sacApts$new_price, na.rm = TRUE)),
                 labels = c("0 - 1000", "1000-2000",
                            "2000-4000","4000-10000", "10000-max"))
table(price_fact, useNA = "ifany")

################################################################################
# Dates are where cut is really useful

posted = as.Date(sacApts$posted)

# cut can group dates by weeks
wkly = cut(posted, breaks = "weeks")
table(wkly)

sacApts$wkly = wkly

ggplot(sacApts, aes(x = wkly,
                    y = new_price)) +
    geom_boxplot() +
    ylim(0, 5000)

# Or months
monthly = cut(posted, breaks = "months",
              labels = letters[1:4])

levels(monthly) = c("Jan", "Feb", "Mar", "Apr")

levels(monthly)[1] = "Bob"

# The levels remain in a factor even if there are no corresponding values
# in the data - you have to drop the unused levels
onlyApr = subset(monthly, monthly == "Apr")
onlyApr = droplevels(onlyApr)

ggplot(data = NULL, aes(x = onlyApr)) +
    geom_bar()

