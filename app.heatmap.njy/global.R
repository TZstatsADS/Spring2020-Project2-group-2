library(shiny)
library(leaflet)
library(googleVis)
library(shinydashboard)
library(leaflet.extras)
#library(tidyverse)
library(dplyr)
library(shinyWidgets)
library(shinyanimate)
library(lubridate)

load('../output/arrest_cleaned.RData')

arrest.cleaned.njy <- arrest.cleaned %>%
  mutate(year = year(as.Date(ARREST_DATE,origin = "1970-01-01")),
         month = month(as.Date(ARREST_DATE,origin = "1970-01-01")))

arrest.cleaned.njy <- arrest.cleaned.njy %>%
  mutate(qut = ifelse(month <=3, "Q1",ifelse(month <= 6, "Q2",ifelse(month <= 9,"Q3","Q4"))))

arrest.cleaned.njy <- arrest.cleaned.njy %>%
  mutate(yearq = paste(year,qut,sep = " "))

