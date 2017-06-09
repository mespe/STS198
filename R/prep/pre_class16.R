
library(leaflet)

mp = leaflet()
# mp = addProviderTiles(providers$CartoDB.Postion)
mp = addMarkers(mp, lng = posts$long, lat = posts$lat)
mp = addTiles(mp)
mp


library(ggmap)

bounds = with(posts, c(min(long, na.rm = TRUE),
                       min(lat, na.rm = TRUE),
                       max(long, na.rm = TRUE),
                       max(lat, na.rm = TRUE)))

bounds

map = get_map(bounds, zoom = 5)
ggmap(map, extent = "device")

qmplot(long, lat, data = posts, maptype = "toner-lite", color = I("red"))

quantile(posts$long, na.rm = TRUE)
quantile(posts$lat, na.rm = TRUE)
out = subset(posts, long  > -121)
ca = subset(posts, long < -121 & lat < 39 & lat > 32)

qmplot(long, lat, data = ca, color = I("red"), alpha = I(0.2))

