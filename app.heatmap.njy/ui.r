library(shiny)
library(shinydashboard)

ui <-
    dashboardPage(
      skin = "red",
      
      dashboardHeader(title = "Arrest Data Analysis"),
      
      dashboardSidebar(
        sidebarMenu(
          menuItem("Map", tabName = "Map"),
          menuItem("Menu2", tabName = "Menu2"),
          menuItem("Animation", tabName = "Animation"),
          menuItem("Menu4", tabName = "Menu4"),
          menuItem("Menu5", tabName = "Menu5")
        )
      ),
      
      dashboardBody(
        tabItems(
          tabItem(tabName = "Map",
                  fluidRow(
                  )
          ),
          
          tabItem(tabName = "Menu2",
                  fluidRow(
                  )
          ),
          
          tabItem(tabName = "Animation",
                  fluidRow(
                    box(
                      width = 6,
                      height = 80,
                      selectInput(inputId = "Ani.crimetype", label = "Crime Type",
                                  choices = sort(unique(arrest.cleaned$OFNS_DESC)),
                                  selected = "drug dealing",
                                  multiple = T)
                    ),
                    absolutePanel(top = 50, right = 20,
                                  sliderInput("Ani.time", "Year", min = 2006, 
                                              max = 2018, value = 2016, step = 1, 
                                              animate = animationOptions(interval = 500, loop = FALSE)))
                  ),
                  fluidRow(
                    box(
                      width = 12,
                      height = 700,
                      leafletOutput("map.njy", height = 680)
                    )
                  ) # map
          ),
          
          tabItem(tabName = "Menu4",
                  fluidRow(
                    
                  ) 
          ),
          
          tabItem(tabName = "Menu5",
                  fluidRow(
                    
                  ) 
          )
        )
      )
    )







