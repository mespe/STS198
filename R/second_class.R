# Playing around with the healthcare data
# prior to the second class
# M. Espe
# Apr 2017

##list.files("../data")

health <- read.csv("../data/healthcosts.csv", stringsAsFactors = FALSE)
str(health)

convCost <- function(x)
{
    as.numeric(gsub("[$]", "", x))
}

i <- grep("^Average", colnames(health))

health[,i] <- apply(health[,i], 2, convCost)

summary(health)

str(health)

# How many of each do we have?
unique(health$Provider.State)
unique(health$Provider.City)
unique(health$Provider.Zip.Code)
unique(health$DRG.Definition)
unique(health$Provider.Id)
tblID <- table(health$Provider.Id)
sort(table(health$Provider.State), decreasing = TRUE)

plot(table(health$Total.Discharges))


## Things to cover on Wed:
# str, summary, nrow, ncol
# data types
# already know unique, length, but re-enforce
# table?
# sort

