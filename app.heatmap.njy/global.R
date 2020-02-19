library(shiny)
library(leaflet)
library(googleVis)
library(shinydashboard)
library(leaflet.extras)
#library(tidyverse)
library(dplyr)
library(shinyWidgets)

load('../output/arrest_cleaned.RData')

dt.ar <- as.data.frame(arrest.cleaned)

