# Exploring the distracted data set
# M. Espe
# Apr 25, 2017

library(ggplot2)

ggplot(distracted, aes(x = STATE)) +
    geom_point(stat = "count") +
    coord_flip()

################################################################################
# Issue - barplots are evil (not just not great)

dist_tbl = as.data.frame(sort(table(distracted$STATE), decreasing = FALSE))

distracted$ST_new = factor(distracted$STATE,
                           levels = dist_tbl$Var1)

ggplot(distracted, aes(x = sort_factor(STATE))) +
    geom_point(stat = "count") +
    coord_flip()

ggplot(distracted, aes(x = sort_factor(MDRDSTRD))) +
    geom_point(stat = "count") +
    coord_flip()
                   
dd = subset(distracted, !MDRDSTRD %in% c("Unknown if Distracted",
                                      "Not Distracted",
                                      "Not Reported"))

ggplot(dd, aes(x = sort_factor(MDRDSTRD))) +
    geom_point(stat = "count") +
    coord_flip()

ggplot(dd, aes(x = sort_factor(STATE))) +
    geom_point(stat = "count") +
    coord_flip()


################################################################################
# Make a quick map
library(maps)
usa = map_data("state")

tt = as.data.frame(table(distracted$STATE))
ggplot(tt, aes(map_id = tolower(Var1))) +
    geom_map(aes(fill = Freq), map = usa)+
    expand_limits(x = usa$long, y = usa$lat) +
    theme_bw() +
    coord_map()

tt = as.data.frame(table(dd$STATE))
ggplot(tt, aes(map_id = tolower(Var1))) +
    geom_map(aes(fill = Freq), map = usa)+
    expand_limits(x = usa$long, y = usa$lat) +
    theme_bw() +
    coord_map()

str(usa)

load("~/Downloads/us_state_populations.rda")

states10 = subset(us_state_populations, year == 2010)

tt = table(dd$STATE)
tt = (tt[states10$state]/states10$population) * 1e5


states10$state %in% names(tt)
tt = as.data.frame(tt)
ggplot(tt, aes(map_id = tolower(Var1))) +
    geom_map(aes(fill = Freq), map = usa)+
    expand_limits(x = usa$long, y = usa$lat) +
    theme_bw() +
    coord_map()
