library(shiny)
library(shinydashboard)

ui <-
    dashboardPage(
      skin = "red",
      
      dashboardHeader(title = "Rodent Inspection"),
      
      dashboardSidebar(
        sidebarMenu(
          menuItem("Menu1", tabName = "Menu1"),
          menuItem("Menu2", tabName = "Menu2"),
          menuItem("Menu3", tabName = "Menu3"),
          menuItem("Menu4", tabName = "Menu4")
        )
      ),
      
      dashboardBody(
        tabItems(
          tabItem(tabName = "Menu1",
                  fluidPage(
                  )
          ),
          
          tabItem(tabName = "Menu2",
                  fluidPage(
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



