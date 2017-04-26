# Learning ggplot2

library(ggplot2)
load("../data/health_costs.rda")
sac = subset(health, Provider.City == "SACRAMENTO")
ggplot(sac, aes(x = Total.Discharges, y = Average.Total.Payments)) +
    geom_point()

ggplot(sac, aes(x = Total.Discharges, y = Average.Total.Payments,
                shape = Provider.Name, color = Provider.Name)) +
    geom_point()

ggplot(sac, aes(x = Average.Medicare.Payments, y = Average.Total.Payments,
                color = Provider.Name)) +
    geom_point(aes(size = Total.Discharges))

ggplot(sac, aes(x = Total.Discharges, y = Average.Total.Payments,
                shape = Provider.Name, color = Provider.Name)) +
    geom_point()

ggplot(sac, aes(x = Provider.Name, y = Average.Total.Payments,
                shape = Provider.Name, color = Provider.Name)) +
    geom_violin()

ggplot(sac, aes(x = Provider.Name, y = Total.Discharges,
                shape = Provider.Name, color = Provider.Name)) +
    geom_violin()

ggplot(sac, aes(x = Average.Covered.Charges, y = Average.Total.Payments,
                shape = Provider.Name, color = Provider.Name)) +
    geom_point() +
    geom_smooth()

ggplot(sac, aes(x = Average.Total.Payments,
                fill = Provider.Name)) +
    geom_density(alpha = 0.2)

ggplot(sac, aes(x = Average.Total.Payments)) +
    geom_histogram() +
    theme_bw() +
    xlab("Average Total Payments (USD)") +
    ylab("Count")


#### class ####
idx = grep("HEART", health$DRG.Definition)
heart = health[idx,]

ggplot(heart, aes(x = Average.Total.Payments, fill = Provider.City == "SACRAMENTO")) +
    geom_density(alpha = 0.2)
