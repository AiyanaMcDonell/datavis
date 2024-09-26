###data visualization
#always begin by loading in packages
install.packages(c("dplyr", "lubridate", "ggplot2"))
library(dplyr)
library(lubridate)
library(ggplot2)

#read in data
datCO2 <- read.csv("/cloud/project/annual-co-emissions-by-region.csv")

#change column name from long title to CO2
colnames(datCO2)[4] <- "CO2"
colnames(datCO2)

#make plots using base R
plot(datCO2$Year, datCO2$CO2,type = "l",
     xlab = "Year", ylab = "CO2 Emissions")#add formatting

#make plots using ggplot
ggplot(NA_CO, aes(x = Year, y = CO2, color = "Entity")) + geom_line()+
  labs(x="Year", y= "CO2 emissions")+
  theme_classic()

NA_CO <- datCO2 %>%
  filter(Entity== "United States"|
           Entity== "Mexico"|Entity== "Canada")


##in-class activity

#read in climate change data
dat_cc <- read.csv("/cloud/project/climate-change.csv")



#1:Make a plot of air temperature anomalies in the Northern and Southern Hemisphere in base R and in ggplot2.
#plots in base R
#northern hemi
northcc <- dat_cc %>%
  filter(Entity == "Northern Hemisphere")
plot(northcc$DayF, northcc$temperature_anomaly, ylim = c(-1.6, 2),
     type ="b", xlab = "Day", ylab = "Temperature Anomaly")

#parse date
northcc$DayF <- ymd(northcc$Day)

#southern hemi
southcc <- dat_cc %>%
  filter(Entity == "Southern Hemisphere")

#parse date
southcc$DayF <- ymd(southcc$Day)

plot(southcc$DayF, southcc$temperature_anomaly, ylim = c(-1.6, 2),
     type = "b", xlab = "Day", ylab = "Temperature Anomaly")

#plot in ggplot
#parse date
dat_cc$DayF <- ymd(dat_cc$Day)

#making a new data frame with only north and south hemispheres
hemispherecc <- dat_cc %>%
  filter(Entity == "Northern Hemisphere"|
           Entity == "Southern Hemisphere")

ggplot(hemispherecc, aes(x = Day, y = temperature_anomaly, color = Entity))+
        geom_point()+
        labs(x = "Day", y = "Temperature Anomaly")



#2: Plot the total all time emissions for the United States, Mexico, and Canada.
ggplot(NA_CO, 
       aes(x = Year, y = CO2, fill = Entity))+
  geom_area(alpha = 0.5)

#3: How would you add subscripts for CO2 in your plot axes label?
#answer = use the expression command, syntax = expression("script text"[2]) and superscripts use a ^
#example
ggplot(NA_CO, 
       aes(x = Year, y = CO2, fill = Entity))+
  geom_area(alpha = 0.5)+
  labs(y=expression(CO[2]))




