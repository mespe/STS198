load("../../data/sac_apts.Rda")

sacApts$price_new = as.numeric(gsub("\\$", "", sacApts$price))

library(ggplot2)

ggplot(sacApts, aes(x = price_new)) +
    geom_density()

ggplot(sacApts, aes(y = price_new, x = BR)) +
    geom_boxplot()

ggplot(sacApts, aes(x = price_new)) +
    geom_density() +
    xlim(0, 5000)

expensive = subset(sacApts, price_new > 5000)
not_expensive = subset(sacApts, price_new < 5000)
nrow(expensive)

expensive$title

table(grepl("rent", expensive$body))

cat(expensive$body[1])
cat(expensive$body[40])

table(grepl("/mo", expensive$body))
table(grepl("home|house", expensive$body))
table(grepl("apartments?", expensive$body))

has_apt = grepl("apartments?", expensive$body)

expensive$title[has_apt]
expensive[has_apt, c("BR","Ba","sqft")]


has_apt_data = subset(expensive, has_apt)

ggplot(has_apt_data, aes(x = price_new)) +
    geom_density()


table(has_apt_data$BR)
table(sacApts$BR == "1BR", is.na(price_new))

table(sacApts$BR == "8BR", sacApts$price_new > 10000)
table(sacApts$BR == "6BR", sacApts$price_new > 5000)

new_BR = as.integer(gsub("BR","", sacApts$BR))

table(nchar(sacApts$BR) > 4, is.na(new_BR))

subset(sacApts, nchar(sacApts$BR < 4 ))
sacApts$newBR = new_BR

ggplot(sacApts, aes(x = factor(newBR), y = price_new))+
    geom_boxplot()

ggplot(sacApts, aes(x = factor(newBR), y = price_new))+
    geom_boxplot() +
    ylim(0, 10000)

subset(sacApts, !price_new %in% c(1,3, 400))
subset(sacApts, price_new > 5 & price_new < 10000)

summary(sacApts$lat)
table(is.na(sacApts$lat), sacApts$newBR)

ggplot(sacApts, aes(x = factor(newBR),
                    fill = is.na(sacApts$lat))) +
    geom_bar()

over10k = sacApts$price_new >= 10000
under5 = sacApts$price_new < 5

table(over10k)
table(under5)
table(under5 | over10k)

# Price
my_subsets_criteria = !under5 | !over10k

# BR
my_subsets_criteria = my_subsets_criteria & !is.na(new_BR)

subset(sacApts, my_subsets_criteria)

ggplot(sacApts, aes(x = factor(newBR),
                    y = price_new, 
                    color = is.na(newBR))) +
    geom_boxplot() +
    ylim(0,10000)

library(ggmap)
dd = subset(sacApts, price_new < 10000)
qmplot(long, lat, data = dd, color = price_new,
       zoom = 7, alpha = I(0.2), size = I(0.1)) +
    xlim(-124, -120) +
    ylim(37, 40) +
    scale_color_gradient(low = "blue", high = "red") + 
    facet_wrap(~newBR, nrow = 2)
