# Office hours June 6
#

load("../../data/airline_delay2016.rds")

# freq of carriers late
# which carriers are most freq late
#

sw = subset(airline, CARRIER == "WN")

table(sw$ARR_DEL15, useNA = "ifany") / nrow(sw)

by_carrier = split(airline, airline$CARRIER)

ans = sapply(by_carrier, function(x)
    table(x$ARR_DEL15, useNA = "ifany") / nrow(x)
    )

ans2 = tapply(airline$ARR_DEL15, airline$CARRIER, function(x)
    table(x, useNA = "ifany") / length(x)
    )

# Want to see the string/text that contains the pattern
grep("Sacramento", airline$ORIGIN_CITY_NAME, value = TRUE)

# Mean arr delay

by_day = split(airline, airline$DAY_OF_WEEK)

# sapply(by_day, function(x) table(x$ARR_DELAY_NEW, useNA = "ifany"))
sapply(by_day, function(x) mean(x$ARR_DELAY_NEW, na.rm = TRUE))
sapply(by_day, function(x) median(x$ARR_DELAY_NEW, na.rm = TRUE))

library(ggplot2)

ggplot(airline, aes(x = ARR_DELAY_NEW,
                    fill = factor(DAY_OF_WEEK))) +
    geom_density(alpha = 0.2) +
    xlim(0,15)

ggplot(airline, aes(y = ARR_DELAY_NEW,
                    x = DAY_OF_WEEK, 
                    fill = factor(DAY_OF_WEEK))) +
    geom_violin(alpha = 0.2) +
    ylim(0,5)

ggplot(subset(airline, ARR_DEL15 == 1),
       aes(y = ARR_DELAY_NEW,
           x = DAY_OF_WEEK, 
           fill = factor(DAY_OF_WEEK))) +
    geom_violin(alpha = 0.2) +
    ylim(0,50)

head(cbind(airline$ARR_DELAY, airline$ARR_DELAY_NEW))

table(airline$ARR_DELAY <= 0, airline$ARR_DELAY_NEW == 0)

tmp = subset(airline, airline$ARR_DELAY > 0 & airline$ARR_DELAY_NEW != 0)

ggplot(airline, aes(x = factor(ARR_DELAY))) +
                geom_bar()

table(airline$ARR_DEL15)/nrow(airline)
table(airline$ARR_DELAY < 5)/nrow(airline)

ggplot(airline, aes(x = factor(DAY_OF_WEEK,
                               labels = c("Sun","Mon","Tue","Wed","Thu","Fri","Sat")),
                     y = ARR_DELAY_NEW)) +
    geom_violin() +
    ylim(0,5) + 
    facet_grid(~DEST=="SMF")

ggplot(airline, aes(x = factor(DAY_OF_WEEK,
                               labels = c("Sun","Mon","Tue","Wed","Thu","Fri","Sat")),
                     y = ARR_DELAY_NEW)) +
    geom_violin() +
    ylim(0,5)

ggplot(airline, aes(x = factor(DAY_OF_WEEK),
                     y = ARR_DELAY_NEW)) +
    geom_violin() +
    ylim(0,5) +
    scale_x_discrete(breaks = 1:7,
                     labels = c("Sun","Mon","Tue",
                                "Wed","Thu","Fri","Sat"))


airline$ARR_DEL15 = factor(airline$ARR_DEL15)
by_dest = split(airline, airline$DEST)

ans = sapply(by_dest, function(x)
    table(x$ARR_DEL15)/nrow(x))

# table(sapply(ans, length))

sort(ans[2,])

sort(sapply(by_carrier, function(x) mean(x$ARR_DELAY_NEW, na.rm = TRUE)))

# Which

ggplot(airline, aes(x = CARRIER,
                    y = ARR_DEL15,
                    group = ARR_DEL15)) +
    geom_col()

ans = sapply(by_carrier, function(x)
    table(x$ARR_DELAY >= 30)/nrow(x))


ggplot(data = NULL, aes(x = colnames(ans),
                        y = ans[2,])) +
    geom_point()

# What are the issues:
# We want %, not 0.XX
# points could be ordered

ans_percents = ans * 100

idx = order(ans_percents[2,], decreasing = TRUE)

ans_percents[,idx]

ggplot(data = NULL, aes(x = factor(colnames(ans), levels = colnames(ans)[idx]),
                        y = ans_percents[2,idx])) +
    geom_point()
