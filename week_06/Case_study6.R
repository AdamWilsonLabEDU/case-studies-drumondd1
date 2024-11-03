# Install packages
library(terra)
library(spData)
library(tidyverse)
library(sf)
library(ncdf4)

# Download CRU Data
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc", method = "curl")

# read in the data using the rast() function from the terra package
tmean=rast("crudata.nc")
gdal(drivers = TRUE)
# Load the data using rast() function from the terra packagetmean = rast("crudata.nc")# Inspect the tmean objecttmeanplot(tmean)

# Inspect the tmean object
plot(tmean)
head(tmean)

# Calculate the maximum temperature for each country  
tmean_max <- max(tmean)

data("world")
plot(tmean_max)

# Extract maximum temperature of each continent
extracted_values <- terra::extract(x = tmean_max, y = world, fun=max, na.rm=T)

worldclim <- bind_cols(world,extracted_values) 
plot(world$geom)

# use ggplot() and geom_sf() to plot
ggplot() +
  geom_sf(data = worldclim, aes(fill = max)) +
  scale_fill_viridis_c(name="Maximum\nTemperature (C)") + 
  theme(legend.position = 'bottom')

# Find the hottest country in each continent
hottest_continent <- worldclim %>% group_by(continent) %>% arrange(desc(max), .by_group = TRUE) %>% top_n(1)

ggplot() +
geom_sf(data = world) + 
geom_sf(data = hottest_continent , aes(fill = max)) +
scale_fill_viridis_c(name="Maximum\nTemperature (C)")








