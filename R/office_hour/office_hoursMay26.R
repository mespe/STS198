# STS 198
# Office hours
# 26 May

load("../../data/sac_apts.Rda")
table(nchar(sacApts$price))["0"]

new_price = gsub("\\$", "", sacApts$price)
new_price = as.numeric(new_price)
table(is.na(new_price))

table(sacApts$price[is.na(new_price)])
subset(sacApts$price, is.na(new_price))

plot(table(nchar(sacApts$BR)))
head(sort(unique(sacApts$BR)))
table(sacApts$BR)

newBR = gsub("BR", "", sacApts$BR)
newBR = as.numeric(newBR)
table(is.na(newBR))

# WE created 760 NAs
table(nchar(sacApts$BR) > 4, is.na(newBR))

subset(sacApts$BR, nchar(sacApts$BR) < 4 & is.na(newBR))
which(nchar(sacApts$BR) < 4 & is.na(newBR))

sacApts[1622,]

table(newBR)
