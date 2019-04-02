options(stringsAsFactors = F)

library(lubridate)
library(rgdal)
library(raster)
library(broom)
library(rgeos)
library(GISTools)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(magrittr)
library(viridis)
library(geojsonio)
library(rmapshaper)
library(sf)
library(plyr)
library(mapproj)

theme_ed <- theme(
  legend.position = 'right',
  panel.background = element_rect(fill = NA),
  axis.ticks = element_line(color = 'grey95', size = 0.3),
  #panel.grid.major = element_line(color = 'grey95', size = 0.3),
  #panel.grid.minor = element_line(color = 'grey95', size = 0.3),
  legend.key = element_blank()
)

dir_12 <- '~/Documents/R-code/tutorial/'

# WORKING WITH SHP FILES
# ~/Documents/R-code/Avery Work/input/shp/... or E:\\R-code\\Avery Work\\shp
cofco_shp <- readOGR(dsn = path.expand('E:\\R-code\\Avery Work\\input\\shp'), layer = 'Cofco_munis')
brazilOutline_shp <- readOGR(dsn = path.expand('E:\\R-code\\Avery Work\\input\\shp'), layer = 'brazilOutline')

cofco_shp@data$id <- rownames(cofco_shp@data)
cofco_df <- fortify(cofco_shp, region = 'id')
final_df <- merge(cofco_df, cofco_shp@data, by = "id")

muni_cents <- coordinates(cofco_shp)
muni_centroids_shp <- SpatialPointsDataFrame(coords=muni_cents, data=cofco_shp@data)
muni_centroids_shp@data$id <- rownames(cofco_shp@data)
muni_centroids_df <- as.data.frame(muni_centroids_shp) 
muni_centroids_df <- merge(muni_centroids_df, cofco_shp@data, by = 'id')
#rename the columns
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="Year.x"] <- "Year"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="TONS.x"] <- "TONS"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="FOB.x"] <- "FOB"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="Muni.x"] <- "Muni"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="FOB_per_TO.x"] <- "FOB_per_TON"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="coords.x1"] <- "long"
colnames(muni_centroids_df)[colnames(muni_centroids_df)=="coords.x2"] <- "lat"
print(colnames(muni_centroids_df))

#muni_centroids$id <- rownames(cofco_shp@data$id)

brazilOutline_shp@data$id <- rownames(brazilOutline_shp@data)
brazilOutline_df <- fortify(brazilOutline_shp, region = 'id')
brazilOutline_df <- merge(brazilOutline_df, brazilOutline_shp@data, by = 'id')

#df_2017 <- final_df[ which(final_df$Year==2017) , ]


# this works
map <- ggplot(data = subset(final_df, Year %in% c(2016, 2017)), aes(long, lat, group = group)) +
  geom_polygon(aes(fill = TONS), color = 'black', size = 0) +
  xlab("") + ylab("") +
  ggtitle("Cofco municipalities") +
  scale_fill_viridis("Tons", option = "B") +
  theme(axis.text = element_blank()) +
  geom_path(data = brazilOutline_df) +
  coord_map() +
  facet_grid(Year ~ .) +
  theme_ed

#print(map)

map2 <- ggplot(data = subset(muni_centroids_df, Year %in% c(2014, 2015, 2016, 2017)), aes(long, lat, group = id)) +
  geom_point(aes(long, lat, color = FOB, size = TONS), alpha = 0.5) +
  xlab("") + ylab("") +
  ggtitle("Cofco municipalities") +
  #scale_fill_viridis("FOB", option = 'D') +
  #scale_color_gradient(low = "#132B43", high = "#56B1F7") +
  theme_bw() +
  theme(axis.text = element_blank()) +
  geom_path(data = brazilOutline_df) +
  coord_map() +
  facet_wrap(Year ~ ., ncol = 2) 

print(map2)



