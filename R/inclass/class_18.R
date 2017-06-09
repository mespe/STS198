# Class 19
# STS 198 Spring 2017

library(ggplot2)

load("../../data/airline_delay2016.rds")

# Review of tappply
# tapply()
# refresher - tapply splits the column in the first argument
#     into groups based on the column in the second argument.
#     It then applies the function in the third argument to these
#     subsets of the data.
# 
# For every DEST - which ORIGIN most freq. delayed?

# First, start with just a single destination
sac = subset(airline, DEST == "SMF")

head(sac$ARR_DEL15)

ggplot(sac, aes(y = ARR_DEL15,
                x = ORIGIN)) +
    geom_bar(stat = "sum")

# how many flights total
nrow(airline)

tt = table(is.na(airline$ARR_DEL15))
sum(tt)

# How do we calculate what we are interested in on the whole dataset?
by_origin = tapply(sac$ARR_DEL15, sac$ORIGIN, function(x)
    sum(x, na.rm = TRUE)/sum(!is.na(x)))

temp = sort(tt, decreasing = TRUE)
temp[1]

# How many of each
table(sac$ARR_DEL15, useNA = "ifany")

# calculate by hand
517 / (2594 + 517)

sum(sac$ARR_DEL15, na.rm = TRUE) / sum(!is.na(sac$ARR_DEL15))

sort(tapply(sac$ARR_DEL15, sac$ORIGIN, mean, na.rm = TRUE), decreasing = TRUE)[1]

# For whole US
by_dest = split(airline, airline$DEST)
result = sapply(by_dest, function(x) {
    tmp = tapply(x$ARR_DEL15, x$ORIGIN, mean, na.rm = TRUE)
    names(sort(tmp, decreasing = TRUE))[1]
})

sort(table(result))

# How to know when to use certain functions/approaches
# Flights with DEP_time but NAs in ARR_DELAY
# is not NA in DEP_TIME, is NA in ARR_DELAY

# is.na()

table(!is.na(airline$DEP_TIME) & is.na(airline$ARR_DELAY))

my_subset = subset(airline, !is.na(DEP_TIME) & is.na(ARR_DELAY))

sort(table(my_subset$ORIGIN_STATE_ABR))                     

# Merging data
gini = read.csv("../../data/ACS_15_5YR_B19083_with_ann.csv",
                stringsAsFactors = FALSE, skip = 1)

election = read.csv("../../data/2016_election/2016_US_County_Level_Presidential_Results.csv",
                    stringsAsFactors = FALSE)

str(gini)
str(election)

ggplot(gini, aes(x = Estimate..Gini.Index)) +
    geom_density()

ggplot(data = NULL, aes(x = gini$Estimate..Gini.Index,
                        y = election$per_gop)) +
    geom_point()

table(sort(gini$Id2) %in% sort(election$combined_fips))

ans = merge(x = gini, y = election, by.x = "Id2", by.y = "combined_fips")

tail(gini)

################################################################################
# If we have time
library(rgdal)

counties = readOGR("../../data/", "gz_2010_us_050_00_5m")
