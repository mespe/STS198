# Run through for 3rd day
# M. Espe
# STS 198

source("second_class.R")

sac_health <- subset(health, Provider.City == "SACRAMENTO")

head(sac_health)
table(sac_health$Provider.Name)
summary(sac_health)

summary(health)


sac_defs = table(sac_health$DRG.Definition)

length(sac_defs)

variable = "189 - PULMONARY EDEMA & RESPIRATORY FAILURE"

sac_pul = subset(sac_health, DRG.Definition == variable)

summary(sac_pul)

all_pul = subset(health, DRG.Definition == variable)
summary(all_pul)
