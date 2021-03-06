# Working with the polls to solve #4

polls = read.csv("../../data/2016_election/2016_preelection_polls.csv")

colnames(polls)

by_pop = split(polls, polls$population)

lapply(by_pop, nrow)

tmp = lapply(by_pop, "[", c("trump","number.of.observations"))
par(mfrow = c(3,4))
lapply(names(tmp), function(x) plot(trump ~ number.of.observations, data = tmp[[x]], main = x))
# Does the response rate correlate with the polls

var = levels(polls$end.date)[296:326]
last_month = subset(polls, end.date %in% var)

by_pop = split(last_month, last_month$population)

last_likely = by_pop[[2]]
library(ggplot2)

source("../funs/sort_factor.R")

ggplot(last_likely, aes(x = as.Date(end.date), y = trump)) +
    geom_jitter(aes(color = "red")) +
    geom_smooth(aes(color = "red")) +
    geom_jitter(aes(y = clinton, color = "blue")) +
    geom_smooth(aes(y = clinton, color = "blue")) +
    theme_bw()
    

ggplot(last_likely, aes(x = as.Date(end.date), y = trump)) +
    geom_jitter(color = "red") +
    geom_smooth(color = "red") +
    geom_jitter(aes(y = clinton), color = "blue") +
    geom_smooth(aes(y = clinton), color = "blue") +
    theme_bw() +
    facet_wrap(~sort_factor(state)) +
    ylim(c(35,65))
    
results = read.csv("../../data/2016_election/2016_State_level_Presidential_results.csv")

# We need to link the state abb with the state names

results$State %in% state.name

results$state = state2abb(results$State)

ggplot(last_likely, aes(x = as.Date(end.date), y = trump)) +
    geom_jitter(color = "red") +
    geom_smooth(color = "red") +
    geom_jitter(aes(y = clinton), color = "blue") +
    geom_smooth(aes(y = clinton), color = "blue") +
    theme_bw() +
    facet_wrap(~state) +
    ylim(c(35,65)) +
    geom_hline(data = results, aes(yintercept = Trump_pct), color = "red") +
    geom_hline(data = results, aes(yintercept = Clinton_pct), color = "blue")

