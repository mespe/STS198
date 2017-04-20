load(url("https://github.com/mespe/STS198/blob/master/data/CA_arrivals2016.rda?raw=true"))


obsUnit = paste(CAarrivals$FL_NUM, CAarrivals$FL_DATE, 
                CAarrivals$UNIQUE_CARRIER, CAarrivals$ORIGIN)
length(unique(obsUnit))
nrow(CAarrivals)

# What have we learned:
# different carriers use the same flight numbers
# same flight numbers are used for different dates
# same flight number is used for multiple origin cities


## Unique carrier vs carrier
all(CAarrivals$CARRIER == CAarrivals$UNIQUE_CARRIER)
unique(CAarrivals$DEST_CITY_NAME)
