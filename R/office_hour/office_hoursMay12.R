polls = read.csv("~/Downloads/2016_preelection_polls.csv", stringsAsFactors = FALSE)
pollsters = read.csv("../../data/pollster-ratings.csv")
                                       
subset(pollsters, pollsters$'Simple.Average.Error' > 0.5)

subset(pollsters, pollsters$X538.Grade %in% 0.5)


# This does not work
pollsters$X538.Grade == c("A","A+","A-")
(pollsters$X538.Grade == "A" | pollsters$X538.Grade == "A+" | pollsters$X538.Grade == "A-")

onlyAs = subset(pollsters, pollsters$'X538 Grade' %in% c("A", "A+","A-") )

onlyAs$Simple.Average.Error

onlyBs = subset(pollsters, pollsters$X538.Grade %in% c("B", "B+","B-") )

onlyABs = list(onlyAs, onlyBs, "bob")

lapply(onlyABs, function(x) sum(x$Simple.Average.Error))


vars = colnames(polls)[c(7,10,11)] 
apply(polls[vars], 2, sum, na.rm = TRUE)

summary(pollsters$Simple.Average.Error)

by_grade = split(pollsters, pollsters$X538.Grade)

# Comment - remember that we can pull out the exact labels we are interested in
# This avoids errors caused by mistyping a label or copying and pasting
vars = names(by_grade)[4:9]

lapply(by_grade[vars], mean, na.rm = TRUE)

colnames(polls)

lapply(by_grade, function(x)
    c(sum(x$Trump), sum(x$Clinton)))

polls$end.date = as.Date(polls$end.date)
library(ggplot2)

ggplot(polls, aes(y = trump,
                  x = end.date,
                  color = population)) +
    geom_point() +
    geom_smooth()

str(polls)

seq(as.Date("2016-10-27"),as.Date("2016-11-08"), by = "1 day")

last_dates = sort(unique(polls$end.date))[296:326]

last_month = subset(polls, end.date %in% last_dates)

internet = subset(polls, population == "Internet")
sum(internet$trump)

ggplot(last_month, aes(x = end.date,
                       y = trump)) +
    geom_line(aes(color = "red"))+
    geom_line(aes(y = clinton,
                   color = "blue")) +
    facet_grid(~population)


sum((polls$trump/100) * polls$number.of.observations, na.rm = TRUE)

ggplot(polls, aes(x = end.date, y = trump, color = mode == "Internet")) +
    geom_line() +
    facet_wrap(~population)


ggplot(subset(last_month, population == "Likely Voters"),
       aes(y = (trump - clinton) > 0,
           x = end.date,
           color  = trump - clinton))+
    geom_point()

(polls$trump - polls$clinton) > 0

# average by state
tapply(polls$trump, polls$state, mean)
tapply(polls$clinton, polls$state, mean)

ggplot(polls, aes(x = state,
                  y = trump)) +
    geom_boxplot() +
    facet_wrap(~population)
