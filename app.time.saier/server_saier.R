server<-function(input,output){
  output$ggplot<-renderPlot({
    y<-input$year
    type<-input$choice_type
    borough<-input$choice_borough
    
    if(type=="ALL"&borough=="ALL"){
      return(aa(data=arrest,y=y))
    }else if(type=="ALL"&borough!="ALL"){
      return(tt(data=arrest,borough=borough,y=y))
    }else if(type!="ALL"&borough=="ALL"){
      return(qq(data=arrest,type=type,y=y))
    }else{
      return(pp(data=arrest,type = type,borough=borough,y=y))
    }
    
    
    
  })
  
  
  
}