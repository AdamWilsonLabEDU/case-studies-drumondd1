install.packages("gapminder")
#load packages
library ("ggplot2")
library ("gapminder")
library ("dplyr")
glimpse(gapminder)

#remove "kuwait"....
gapminder_filtered <- gapminder %>%
  filter(country != "Kuwait")

#create the plot
ggplot(gapminder_filtered, aes(x = lifeExp, y = gdpPercap,  color = continent, size = pop / 100000)) + 
  geom_point() +
  facet_wrap(~year, nrow = 1) + 
  scale_y_continuous(trans = "sqrt") +
  theme_bw() + 
  labs(
    x = "GDP per Capita",
    y = "life Expectancy",
    size = "Population (100k)",
    color = "Continent", 
    tiltle = "Life Expectancy vs GDP per Capita by year (Excluding Kuwait)"
  )
    
# Group by 'continent' and 'year' and summarize data
gapminder_continent <- gapminder_filtered %>%
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))

#plot graph 2
ggplot() + 
  geom_line(data = gapminder_filtered, mapping = aes(x=year, y=gdpPercap, color = continent, group = country)) + 
  geom_point(data = gapminder_filtered, mapping = aes(x=year, y=gdpPercap, color = continent, group = country)) + 
  geom_line(data= gapminder_continent, mapping = aes(x=year, y=gdpPercapweighted)) + 
  geom_point(data= gapminder_continent, mapping = aes(x=year, y=gdpPercapweighted, size = pop/100000)) + 
  facet_wrap(~continent, nrow = 1) + 
  theme_bw() + 
  labs(x = "year",
       y = "gdpPercap",
       size = "Population (100k)",
       color = "Continent", 
       tiltle = "Life Expectancy vs GDP per Capita by year (Excluding Kuwait)"
  )
  
# save graph
ggsave("C_03_4Result.png")
