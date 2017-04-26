# Script to create plots used in class
# STS 198
# Apr 19th, 2017

# These are for demo only -
# some of the code here is not stuff we have covered

# Load the data - don't worry about these functions for now
load(url("https://github.com/mespe/STS198/blob/master/data/health_costs.rda?raw=true"))

library(ggplot2)

# Q: Is UCD Med much more expensive than other area hospitals?


sac = health[health$Provider.City == "SACRAMENTO",]

base_plot = ggplot(sac, aes(y = Average.Total.Payments,
                x = Provider.Name)) +
    geom_boxplot()
base_plot
new_theme = base_plot + theme_bw()
new_theme

new_theme + xlab("Provider") + ylab("Average Total Charges")

new_theme +
    theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0)) +
    xlab(NULL) +
    ylab("Average Total Charges (USD)")


# lets adjust these labels
sac$Provider.Name = factor(sac$Provider.Name)
levels(sac$Provider.Name) = c(
    "KAISER FOUNDATION - SO",
    "KAISER FOUNDATION ",
    "MERCY GENERAL",
    "METHODIST",
    "SUTTER GENERAL",
    "UDC MEDICAL CENTER")

new_theme +
    theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0),
          plot.margin = margin(2,70,2,2)) +
    xlab(NULL) +
    ylab("Average Total Charges (USD)")
ggsave("../plots/p1.pdf", width = 8, height = 6, units = "in")


################################################################################
# Switch up the data - see if they notice
# Just points
ggplot(sac, aes(y = Average.Total.Payments / Average.Medicare.Payments,
                x = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    geom_jitter(width = 0.1, alpha = 0.5) +
    xlab(NULL) +
    ylab("Ratio of total to medicare payments") 
ggsave("../plots/p2.pdf", width = 8, height = 6, units = "in")

# Violin plot
ggplot(sac, aes(y = Average.Total.Payments / Average.Medicare.Payments,
                x = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    geom_violin(fill = "grey70") +
    xlab(NULL) +
    ylab("Ratio of total to medicare payments") 
ggsave("../plots/p3.pdf", width = 8, height = 6, units = "in")

# Boxplot
ggplot(sac, aes(y = Average.Total.Payments / Average.Medicare.Payments,
                x = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    geom_boxplot(fill = "grey70") +
    xlab(NULL) +
    ylab("Ratio of total to medicare payments") 
ggsave("../plots/p4.pdf", width = 8, height = 6, units = "in")

# Not color-blind friendly
ggplot(sac, aes(y = Average.Total.Payments / Average.Medicare.Payments,
                x = Provider.Name,
                fill = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) +
    scale_fill_discrete(name = "Provider") + 
    geom_violin() +
    xlab(NULL) +
    ylab("Ratio of total to medicare payments") 
ggsave("../plots/p5.pdf", width = 8, height = 6, units = "in")

# Violin with color-blind friendly colors
ggplot(sac, aes(y = Average.Total.Payments / Average.Medicare.Payments,
                x = Provider.Name,
                fill = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    geom_violin() +
    xlab(NULL) +
    scale_fill_brewer(name = "Provider", palette = "Dark2") + 
    ylab("Ratio of total to medicare payments") 
ggsave("../plots/p6.pdf", width = 8, height = 6, units = "in")


################################################################################
# One more different way to look at the payments
ggplot(sac, aes(y = Average.Total.Payments - Average.Medicare.Payments,
                x = Provider.Name)) +  
    theme_bw() +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    geom_jitter(width = 0.1, alpha = 0.5) +
    xlab(NULL) +
    scale_fill_brewer(palette = "Dark2") + 
    ylab("Difference between medicare and total payments (USD)")
ggsave("../plots/p7.pdf", width = 8, height = 6, units = "in")

################################################################################
# Have not covered yet
top_discharges = sort(tapply(sac$Total.Discharges, sac$DRG.Definition, sum), decreasing=TRUE)[1:4]

# Dotchart - categories on x
ggplot(sac[sac$DRG.Definition %in% names(top_discharges),],
       aes(x = Provider.Name,
           y = Average.Total.Payments)) +
    geom_point() +
    theme_bw()+
    xlab(NULL) +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    
    facet_grid(~DRG.Definition) +
    ylab("Total payments (USD)")
ggsave("../plots/p8.pdf", width = 12, height = 6, units = "in")

# Flipped - categories on y
ggplot(sac[sac$DRG.Definition %in% names(top_discharges),],
       aes(x = Provider.Name,
           y = Average.Total.Payments)) +
    geom_point() +
    xlab(NULL) +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    
    facet_grid(~DRG.Definition) +
    theme_bw()+
    ylab("Total payments (USD)") +
    coord_flip()
ggsave("../plots/p9.pdf", width = 10, height = 6, units = "in")

# Include the discharges
ggplot(sac[sac$DRG.Definition %in% names(top_discharges),],
       aes(x = Provider.Name,
           y = Average.Total.Payments)) +
    geom_point(aes(size = Total.Discharges)) +
    xlab(NULL) +
    theme(axis.text.x = element_text(angle = -90, vjust = 0.5),
          plot.margin = margin(2,2,20,2)) + 
    
    facet_grid(~DRG.Definition) +
    theme_bw()+
    ylab("Total payments (USD)") +
    scale_size_continuous(name = "Total Discharges") + 
    coord_flip()
ggsave("../plots/p10.pdf", width = 10, height = 6, units = "in")

