
shinyServer(function(input, output, session) {
  
  # The data frame for the map
  df.map <- reactive({
    arrest.cleaned %>% 
      filter(OFNS_DESC == input$Map.crimetype) %>% 
      filter(ARREST_DATE <= input$Map.endtime) %>% 
      filter(ARREST_DATE >= input$Map.starttime)
  })
  
  # The data frame for interaction between INPUTs
  df.map.updateselect <- reactive({
    arrest.cleaned %>% 
      filter(ARREST_DATE <= input$Map.endtime & ARREST_DATE >= input$Map.endtime)
  })
  
  output$test <- renderText(input$Map.crimetype)
  
  observeEvent(input$Map.starttime, {
    update.crimetype.zrz <- df.map.updateselect()$OFNS_DESC %>% unique() %>% sort()
    updateSelectInput(session, 
                      "Map.crimetype", 
                      choices = update.crimetype.zrz, 
                      selected = update.crimetype.zrz[1])
    if(input$Map.starttime > input$Map.endtime){
      updateDateInput(session, 
                      "Map.endtime",
                      value = as.Date(input$Map.starttime, origin = "1970-01-01"),
                      min = as.Date(input$Map.starttime, origin = "1970-01-01"),
                      max = max(arrest.cleaned$ARREST_DATE))
    }
  })
  
  observeEvent(input$Map.endtime, {
    update.crimetype.zrz <- df.map.updateselect()$OFNS_DESC %>% unique() %>% sort()
    updateSelectInput(session, 
                      "Map.crimetype", 
                      choices = update.crimetype.zrz, 
                      selected = update.crimetype.zrz[1])
    if(input$Map.starttime > input$Map.endtime){
      updateDateInput(session,
                      "Map.starttime",
                      value = as.Date(input$Map.endtime, origin = "1970-01-01"),
                      min = min(arrest.cleaned$ARREST_DATE),
                      max = as.Date(input$Map.endtime, origin = "1970-01-01")
      )
    }
  })
  
  output$map.zrz <- renderLeaflet({

    map <- leaflet(data = df.map()) %>% 
      addProviderTiles("Stamen.Watercolor",
                       options = providerTileOptions(noWrap = T)) %>% 
      setView(-73.974224, 40.761052,zoom = 12) %>% 
      addResetMapButton() %>% 
      addMarkers(~Longitude, 
                 ~Latitude,
                 label = ~as.character(OFNS_DESC),
                 popup = ~ paste0("<b>",ARREST_DATE,"</b>",
                                  "<br/>", "Crime Type: ", OFNS_DESC,
                                  "<br/>", "Level of Offence: ", LAW_CAT_CD,
                                  "<br/>", "Juriscition: ", JURISDICTION_CODE))
     
  })
})

