# STS 198 Office hours
# June 9th

polls = read.csv("../../data/2016_election/2016_preelection_polls.csv",
                 stringsAsFactors = FALSE)

library(ggplot2)

ggplot(polls, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_point()

ggplot(polls, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_point() +
    facet_grid(~population)

ggplot(polls, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_point() +
    facet_grid(population~.)

likely = subset(polls, population == "Likely Voters")

ggplot(likely, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_point()


ggplot(likely, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_jitter()


ggplot(likely, aes(x = as.Date(end.date),
                  y = trump)) +
    geom_jitter(alpha = 0.25)


ggplot(likely, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25)


ggplot(likely, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0)


ggplot(likely, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    theme_bw()

ggplot(likely, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    theme_bw() +
    facet_wrap(~state)

last_mo = sort(unique(likely$end.date))[200:234]
likely_oct = subset(likely, end.date %in% last_mo)

ggplot(likely_oct, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    theme_bw() +
    facet_wrap(~state)

unique(likely_oct$state)

swing_oct = subset(likely_oct, state %in% c("FL","MI","PA"))

ggplot(swing_oct, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    theme_bw() +
    facet_wrap(~state)

ggplot(swing_oct, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    geom_smooth() +
    theme_bw() +
    facet_wrap(~state)


ggplot(swing_oct, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    geom_smooth(color = "black") +
    theme_bw() +
    facet_wrap(~state)

ggplot(swing_oct, aes(x = as.Date(end.date),
                  y = trump - clinton)) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    geom_smooth(color = "black") +
    theme_bw() +
    facet_wrap(~state) +
    labs(x = "Date", y = "Margin (Trump - Clinton)")

ggplot(swing_oct, aes(x = as.Date(end.date),
                      y = trump - clinton,
                      color = (trump - clinton) < 0 )) +
    geom_jitter(alpha = 0.25) +
    geom_hline(yintercept=0) +
    scale_color_discrete(name = "Outcome",
                        labels = c("Trump","Clinton")) +
    geom_smooth(color = "black") +
    theme_bw() +
    facet_wrap(~state) +
    labs(x = "Date", y = "Margin (Trump - Clinton)") 

# Create empty column
polls$new_state = NA
# find the ones that have "CA"
i = grepl("CA", polls$state)

polls$new_state[i] = "California"

