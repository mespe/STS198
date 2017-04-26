# Fourth class - 
# STS 198
# 12 Apr 2017

# functions previously covered:
# ls()
# head()
# tail()
# length()
# unique()
# table()
# sort()
# summary()
# which()
# c()
# paste()
# "==" (logical comparison)
# "[" (subset)
# subset()
# !=
# >= 
# <= 
# &
# |


load(url("https://github.com/mespe/STS198/blob/master/data/health_costs.rda?raw=true"))

# Our task - an advocacy group has asked us to explore potential ways to reduce
# the costs in the Sacramento area for heart failure and shock procedures

# General suggestions about cost reductions for the Sacramento Area
# Where do we start? We need to ask some questions first?
# What are heart failure and shock procedures in the data? What variables are we interested in?
# We might need to subset to just Sacramento, but it also
# migth be important to compare to the nation overall. 
# Average.Total.Payments is variable of interest - this is the actual payments made by someone
# We might want the payments by only individuals, but this is not in the data
# Sometimes, we might need to ask for more information about what the stakeholder wants

##### Step 1: Subset to only the data of interest ########
length(unique(health$Provider.City))

sac_health = subset(health, Provider.City == "SACRAMENTO")
head(sac_health)

sort(unique(sac_health$DRG.Definition))

# Save the DRG.Definitions of interest as variables we can re-use
# allows tab-completion and will reduce errors compared to re-typing each long string
hFailure_mcc = "291 - HEART FAILURE & SHOCK W MCC"                                         
hFailure_cc = "292 - HEART FAILURE & SHOCK W CC"                                          
hFailure_wo = "293 - HEART FAILURE & SHOCK W/O CC/MCC"   

# Second subset
heart_sac = subset(sac_health, (DRG.Definition == hFailure_cc) | 
         (DRG.Definition == hFailure_mcc) | 
         (DRG.Definition == hFailure_wo))

# How can we check everything worked?
unique(heart_sac$Provider.City)
unique(heart_sac$DRG.Definition)


summary(heart_sac)

# We want to look at the variation in cost between providers
table(heart_sac$Average.Total.Payments)
table(heart_sac$Provider.Name)

subset(heart_sac, Provider.Name == "MERCY GENERAL HOSPITAL")

# It might have more impact to convey the numbers as the total savings
# If all patients went to a more affordable facility
(12119 - 6487) * 69

# It might not be appropriate to lump all MCC (multiple chronic conditions),
# CC (chronic conditions) and no MCC/CC together
sac_mcc = subset(heart_sac, DRG.Definition == hFailure_mcc)
which(sac_mcc$Average.Total.Payments == 20432.00)
which.max(sac_mcc$Average.Total.Payments)
heart_sac$Provider.Name[5]
which(sac_mcc$Average.Total.Payments == 9912.54)
sac_mcc$Provider.Name

summary(sac_mcc$Average.Total.Payments)
sac_mcc$Total.Discharges[5]
summary(sac_mcc)

# Again, the same information can be conveyed in different ways
# This should match the stakeholder
70 * (20430 - 12630)

### Compare to national #s
summary(health)
all_heart = subset(health, (DRG.Definition == hFailure_cc) | 
         (DRG.Definition == hFailure_mcc) | 
         (DRG.Definition == hFailure_wo))
summary(all_heart$Average.Total.Payments)
summary(heart_sac$Average.Total.Payments)

wo_sac = subset(all_heart, Provider.City != "SACRAMENTO")
summary(wo_sac$Average.Total.Payments)

###### Story-telling ####
# Is this a good story?
# Q: How to reduce health costs for ___?
# A: Reduce by X,Y,Z

# It lacks a human element - why do we care?
# There is no narrative in just listing solutions
# Ends up being dry and boring

# Think about the narrative and the audience
# 
# Impacts? Why does the group care? 
