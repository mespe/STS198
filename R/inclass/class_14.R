# Class 14
# May 17
# STS198 - Spring 2017

# Load data
# Change these lines to the location where you downloaded the data sets
polls = read.csv("../../data/2016_election/2016_preelection_polls.csv")
results = read.csv("../../data/2016_election/2016_State_level_Presidential_results.csv")

################################################################################
# Common mistakes:

# Failure to think about the column contents:
head(polls)

# States not represeted equally
sort(table(polls$state), decreasing = TRUE)

range(as.Date(polls$end.date))

#

subset(polls, population %in% c("Likely Voters"                   Likely Voters - Democrat       
[3] Likely Voters - Republican      Likely Voters - independent    
[5] Registered Voters               Registered Voters - Democrat   
[7] Registered Voters - Republican  "Registered Voters - indepenent")

# This better
subset(polls, population %in% unique(polls$population)[1:8])

subset(polls, population != unique(polls$population)[9])

head(results)

subset(results, Swing == 1)


results[results$Swing == 1,]

# More advanced
trump = subset(results, Trump_pct > Clinton_pct)
clinton = subset(results, Trump_pct < Clinton_pct)

mean(trump$Margin_shift_pct)
median()
sum()

# Better
by_cand = split(results, results$Trump_pct > results$Clinton_pct)
names(by_cand) = c("clinton","trump")

lapply(by_cand, function(x) c(mean(x$Clinton..D.), median(x$Clinton..D.)))

# Cannot plot the above -
ans = sapply(by_cand, function(x) c(mean(x$Clinton_pct), median(x$Clinton_pct)))

by_swing = split(results, results$Swing == 1)

by_swing_state = split(by_swing[[1]], by_swing[[1]]$State)

# ggplot
library(ggplot2)
ggplot(results[order(results$Trump_pct),], aes(y = Trump_pct,
                    x = State)) +
geom_point() +
geom_point(aes(y = Clinton_pct), color = "blue")

