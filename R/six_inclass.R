# More plotting -
# STS 198
# Apr 19, 2017

library(ggplot2)

base_plot = ggplot(sac,
                   aes(y = Average.Total.Payments,
                       x = Provider.Name)) +
    geom_boxplot()

base_plot +
    xlab("Provider of medical treatment (Sacramento, CA area)") +
    ylab("Average total payment for treatment (USD)") +
    theme_bw()

base_plot +
    xlab("Provider of medical treatment (Sacramento, CA area)") +
    ylab("Average total payment for treatment (USD)") +
    theme_minimal()

ggplot(sac,
       aes(y = Average.Total.Payments,
           x = Provider.Name)) +
    geom_violin() +
    theme_bw()

ggplot(sac,
       aes(y = Average.Total.Payments,
           x = Provider.Name)) +
    geom_violin() +
    geom_jitter(width = 0.1) + 
    theme_bw()

ggplot(sac,
       aes(y = Average.Total.Payments,
           x = Provider.Name)) +
    # geom_violin() +
    geom_point(alpha = 0.5, size = 20) + 
    theme_bw()
