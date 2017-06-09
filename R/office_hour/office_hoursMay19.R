# Office hours
# 19 May 2017
# STS 198

polls = read.csv("~/Downloads/2016_preelection_polls.csv", stringsAsFactors = FALSE)
pollsters = read.csv("../../data/pollster-ratings.csv")

source("../funs/state2abb.R")

library(ggplot2)
polls$full_state = abb2state(polls$state)

ggplot(polls, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_point()+
    facet_wrap(~full_state) +
    geom_smooth()

state2abb(results$State)

aa = sort(unique(polls$end.date))[295:326]

dd = subset(polls, state %in% c("PA","WI","MI") & end.date %in% aa)

trump_summary = tapply(dd$trump, dd$state, mean)
clinton_summary = tapply(dd$clinton, dd$state, mean)

both_summary = tapply(dd[c("trump","clinton")], dd$state, mean)
clinton_summary = tapply(dd$clinton, dd$state, mean)

ggplot(data = NULL,
       aes(x = as.Date(end.date),
           y = trump))+
    geom_point(color = "red") +
    geom_point(aes(y = clinton), color = "blue") +
    facet_wrap(~state)


ggplot(data = NULL,
       aes(x = names(trump_summary),
           y = trump_summary))+
    geom_point(color = "red") +
    geom_point(aes(y = clinton_summary), color = "blue") 

dotchart(trump_summary, labels = names(trump_summary))
################################################################################
# pollster ratings

pollster = read.csv("../../data/2016_election/538pollster-ratings.csv", stringsAsFactors = FALSE)

pollster$main_grade = gsub("[+-]", "", pollster$X538.Grade)

ggplot(pollster, aes(x = main_grade,
                     y = Simple.Average.Error)) +
    geom_boxplot()

################################################################################


lapply(by_state, function(x) {
    max(x$trump)
})

co = subset(polls, state == "CO")
ca = subset(polls, state == "CA")

mean(co$trump)
median(co$trump)
nrow(co)

mean(co$trump)
median(ca$trump)
nrow(ca)

by_state = split(polls, polls$state)

# This is better than the above - less error prone, easier to read and write
# Taking advantage of subsetting a list by element names
lapply(by_state[c("CO","CA", "--")], function(x)
    c(mean(x$trump), median(x$trump), nrow(x)))

table(results$Margin_shift_pct < 0)

ggplot(dd,
       aes(x = as.Date(end.date),
           y = trump - clinton)) +
    geom_point() +
    geom_smooth() +
    facet_wrap(~state)

ggplot(results, aes(x = State, y = Trump_pct)) +
    geom_col(fill = "red") +
    geom_col(aes(y = Clinton_pct), fill = "blue")
