install.packages("spData")
install.packages("sf")
install.packages("tidyverse")
install.packages("ggmap")
library (spData)
library(dplyr)
library(sf)
library(ggplot2)
library (ggmap)

#load 'world' data from spData package
data(world)
# load 'states' boundaries from spData package
data(us_states)

# plot(world[1])  #plot if desired
# plot(us_states[1]) #plot if desired
# plot "world" using gglot2

# Define Projection 
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
world <- st_transform(world, albers)
us_states <- st_transform(us_states, albers)


# Filter data
canada <- world %>% filter(name_long== "Canada") %>% select(geom)
Newyork <- us_states %>% filter(NAME== "New York") %>% select(geometry)


# Create a 10 km (10,000 meters) buffer around Canada
canada_buffered <- st_buffer(canada, dist = 10000)  # 10 km = 10,000 meters

# Use st_intersection() to intersect the Canada buffer with New York state
border <- st_intersection(canada_buffered, Newyork)

# Visualize
ggplot() +
  geom_sf(data = Newyork) +
  geom_sf(data = border, colour = "red", fill = "red") +
  ggtitle("New York Land within 10km")


