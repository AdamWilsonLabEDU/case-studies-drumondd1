library(tidyverse)
library(ggplot2)

# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS_v4/tmp_USW00014733_14_0_1/station.csv"

#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")

# download the data
temp=read_csv(dataurl, 
              na="999.90", # tell R that 999.90 means missing in this dataset
              skip=1, # we will use our own column names as below so we'll skip the first row
              col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                            "APR","MAY","JUN","JUL",  
                            "AUG","SEP","OCT","NOV",  
                            "DEC","DJF","MAM","JJA",  
                            "SON","metANN"))

summary(temp)
glimpse(temp)

ggplot(data = temp, aes(x = YEAR, y = JJA)) +
         geom_line() +
  geom_point() +
  geom_smooth(color="red") +
  xlab("Year") +
  ylab("Mean summer temperatures (C)") +
  ggtitle("Mean summer temperature in Buffalo, NY")

ggsave("case_study2.png")

