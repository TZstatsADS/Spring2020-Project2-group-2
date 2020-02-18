library(shiny)


ui <-
    dashboardPage(
      skin = "red",
      
      dashboardHeader(title = "Rodent Inspection"),
      
      dashboardSidebar(
        sidebarMenu(
          menuItem("Map", tabName = "Map"),
          menuItem("Menu2", tabName = "Menu2"),
          menuItem("Menu3", tabName = "Menu3"),
          menuItem("Menu4", tabName = "Menu4")
        )
      ),
      
      dashboardBody(
        tabItems(
          tabItem(tabName = "Map",
                  fluidRow(
                    box(
                      width = 3,
                      height = 80,
                      dateInput("Map.starttime",
                                "Start Time",
                                value = "2018-01-01",
                                min = min(arrest.cleaned$ARREST_DATE),
                                max = max(arrest.cleaned$ARREST_DATE))
                    ),
                    box(
                      width = 3,
                      height = 80,
                      dateInput("Map.endtime",
                                "End Time",
                                value = "2018-01-31",
                                min = min(arrest.cleaned$ARREST_DATE),
                                max = max(arrest.cleaned$ARREST_DATE))
                    ),
                    box(
                      width = 6,
                      height = 80,
                      selectInput("Map.crimetype",
                                  "Type of Crime",
                                  choices = sort(unique(arrest.cleaned$OFNS_DESC)),
                                  selected = "drug dealing",
                                  multiple = T)
                    )
                  ),# select boxes end here
                  fluidRow(
                    box(
                      width = 12,
                      height = 700,
                      ## The output is Here!
                      leafletOutput("map.zrz", height = 680)
                    )
                  ) # map box
          ),
          
          tabItem(tabName = "Menu2",
                  fluidRow(
                    textOutput("test")
                  )
          ),
          
          tabItem(tabName = "Menu3",
                  fluidPage(
                  )
          ),
          
          tabItem(tabName = "Menu4",
                  fluidPage(
                  )
          )
        )
      )
    )



