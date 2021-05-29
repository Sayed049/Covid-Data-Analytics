# GET COVID DAILY INFECTIONS DATA AND CREATE ANIMATED PLOT IN R


## Install Packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("scales")
install.packages("readr")
install.packages("gganimate")
install.packages("reshape2")
install.packages("tidyr")
install.packages("zoo")


## This is the required libraries
library(dplyr)
library(ggplot2)
library(scales)
library(readr)
library(gganimate)
library(reshape2)
library(tidyr)
library(zoo)


## Covid Data From CSV File
s <- read_csv("total_cases.csv")
s <- data.frame(s)
View(s)


## Each country has its own column, we would this wide column to make a long table using melt
d <- melt(s, id="date")
View(d)


## There might be some columns which has the missing data we can approx.
## the data so that the graph doesn't show any break
d$value <- zoo::na.approx(d$value)


## Try to plot the data for the following countries
dPlot <- d %>%
  dplyr::filter(variable %in% c('Chaina'
                                ,'Bhutan'
                                ,'Canada'
                                ,'Angola'
                                ,'Australia'
                                ,'Singapore')
  )


## Create a plot with animation
p1 <- ggplot(data = dPlot, aes(x = date, y = value, colour = variable))
p1 <- p1 + geom_point(show.legend = FALSE)
p1 <- p1 + geom_point(show.legend = FALSE, aes(x = date, y = value))
p1 <- p1 + theme_bw()
p1 <- p1 + transition_reveal(date)
p1 <- p1 + scale_color_brewer(palette = "Dark2")
p1 <- p1 + scale_y_log10(breaks = pretty_breaks(), labels = comma)
p1 <- p1 + facet_wrap(~variable)
p1 <- p1 + labs(title = "Corona Affected Patients")
p1 <- p1 + labs(subtitle = "Frame {frame} of {nframes}")
p1 <- p1 + labs(caption = "Covid19")
p1 <- p1 + labs(x = "Date", y = "Patients")


## Print The Result
p1

