library(shiny)
library(leaflet)
library(leaflet.extras)
library(googleVis)
library(shinydashboard)
library(tidyverse)
library(dplyr)
library(shinyWidgets)
library(ggplot2)
library(lubridate)



setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
load("/Users/ruozhou_zhang/Documents/statistic_S02/GR5243_Applied_Data_Science/Spring2020-Project2-group-2/output/arrest_cleaned.RData")

################################################ Global for Time series

arrest<-arrest.cleaned %>%
  mutate(year=year(ARREST_DATE),
         month=month(ARREST_DATE))

pp<-function(data,type,borough,y){
  df<-data %>%
    group_by(year,month,OFNS_DESC,ARREST_BORO) %>%
    count() %>%
    filter(year==y) %>%
    filter(OFNS_DESC==type) %>%
    filter(ARREST_BORO==borough)
  
  g<-ggplot(data=df,mapping = aes(x=month,y=n))+
    geom_point(color="orange",size=10)+
    geom_line(size=2)+
    labs(title = paste("In",as.character(y),"the number of",as.character(type),"happened in",as.character(borough)),
         x="month",
         y="count")+
    scale_x_continuous(breaks = seq(1,12,by=1))+
    theme_light()+
    theme(plot.title = element_text(hjust = 0.5))
  
  return(g)
}

#type is all
tt<-function(data,borough,y){
  df<-arrest %>%
    group_by(year,month,ARREST_BORO)%>%
    count()%>%
    filter(year==y) %>%
    filter(ARREST_BORO==borough)
  
  g<-ggplot(data=df,mapping = aes(x=month,y=n))+
    geom_point(color="orange",size=10)+
    geom_line(size=2)+
    labs(title = paste("In",as.character(y),"the number of all types of crimes happened in",as.character(borough)),
         x="month",
         y="count")+
    scale_x_continuous(breaks = seq(1,12,by=1))+
    theme_light()+
    theme(plot.title = element_text(hjust = 0.5))
  
  return(g)
}

#borough is all
qq<-function(data,type,y){
  df<-arrest %>%
    group_by(year,month,OFNS_DESC) %>%
    count() %>%
    filter(year==y) %>%
    filter(OFNS_DESC==type)
  
  g<-ggplot(data=df,mapping = aes(x=month,y=n))+
    geom_point(color="orange",size=10)+
    geom_line(size=2)+
    labs(title = paste("In",as.character(y),"the number of",as.character(type),"happened in all boros"),
         x="month",
         y="count")+
    scale_x_continuous(breaks = seq(1,12,by=1))+
    theme_light()+
    theme(plot.title = element_text(hjust = 0.5))
  
  return(g)
}

#type and borough all are all
aa<-function(data,y){
  df<-arrest %>%
    group_by(year,month) %>%
    count() %>%
    filter(year==y)
  
  g<-ggplot(data=df,mapping = aes(x=month,y=n))+
    geom_point(color="orange",size=10)+
    geom_line(size=2)+
    labs(title = paste("In",as.character(y),"the number of all types of crimes happened in all boros"),
         x="month",
         y="count")+
    scale_x_continuous(breaks = seq(1,12,by=1))+
    theme_light()+
    theme(plot.title = element_text(hjust = 0.5))
  
  return(g)
}






