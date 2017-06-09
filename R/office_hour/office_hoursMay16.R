# Office hours
# May 16, 2017
#

# Load data
# Change these lines to the location where you downloaded the data sets
polls = read.csv("../../data/2016_election/2016_preelection_polls.csv")
results = read.csv("../../data/2016_election/2016_State_level_Presidential_results.csv")

# source functions - 
source("../funs/mapUSA.R")
source("../funs/state2abb.R")

#

head(last_month)

table(last_month$partisan)

sort(table(last_month$state))

swing = results$State[abs(results$Trump_pct - results$Clinton_pct) < 5]
swing_poll = subset(last_month, state %in% state2abb(swing))
sort(table(as.character(swing_poll$state)))

# Important to add the abbreviations to the results data set
results$state = state2abb(results$State)

ggplot(swing_poll, aes(x = as.Date(end.date),
                       y = trump)) +
    geom_point(color = "red", size = 0.5) +
    geom_smooth(se = TRUE, color = "red") + 
    geom_point(aes(y = clinton), color = "blue", size = 0.5) +
    geom_smooth(aes(y = clinton), se = FALSE, color = "blue") +
    geom_point(data = subset(results, State %in% swing & !is.na(state)),
               aes(y = Trump_pct,
                   x = as.Date("2016-11-08")), color = "red", size = 3) + 
    geom_point(data = subset(results, State %in% swing & !is.na(state)),
               aes(y = Clinton_pct,
                   x = as.Date("2016-11-08")), color = "blue", size = 3, alpha = 0.5) + 
    facet_wrap(~state) +
    theme_bw()

################################################################################
# From office hours
# mapping
plotMap(data = last_month$trump, state = last_month$state)

plotMap(data = abs(results$Trump_pct - results$Clinton_pct),
        state = results$State) +
    scale_fill_gradient(low = "purple", high = "white")


plotMap(data = abs(results$Trump_pct - results$Clinton_pct) < 5, 
        state = results$State)


plotMap(data = results$Dem_12_margin_pct, 
        state = results$State)


plotMap(data = results$vs_12_pct, 
        state = results$State) +
    scale_fill_gradient(low = "white", high = "blue")

################################################################################
# Plotting data not in a variable
x = 1:5
y = letters[x]

ggplot(data = NULL,
       aes(x, y)) +
    geom_point()
