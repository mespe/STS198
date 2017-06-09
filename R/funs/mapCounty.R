# plotCounty = function(data, )
# {
#     require(fiftystater)
#     require(ggplot2)

#     # if(length(data) == 0 || !is.vector(data))
#     #     stop("Must provide data vector")
#     # if(length(states) == 0 || !is.vector(states))
#     #     stop("Must provide state vector")

#     map.data = data.frame(x = data, state = tolower(states), stringsAsFactors = FALSE)
#     if(any(states == "" | states == "--")){
#         map.data = subset(map.data, !state %in% c("","--"))
#         warning("Excluding data where state is not specified")
#     }

#     if(all(nchar(map.data$state) == 2)){
#         i = match(map.data$state, tolower(state.abb))
#         map.data$state = tolower(state.name)[i]
#     }
    
#     ggplot(data = map.data, aes(map_id = state)) +
#         geom_map(aes(fill = x), map = fifty_states) +
#         expand_limits(x = fifty_states$long, y = fifty_states$lat) +
#         coord_map(projection = "mercator") +
#         theme_bw() +
#         fifty_states_inset_boxes() 
# }

# From https://stackoverflow.com/questions/23714052/ggplot-mapping-us-counties-problems-with-visualization-shapes-in-r
library(rgdal)

US.counties <- readOGR(dsn="../../data",layer="gz_2010_us_050_00_5m",
                       stringsAsFactors = TRUE)
#leave out AK, HI, and PR (state FIPS: 02, 15, and 72)
US.counties <- US.counties[!(US.counties$STATE %in% c("02","15","72")),]  
county.data <- US.counties@data
county.data <- cbind(id=rownames(county.data),county.data)
# county.data <- data.table(county.data)
# county.data[,FIPS:=paste0(STATE,COUNTY)] # this is the state + county FIPS code
county.data$FIPS = as.numeric(paste0(county.data$STATE, county.data$COUNTY))
# setkey(county.data,FIPS)      
# obesity.data <- data.table(df)
# setkey(obesity.data,FIPS)
# county.data[obesity.data,obesity:=PCT_OBESE_ADULTS10]


 map.df <- fortify(US.counties)
# setkey(map.df,id)
# setkey(county.data,id)
# map.df[county.data,obesity:=obesity]
gini = read.csv("../../data/ACS_15_5YR_B19083_with_ann.csv",
                stringsAsFactors = FALSE, skip = 1)

# idx = match(gini$Id, county.data$GEO_ID, nomatch = NA)

dd = merge(gini, county.data, by.x = "Id", by.y = "GEO_ID")
dd = merge(map.df,dd, by = "id")

ggplot(dd, aes(x=long, y=lat, group=group, fill=Estimate..Gini.Index)) +
  scale_fill_gradientn("",colours=brewer.pal(9,"YlOrRd"))+
  geom_polygon()+coord_map()+
  labs(title="2010 Adult Obesity by Country, percent",x="",y="")+
  theme_bw()

################################################################################
# Using tmap instead as the ggplot stuff sucks

library(tmap)
US <- read_shape("gz_2010_us_050_00_20m.shp")

# leave out AK, HI, and PR (state FIPS: 02, 15, and 72)
US <- US[!(US$STATE %in% c("02","15","72")),]  

# append data to shape
US$FIPS <- paste0(US$STATE, US$COUNTY)
US <- append_data(US, df, key.shp = "FIPS", key.data = "FIPS")

################################################################################
# The easy way
library(raster)

election = read.csv("../../data/2016_election/2016_US_County_Level_Presidential_Results.csv",
                    stringsAsFactors = FALSE)
gini = read.csv("../../data/ACS_15_5YR_B19083_with_ann.csv",
                stringsAsFactors = FALSE, skip = 1)

US.counties <- readOGR(dsn="../../data",layer="gz_2010_us_050_00_5m",
                       stringsAsFactors = TRUE)
#leave out AK, HI, and PR (state FIPS: 02, 15, and 72)
US.counties <- US.counties[!(US.counties$STATE %in% c("02","15","72")),]  

cc = brewer.pal(9, "Reds")

gini = merge(gini, election, by.x = "Id2", by.y = "combined_fips")
US.counties@data = merge(gini, US.counties@data, by.x = "Id", by.y = "GEO_ID")

# cc = brewer.pal(9, "Reds")
# cc2 = rev(brewer.pal(9, "RdBu"))
cc = colorRampPalette(c("white","red"))(255)
cc2 = colorRampPalette(c("blue","red"))(255)
par(mfrow = c(1,2))
plot(US.counties, col = cc[cut(US.counties@data$Estimate..Gini.Index, 255)])
plot(US.counties, col = cc2[cut(US.counties@data$per_gop - US.counties@data$per_dem, 255)])

plot(Estimate..Gini.Index ~ per_gop, data = US.counties@data)

ggplot(US.counties@data, aes(x = Estimate..Gini.Index,
                             y = per_gop)) +
    geom_point() + geom_smooth(method = "lm") + theme_bw()
