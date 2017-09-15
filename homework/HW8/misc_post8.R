load("../../data/airline_delay2016.rds")

# Coles
sac_dest = subset(airline, DEST == "SMF")
# clean
sac_dest = sac_dest[which(sac_dest$ARR_DEL15 != "NA"),]
# Subset for SF
sf_dest = subset(airline, DEST == "SFO")
# clean
sf_dest = sf_dest[which(sf_dest$ARR_DEL15 != "NA"),]
# Subset for Califoria
ca_dest = subset(airline, DEST_STATE_ABR == "CA")
# clean
ca_dest = ca_dest[which(ca_dest$ARR_DEL15 != "NA"),]
#### Airline ####
table(airline$CARRIER)
table(is.na(sac_dest$ARR_DEL15))
# Sac
# In descending order of ArrDel15
#JetBlue, SkyWest, Delta, Southwest, American, Alaska, United,
Hawaiian
sort(tapply(sac_dest$ARR_DEL15, sac_dest$CARRIER, mean),
decreasing = TRUE)
sac_by_carrier = sort(tapply(sac_dest$ARR_DEL15, sac_dest$CARRIER,
                             mean), decreasing = TRUE)
barplot()

library(ggplot2)

sort(tapply(sac_dest$ARR_DEL15, sac_dest$ORIGIN_CITY_NAME, mean, na.rm = TRUE))
sort(tapply(sac_dest$ARR_DEL15, sac_dest$CARRIER, mean, na.rm = TRUE))

sort(tapply(sf_dest$ARR_DEL15, sf_dest$ORIGIN_CITY_NAME, mean, na.rm = TRUE))
sort(tapply(sf_dest$ARR_DEL15, sf_dest$CARRIER, mean, na.rm = TRUE))

sort(tapply(sac_dest$ARR_DEL15, sac_dest$DAY_OF_WEEK,
mean), decreasing = TRUE)

sac_by_day = tapply(sac_dest$ARR_DEL15, sac_dest$DAY_OF_WEEK,
mean)

week = c("Monday","Tuesday", "Wednesday", "Thursday", "Friday",
"Saturday", "Sunday")
names(sac_by_day) <- week
plot(sac_by_day)
barplot(sac_by_day,
main="Proportion of Delays by Day of Week",
ylab="Proportion of Delay")
