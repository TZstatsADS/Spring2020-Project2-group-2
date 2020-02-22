library(shiny)


ui <-
    dashboardPage(
      skin = "red",
      
      dashboardHeader(title = "NYC Arrest Data"),
      
      dashboardSidebar(
        sidebarMenu(
          menuItem("Map", tabName = "Map", icon = icon("map")),
          menuItem("TimeSeries", tabName = "TimeSeries", icon = icon("chart-line")),
          menuItem("PieChart", tabName = "PieChart", icon = icon("chart-pie")),
          menuItem("Menu4", tabName = "Menu4")
        )
      ),
      
      dashboardBody(
        tags$style(type="text/css",
                        ".shiny-output-error { visibility: hidden; }",
                        ".shiny-output-error:before { visibility: hidden; }"
          ),
        
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
          
          tabItem(tabName = "TimeSeries",
                  fluidPage(
                    fluidRow(
                      column(6,
                             sliderInput(inputId = "year",label = "Choose a year",value = 2012,step=1,min = 2006,max = 2018)),
                      
                      column(6,
                             selectInput(inputId = "choice_type",label ="choose a type",
                                         choices =c(unique(as.character(arrest$OFNS_DESC)),"ALL"))),
                      
                      column(6,
                             selectInput(inputId = "choice_borough",label = "choose a borough",choices =c(unique(arrest$ARREST_BORO),"ALL")))
                    ),
                    
                    fluidRow(
                      plotOutput(outputId = "ggplot",height = "600px")
                    )
                  )
          ),
          
          tabItem(tabName = "PieChart",
                  fluidPage(
                    fluidRow(
                      # year
                      column(6,
                             selectInput(inputId = "choose_year",label ="choose a year",
                                         choices = unique(as.character(arrest.cleaner$year)))
                      ),
                      # borough
                      column(6,
                             selectInput(inputId = "choose_borough",label ="choose a borough",
                                         choices = unique(as.character(arrest.cleaner$arrest_boro)))
                      ),
                      # crime type
                      column(6,
                             selectInput(inputId = "choose_type",label ="choose a type",
                                         choices = unique(as.character(arrest.cleaner$ofns_desc)))
                      ),
                    ),
                    fluidRow(
                      plotlyOutput("plot"), align="center"
                    ),
                  )
          ),
          
          tabItem(tabName = "Menu4",
                  fluidPage(
                  )
          )
        )
      )
    )



