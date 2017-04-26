# Office hours - Apr 25th
# STS 198
# Spring 2017

library(ggplot2)
load("../data/CA_arrivals2016.rda")

ggplot(CAarrivals, aes(x = YEAR,
                       y = DEP_DELAY)) +
    geom_point()

sac = subset(CAarrivals, DEST == "SMF")

arr_delay = tapply(sac$ARR_DEL15, sac$UNIQUE_CARRIER, function(x)
    sum(x, na.rm = TRUE)/sum(!is.na(x)))

str(arr_delay)

aa = as.data.frame(arr_delay)

ggplot(aa, aes(x = rownames(aa),
               y = arr_delay)) +
    geom_point(size = 20)

carrier_dow = as.data.frame(table(sac$UNIQUE_CARRIER, sac$DAY_OF_WEEK),
                            stringsAsFactors = FALSE)

# Does not work
# ggplot(sac, aes(x = DAY_OF_WEEK,
#                 y 
#                 fill = UNIQUE_CARRIER)) +
#     geom_point()

ggplot(carrier_dow[carrier_dow$Var2 == "1",], aes(x = Var1,
                        y = Freq)) +
    geom_point(size = 10) +
    geom_point(aes(x = "WN", y = 263), size = 50, color = "red")

my_sub = subset(sac, UNIQUE_CARRIER %in% c("OO","B6"))

ggplot(my_sub, aes(x = UNIQUE_CARRIER,
                   y = ARR_DELAY,
                   fill = UNIQUE_CARRIER)) +
    geom_boxplot() +
    xlab("my label") +
    scale_fill_discrete(labels = c("Bob", "Anna")) +
    geom_jitter(aes(color = ARR_DELAY > 60), size = 10, alpha = 0.5)

ggplot(sac, aes(x = UNIQUE_CARRIER == "WN",
                y = ARR_DELAY,
                color = ARR_DELAY > 15)) +
    geom_jitter(size = 10)

ggplot(sac, aes(x = ARR_DELAY,
                y = DEP_DELAY,
                color = CARRIER)) +
    geom_point(size = 10) +
    geom_smooth(se = FALSE) +
    facet_grid(~ CARRIER)

sac$DEP_DELAY_GROUP = factor(sac$DEP_DELAY_GROUP)

levels(sac$DEP_DELAY_GROUP) = reorder(levels(sac$DEP_DELAY_GROUP), 15:1)


ggplot(sac, aes(x = factor(DEP_DELAY_GROUP))) +
    geom_bar() +
    scale_x_discrete(labels = c("-30-15", "-15-0", "0-15", "15-30", # etc
                                "2" , "3" , "4",
                                "5", "6", "7", "8",  "9",
                                "10", "11", "12")) +
    coord_flip() 



##0000-0759
# 0-15, min
ggplot(my_sub, aes(x = UNIQUE_CARRIER,
                   y = ARR_DELAY,
                   fill = UNIQUE_CARRIER)) +
    geom_boxplot() +
    xlab("my label") +
    scale_fill_discrete(labels = c("Bob", "Anna")) +
    geom_jitter(aes(color = ARR_DELAY > 60), size = 10, alpha = 0.5)

    
    
ggplot(sac, aes(x = CARRIER)) +
    geom_bar() +
    theme_bw()

ggsave("../plots/unsorted.png")    

ggplot(sac, aes(x = sort_factor(CARRIER))) +
    geom_bar(aes(fill = CARRIER == "WN")) +
    scale_fill_manual(values = c("grey", "red"))+
    theme_bw() +
    theme(legend.position = "none")
ggsave("../plots/increasing.png")    

ggplot(sac, aes(x = sort_factor(factor(DAY_OF_WEEK), decreasing = TRUE))) +
    geom_bar() +
    theme_bw()
ggsave("../plots/decreasing.png")    

