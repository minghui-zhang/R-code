# source of tutorial: http://edrub.in/ARE212/Spring2017/section12.html

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

theme_ed <- theme(
  legend.position = 'bottom',
  panel.background = element_rect(fill = NA),
  axis.ticks = element_line(color = 'grey95', size = 0.3),
  panel.grid.major = element_line(color = 'grey95', size = 0.3),
  panel.grid.minor = element_line(color = 'grey95', size = 0.3),
  legend.key = element_blank()
)

dir_12 <- '~/Documents/R code/tutorial/'

# WORKING WITH SHP FILES

beats_shp <- readOGR(dsn = path.expand('~/Documents/R code/tutorial/ChicagoPoliceBeats'), layer = 'chiBeats')

# convert shp to geojson and simplify the polygons
# FIRST TIME DOWNLOADING SHP FILE: RUN THE FOLLOWING TWO LINES, THEN DON'T NEED AGAIN
beats_json <- geojson_json(beats_shp)
beats_sim <- ms_simplify(beats_json)

# save the resulting geojson file, work with it directly. once it's saved, don't need to simplfy again.
geojson_write(beats_sim, file = 'beats_json.geojson')

# read in the geojson back as an sf object
beats_cd <- st_read('beats_json.geojson', quiet = TRUE)
# can use st_transform to change the projection

p <- ggplot(data = beats_cd, mapping = aes(fill = beat)) 



map_colors <-  RColorBrewer::brewer.pal(8, "Pastel1")
map_colors <- rep(map_colors, 37)

p_out <- p + geom_sf(color = "gray60", 
                     size = 0.1) + 
  scale_fill_manual(values = map_colors) + 
  guides(fill = FALSE) + 
  theme_map() + 
  theme(panel.grid.major = element_line(color = "white"),
        legend.key = element_rect(color = "gray40", size = 0.1))

ggsave("beats.pdf", p_out, height = 12, width = 15)



# slots have the data (data.frame), polygons, projection, bounding box
# to access the slots, use @, like beats_shp@data %>% class()
# another example: beats_shp@polygons[[1]] to get a single polygon
# the polygons themselves also have a 

# plotting with ggplot2 is slower than plot() base function 
# if polygons have a lot of points

# need to formally convert the spatial polygons data frame to a data frame for plotting (because ggplot2 wants a data frame)
beats_df <- tidy(beats_shp) #can take a long time, each row in df is a point in one of the polygons in shp file

# plotting the 'group' is the polygon
ggplot(data = beats_df, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = 'grey90') + #fills polygons with color
  geom_path(size = 0.3) + # outline of the polygon
  xlab('Longitude') +
  ylab('Latitude') +
  ggtitle('chicago police beats') +
  theme_ed

# plotting the 'group' is the polygon
ggplot(data = beats_df, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = 'grey90') + #fills polygons with color
  geom_path(size = 0.3) + # outline of the polygon
  xlab('Longitude') +
  ylab('Latitude') +
  ggtitle('chicago police beats') +
  theme_ed

# WORKING WITH POINTS DATA (RDS FILE)

#this gives an error
#crime_rdf <- readRDS('~/Documents/R code/tutorial/chicagoCrime.rds')