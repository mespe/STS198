# Need to figure out a 'easy' question
# M. Espe
# Apr 2017

source("second_class.R")

sac = health$Provider.City == "SACRAMENTO"

dd = split(health[sac,], health[sac, "DRG.Definition"])

lapply(dd, function(x) 
    x[order(x$Average.Total.Payments),])
head(sort(sapply(dd, function(x) sum(x$Total.Discharges)), decreasing = TRUE))

heart = grepl("HEART", health[,"DRG.Definition"])

heart_cost = health[sac & heart,]

tapply(heart_cost$Total.Discharges, heart_cost$Provider.Name, sum)
tapply(heart_cost$Average.Total.Payments, heart_cost$Provider.Name, mean)
tapply(heart_cost$Total.Discharges, heart_cost$DRG.Definition, sum)


###### How to do it in class #######

sort(unique(health$DRG.Definition))

hFail_wo = "293 - HEART FAILURE & SHOCK W/O CC/MCC"
hFail_cc = "292 - HEART FAILURE & SHOCK W CC"
hFail_mcc = "291 - HEART FAILURE & SHOCK W MCC"

sac_health = subset(health, Provider.City == "SACRAMENTO")
unique(sac_health$Provider.City)

sac_wo = subset(sac_health, DRG.Definition == hFail_wo)
sac_cc = subset(sac_health, DRG.Definition == hFail_cc)
sac_mcc = subset(sac_health, DRG.Definition == hFail_mcc)

sac_wo
sac_cc
sac_mcc

### Looking at W/O
all_wo = subset(health, DRG.Definition == hFail_wo)
summary(all_wo$Average.Total.Payments)
summary(sac_wo$Average.Total.Payments)

sum(sac_wo$Total.Discharges) * (6272 - 5002)
