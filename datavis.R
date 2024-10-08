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




###homework 3
#question 1: Make a graph that communicates about emissions from any countries of your choice. 
#Explain how you considered principles of visualization in making your graph.

#making a df for Japan, South Korea, and China
EA_CO <- datCO2 %>%
  filter(Entity== "Japan"|
           Entity== "South Korea"|Entity== "China")

#making graph that shows CO2 emissions in east asia over time
ggplot(EA_CO, 
       aes(x = Year, y = CO2, color = Entity))+
  geom_point(pch = 17)+ 
  geom_line()+
  labs(x="Year", y=expression(CO[2]))+
  theme_classic()+
  scale_color_manual(values = c("#D81B60","#34495E55", "#FFC107"))+ #color-blind friendly hues
  annotate("text",
           x = 1900,
           y = 9750000000,
           label = "CO2 Emissions in East Asia Over Time")


#question 2: Make two graphs to present in your word document side by side 
#Plot world CO2 emissions on one graph and world air temperature anomalies on the other graph.  

#plot of world temp anomalies
ggplot(dat_cc, 
       aes(x = DayF, y = temperature_anomaly, fill = Entity))+
  theme_light()+
  geom_area(alpha = 0.5)+
  labs(x="Day", y="Temperature", title = "World Temperature Anomalies")

#plot of CO2 emissions
ggplot(datCO2, 
       aes(x = Year, y = CO2))+
  theme_light()+
  geom_point(alpha = 0.3)+
  labs(x="Year", y="CO2 Emissions", title = "World CO2 Emissions")


#Question 3: Remake any graph from environmental data of your interest in our world in data.
#link to article used: https://ourworldindata.org/elephant-populations

#read in data
elephants <- read.csv("/cloud/project/african-elephants.csv")

#make a df to only include "Africa"
afr.elephants <- elephants %>%
  filter(Entity == "Africa")

#plot
ggplot(afr.elephants,
       aes(x = Year, y = Number.of.African.elephants, fill = Entity))+
  theme_classic()+
  geom_point()+ #i don't like this visualization but this was the only way to present it in ggplot
  labs(x = "Year", y = "Number of Elephants in Africa", 
       title = "Number of African Elephants Over Time")
  
