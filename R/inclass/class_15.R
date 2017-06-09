# Class 15
# STS 198
# 22 May 2017

library(ggplot2)

################################################################################
# Cleaning data
load(url("https://github.com/mespe/STS198/blob/master/data/auto_posts.rda?raw=true"))
# load("../../data/auto_posts.rda")

# Starting with price column:
head(posts$price)

# The price inculdes "$", which is going to cause issues
# if we just use as.numeric()

# We can use gsub() to get rid of the "$"
# gsub stands for global subsitution

# This does not work - "$" is a special character
price_new = gsub("$", "", posts$price)

# To search/replace for special chars $^.*+?[()]\
price_new = gsub("\\$", "", posts$price)

# Have to escape these using a double "\"
gsub(pattern = "\\\ \\$", replacement = "BOB", x = "\ $")

# This introduces NAs - We need to check those out
price_new = as.numeric(price_new)

# Turns out there are some long strings in the price column
# These are not going to convert well
long_price = nchar(posts$price) > 8
table(long_price)
posts$price[long_price]

# Looks like we are OK replacing the long ones with NAs
# Here is a test:
x = c("$353", "353", "2011 MAZDA")
as.numeric(x)

# Lets look at the results
table(price_new, useNA = "ifany")

# Now save the price as the price column
posts$price = price_new

# Plotting is helpful to check out extreme values
ggplot(posts, aes(y = price,
                  x = condition)) +
    geom_boxplot() +
    ylim(c(0,100000)) + 
    facet_wrap(~maker)

# We can also subset to look at the values 
subset(posts, posts$maker == "maserati")
subset(posts, posts$price > 1e6)

summary(posts$price)
################################################################################

# Using lapply/sapply to go over multiple columns at once
# This would be helpful if there were more than one columns with "$"
tmp = sapply(posts[,c("price", "maker")], function(x) gsub("\\$","",x))

################################################################################
#  Subsetting with the [] in 2 dimensions
# data[rows,cols]
# First row
posts[1,]
# First column
posts[,1]

# Value in first row, first column
posts[1,1]

# Can subset by name
posts["posted3625",]
posts[,"price"]

# cat() converts the \n to a newline
# Making the body easier to read
cat(posts$body[1])
