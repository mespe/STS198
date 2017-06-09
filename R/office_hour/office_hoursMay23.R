# Office hours
# 23 May 2017
# STS 198
# Spring 2017

# Load data
# Change these lines to the location where you downloaded the data sets
polls = read.csv("../../data/2016_election/2016_preelection_polls.csv", stringsAsFactor = FALSE)
results = read.csv("../../data/2016_election/2016_State_level_Presidential_results.csv")

# Goal: Count the number of polls that predicted wins for each candidate in each state
ca = subset(polls, state == "CA")
table(sign(ca$trump - ca$clinton))

by_state = split(polls, polls$state)

ans = lapply(by_state, function(x) table(sign(x$trump - x$clinton)))

# Same answer - different method
poll_diff = factor(sign(polls$trump - polls$clinton))
levels(poll_diff) = c("Clinton", "Tie", "Trump")

head(polls$trump - polls$clinton)
head(sign(polls$trump - polls$clinton))
ans = do.call(rbind, tapply(poll_diff, polls$state, table))

# Third way to do this:
polls$pollster = factor(polls$pollster)
by_winner = split(polls, poll_diff)
sapply(by_winner, nrow)
ans = lapply(by_winner, function(x) table(x$pollster))
ans = t(do.call(rbind, ans))

#
clinton = subset(polls, (clinton - trump) > 0)
nrow(clinton)
nrow(by_winner[["Clinton"]])
nrow(by_winner[[1]])
sapply(by_winner, nrow)


mylist = list(a = 1:10, b = letters, c = "bob", d = list(name = "anna"))

mylist["a"]
str(mylist["a"])

mylist[["a"]]
str(mylist[["a"]])

mylist[["d"]][["name"]]

# With split()
by_states = split(polls, polls$state)
class(by_states)

states_Im_intersted_in = c("PA","WI","MI")

by_state[states_Im_intersted_in]
class(by_state[["PA"]])
colnames(by_state[["PA"]])
colnames(polls)

by_state[["PA"]][1:10, 1:3]

upperMidWest_list = by_state[states_Im_intersted_in]

w_lapply = lapply(upperMidWest_list, nrow)
w_sapply = sapply(upperMidWest_list, nrow)
lapply(upperMidWest_list, ncol)

lapply(upperMidWest_list, function(bob) summary(bob$clinton - bob$trump))

# What did this do?
# summary(upperMidWest_list[["PA"]]$clinton - upperMidWest_list[["PA"]]$trump)
# summary(upperMidWest_list[["WI"]]$clinton - upperMidWest_list[["WI"]]$trump)
# summary(upperMidWest_list[["MI"]]$clinton - upperMidWest_list[["MI"]]$trump)


myfun = function(bob)
{
    # browser()
    summary(bob$clinton - bob$trump)
}

# myfun(upperMidWest[["PA"]]) First thing function does: assigns the data to the name "bob" # bob = upperMidWest[["PA"]]
# "bob" only exists inside the function - when the function completes, "bob" is destroyed
sum(bob)

lapply(upperMidWest_list, myfun)

A = matrix(1:10, nrow = 5)
B = array(1:10, dim = c(2,5, 3))
