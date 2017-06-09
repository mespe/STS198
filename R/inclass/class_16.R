# Class 16
# STS 198
# May 24th

# Load data
load(url("https://github.com/mespe/STS198/blob/master/data/auto_posts.rda?raw=true"))
# load("../../data/auto_posts.rda")       

# Picking up where we left off - remove the "$"
new_price = gsub("\\$", "", posts$price)
new_price = as.numeric(new_price)

# Create a new column
posts$new_price = new_price

# Plotting is really helpful to look at the range of values and find strange values
library(ggplot2)
# We can see that there are some really large values -
# this makes it really difficult to see what is going on with the rest of the data
ggplot(posts, aes(y = new_price,
                  x = factor(year))) +
    geom_boxplot() 

# Rather than subset, we can just adjust the axes
# so that the extreme values are not shown
ggplot(posts, aes(y = new_price,
                  x = factor(year))) +
    geom_boxplot() +
    ylim(0,1e5)

# NA revisited:
# We determined last time that any places there were long character strings
# in the price would be converted to NA
head(posts$price[nchar(posts$price) > 8])

# table() is really helpful for quickly looking at NA values
# in combination with is.na
table(is.na(posts$new_price))

# Why do we need is.na?
# Remember that R treats NA values as unknowns
# If you use == NA, you asking R to compare something that is unknown
# which is unknown itself
table(posts$new_price == NA, useNA = "ifany") # useNA
na.rm(posts$new_price)
# Does not work - na.rm is not a function, it is an arg to mean, sum, etc.

# Why are NAs problematic?
# If we just exclude them without determining how they came to be
# we might bias the data
# How do we investigate how they are missing?

# Two way tables are nice for this - you can see how many NAs
# there are according to different categories
tt = table(is.na(posts$new_price), posts$fuel)

# What if we want to convert these to % of each category?
tt[2,] / apply(tt, 2, sum)

# the "other" category looks like it has higher % NA
# We can subset these out
others = subset(posts, fuel == "other" & is.na(new_price))

# Something fishy is happening with Nissans
table(others$maker)

# Create another subset
nis = subset(others, maker == "nissan")

# We are down to few enough values that we can just look at
# the data directly
nis$header

# The cat function allows us to look at the text in a more
# convienent format
# Let's look at a few
cat(nis$body[1])
cat(nis$body[2])
cat(nis$body[3])

# These all were posted by "dealermarketingsolutions.net"
# grepl() is a function that does pattern matching inside a
# character string and returns a logical TRUE if the pattern was found
grepl("dealermarketingsolutions.net", nis$body)

# Every one of our strange posts were posted by the same dealer
# Let's look at the full dataset to see if there are issues there
dealer_mk = grepl("dealermarketingsolutions.net", posts$body)

# These were also all for the same dealership - let's look to see if
# this dealer might also have other posts
future_nis = grepl("Future Nissan of Roseville", posts$body)

# The two way table reveals that there are not many dealermartketingsolutions.net posts
# but all the "future nissan" posts were posted by dealermarketingsolutions
table(dealer_mk, future_nis)

################################################################################
# Different way to make the table above a %
tots = table(posts$fuel)
tt[2,]/ tots
################################################################################
# With spatial data, it is helpful to map it to look for patterns.
# The ggmap package is a convienent way to create quick maps
# because it downloads additional data automatically
library(ggmap)

table(is.na(posts$lat))

# This is helpful - we can see the posts along with the states and major cities
qmplot(long, lat, data = posts, color = I("red"))

# With a simple plot, it is more difficult to see what is going on
# The pattern is still there, but we don't know any geographic landmarks
ggplot(posts, aes(y = lat,
                  x = long)) +
    geom_point()

# Let's investigate the point in DC
which.max(posts$long)
posts[which.max(posts$long), 1:3] # just look at the first 3 columns using the "["

# We can subset to only the cars that are approximately in CA
ca = subset(posts, long < -115 & lat < 40 & lat > 36)

# Now that we are zoomed in more, we can more easily see what is going on
# Overall, there do not seem to be obvious places where points are missing
qmplot(long, lat, data = ca, color = I("red")) 

# qmplot works with facet_wrap, which allows you to investigate
# various aspects of the data
qmplot(long, lat, data = ca, color = new_price) +
    facet_wrap(~fuel)

################################################################################
# Repeated values
# table is also very helpful here -
# by sorting the table, we can see which values are occuring most often
sort(table(new_price), decreasing = TRUE)[1:10]

# For price, it is expected to have repeats, for other columns it would be
# unexpected to have the same exact thing
# for example, the header:
sort(table(posts$header), decreasing = TRUE)[1:10]
# It seems likely that these could be duplicate postings

# It would be even rarer that the title would be the exact same
sort(table(posts$title), decreasing = TRUE)[1:10]
