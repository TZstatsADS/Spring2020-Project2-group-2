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
  dt.map <- reactive({
    arrest.cleaned %>% 
      filter(OFNS_DESC == input$Ani.crimetype) %>% 
      filter(ARREST_DATE <= input$Ani.enddate & ARREST_DATE >= input$Ani.startdate)%>% 
      filter(ARREST_BORO == input$Ani.region)
  })
  
  dt.map.updateselect <- reactive({
    arrest.cleaned %>% 
      filter(ARREST_DATE <= input$Ani.enddate & ARREST_DATE >= input$Ani.startdate)%>% 
      filter(ARREST_BORO == input$Ani.region)
  })
  
  output$test <- renderText(input$Ani.crimetype)
  
  observeEvent(input$Ani.startdate, {
    update.crimetype.njy <- dt.map.updateselect()$OFNS_DESC
    #update.endtime.zrz <- df.map()$ARREST_DATE
    updateSelectInput(session, 
                      "Ani.crimetype", 
                      choices = unique(update.crimetype.njy), 
                      selected = ifelse(input$Anim.crimetype %in% unique(update.crimetype.njy),
                                        input$Anim.crimetype, sort(unique(update.crimetype.njy))[1]))
    if(input$Ani.startdate > input$Ani.enddate){
      updateDateInput(session, 
                      "Ani.enddate",
                      value = as.Date(input$Ani.startdate, origin = "1970-01-01"),
                      min = as.Date(input$Ani.startdate, origin = "1970-01-01"),
                      max = max(arrest.cleaned$ARREST_DATE))
    }
  })
  
  observeEvent(input$Ani.enddate, {
    crimetype.njy <- dt.map.updateselect()$OFNS_DESC
    #update.starttime.zrz <- df.map()$ARREST_DATE
    updateSelectInput(session, 
                      "Ani.crimetype", 
                      choices = unique(crimetype.njy), 
                      selected = ifelse(input$Anim.crimetype %in% unique(crimetype.njy),
                                        input$Anim.crimetype, sort(unique(crimetype.njy))[1]))
    if(input$Ani.startdate > input$Ani.enddate){
      updateDateInput(session,
                      "Ani.startdate",
                      value = as.Date(input$Ani.enddate, origin = "1970-01-01"),
                      min = min(arrest.cleaned$ARREST_DATE),
                      max = as.Date(input$Ani.enddate, origin = "1970-01-01")
      )
    }
  })
  
  output$map.njy <- renderLeaflet({
    
    ar.dt_by_date <- subset(arrest.cleaned,
                            ARREST_DATE <= input$Ani.enddate & ARREST_DATE >= input$Ani.startdate & ARREST_BORO == input$Ani.region & OFNS_DESC == input$Ani.crimetype)
    
    ar.dt_by_date %>%
      leaflet(width = "100%") %>%
      addProviderTiles("Esri.WorldTopoMap",
                       options = providerTileOptions(noWrap = T)) %>% 
      setView(lng = -73.99,lat = 40.72,zoom = 12) %>%
      addHeatmap(lng = ar.dt_by_date$Longitude,lat = ar.dt_by_date$Latitude,
                 intensity = ifelse(ar.dt_by_date$LAW_CAT_CD=="FELONY",10,
                                    ifelse(ar.dt_by_date$LAW_CAT_CD=="MISDEMEANOR",4,1)),
                 blur = 15, max = 0.05,radius = 12)%>% 
      addResetMapButton()
    
  })
  
  
  
  
  
  
  
  
})
