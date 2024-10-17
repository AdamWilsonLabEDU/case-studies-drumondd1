install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

# Join two datasets using a common column
flights_joined <- left_join(flights, airports, by = c('dest' = 'faa'))

head(flights_joined[,c('origin', 'dest', 'distance', 'name')])


farthest_airport <- flights_joined %>% filter(distance == max(distance)) %>% 
  select(name) %>% distinct()
