# STS 198
# Spring 2017

load("../../data/bike_FARS.Rda")


ff = list.files("../../data/CollegeScorecard_Raw_Data/",
                pattern = ".csv", full.names = TRUE)

csc1996 = read.csv(ff)

# foo(filename){
#     something...
#     }

foo(ff[1])
foo(ff[2])

ans = lapply(ff, read.csv)

# What is a list?

my_list = list(a = letters[1:5], b = 1:2, c = "Bob")

my_list2 = list(a = letters[1:5], b = 1:2, c = "Bob")

my_list$a

# Using split() with lapply()
by_state = split(bike$PEDCGP, bike$STATE)

lapply(by_state, length)

tapply(bike$PEDCGP, bike$STATE, length, simplify = FALSE)

by_state$California
lapply(by_state)

# Same thing - why use split?
by_state2 = split(bike, bike$STATE)

wy = by_state2[["Wyoming"]]["STATE"]

str(wy)


################################################################################

ans = lapply(by_state2, subset, PEDLOC %in% c("Not At Intersection","At Intersection"))

mod = lm(

