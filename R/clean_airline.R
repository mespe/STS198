# Script to clean up and subset the airline data to be
# a bit more manageable for the students

airline <- read.csv("../data/273586099_T_ONTIME.csv", stringsAsFactors = FALSE)
str(airline)

airline$FL_DATE <- as.Date(airline$FL_DATE)
airline$X <- NULL
table(airline$DIVERTED)

save(airline, file = "../data/airline_delay2016.rds")

### Reduced data set ###
tt <- table(airline$ORIGIN)
sum(tt[order(tt, decreasing = TRUE)][1:6])

sort(table(airline$DEST_STATE_ABR))

CAarrivals <- airline[airline$DEST_STATE_ABR == "CA",]

saveRDS(CAarrivals, file = "../data/CA_arrivals2016.rds")
