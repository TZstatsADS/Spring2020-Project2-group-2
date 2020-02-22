#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  
  
  # Animation 
   
  dt.map2.njy <- reactive({
    arrest.cleaned.njy %>% 
      filter(OFNS_DESC == input$Ani2.crimetype) %>% 
      filter(year %in% input$ani.time)
  })
  
  
  output$map2.njy <- renderLeaflet({
    
    ar.dt_by_date2 <- dt.map2.njy()
    
    ar.dt_by_date2 %>%
      leaflet(width = "100%") %>%
      addProviderTiles("Esri.WorldTopoMap",
                       options = providerTileOptions(noWrap = T)) %>% 
      setView(lng = -73.99,lat = 40.72,zoom = 11) %>%
      addHeatmap(lng = ar.dt_by_date2$Longitude,lat = ar.dt_by_date2$Latitude,
                 intensity = nrow(ar.dt_by_date2),
                 blur = 15, max = 0.05,radius = 10)
    
  })
  
  
  
  
})
