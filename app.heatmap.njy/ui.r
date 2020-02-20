library(shiny)
library(shinydashboard)

ui <-
    dashboardPage(
      skin = "red",
      
      dashboardHeader(title = "Arrest Data Analysis"),
      
      dashboardSidebar(
        sidebarMenu(
          menuItem("Map", tabName = "Map"),
          menuItem("Animation", tabName = "Animation"),
          menuItem("Menu3", tabName = "Menu3"),
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
          
          tabItem(tabName = "Animation",
                  fluidRow(
                    box(
                      width = 6,
                      height = 80,
                      dateInput(inputId = "Ani.startdate",label = "Start Date",
                                value = "2018-01-01",format = "yyyy-mm-dd",
                                min = min(arrest.cleaned$ARREST_DATE),
                                max = max(arrest.cleaned$ARREST_DATE))
                    ),
                    box(
                      width = 6,
                      height = 80,
                      dateInput(inputId = "Ani.enddate",label = "End Date",
                                value = "2018-01-31",format = "yyyy-mm-dd",
                                min = min(arrest.cleaned$ARREST_DATE),
                                max = max(arrest.cleaned$ARREST_DATE))
                    ),
                    box(
                      width = 6,
                      height = 80,
                      selectInput(inputId = "Ani.crimetype", label = "Crime Type",
                                  choices = sort(unique(arrest.cleaned$OFNS_DESC)),
                                  selected = "drug dealing",
                                  multiple = T)
                    ),
                    box(
                      width = 3,
                      height = 80,
                      selectInput(inputId = "Ani.region", label = "Borough",
                                  choices = unique(arrest.cleaned$ARREST_BORO),
                                  selected = "Manhattan",
                                  multiple = T)
                    )
                  ),
                  fluidRow(
                    box(
                      width = 12,
                      height = 700,
                      leafletOutput("map.njy", height = 680)
                    )
                  ) # map
          ),
          
          tabItem(tabName = "Menu3",
                  fluidRow(
                    
                  ) 
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



