## Script from office hours - Apr 20th
# STS198
# Spring 2017

library(ggplot2)

load("../data/CA_arrivals2016.rda")
sac = subset(CAarrivals, DEST == "SMF")
ggplot(sac, aes(x = factor(ARR_DELAY_GROUP),
                fill = factor(ARR_DELAY_GROUP))) +
    geom_bar()


ggplot(sac, aes(x = ARR_DELAY)) +
    geom_density()

ggplot(sac, aes(x = ARR_DELAY,
                color = ARR_DELAY >= 15)) +
    geom_density()

#####################################
my_tbl = table(CAarrivals$ARR_DELAY_GROUP)

ggplot(as.data.frame(my_tbl),
       aes(x = Var1,
           y = Freq/54971)) +
    geom_point()

########################################
my_df = as.data.frame(my_tbl)

# tt = table(CAarrivals$UNIQUE_CARRIER)
# my_df = as.data.frame(table(CAarrivals$UNIQUE_CARRIER))

# my_data_week = sac$DAY_OF_WEEK

# ggplot(data, aes(x = factor(DAY_OF_WEEK),
#                  y = ....)



ggplot(my_df,
       aes(x = Var1,
           y = Freq / sum(Freq))) +
    geom_point() +
    geom_line(aes(x = as.numeric(Var1))) +
    geom_hline(yintercept=0.15,
               linetype = "dashed",
               color = "red")

ggplot(sac, aes(x = CARRIER,
                y = ARR_DELAY,
                fill = CARRIER)) +
    geom_boxplot() +
    scale_fill_hue(labels=c("HA", "DL", "Southwest", "UA", "WN", "American", "AS", "B6")) +
    xlab("Carrier") +
    ylab("Arrival delay (min)") +
    ggtitle("My title", subtitle = "my subtitle") +
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5))
ggsave("../plots/example.png")


tmp = c("HA", "DL", "OO", "UA",
        "WN", "AA", "AS", "B6")
