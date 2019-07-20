library(shiny)
library(plotly)
library(broom)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # Calculation
  mpgdf <- mtcars[,c("mpg","hp")]
  model <-lm(mpg~hp,data=mpgdf)
  
  modelpred <- reactive({
    hpInput <- input$HP
    predict(model, newdata=data.frame(hp=hpInput))
  })
  
  output$distPlot <- renderPlotly({
    hpInput <- input$HP
    
    # draw the plots
    if(input$Hist1){
      plot_ly(mpgdf,x=~hp, type="histogram",color = I("light blue")) %>%
        layout(title="Distribution of Gross Horsepower",xaxis=list(title="Gross Horsepower",range=c(50,350)))
    } else if(input$Hist2) {
      plot_ly(mpgdf,x=~mpg, type="histogram",color=I("tomato"))%>%
        layout(title="Distribution of Miles per Gallon",xaxis=list(title="Miles per Gallon",range=c(0,50)))
    } else if(input$Relation){
        p3<- plot_ly(mpgdf,x=~hp,y=~mpg,type="scatter",mode="markers", colors = "blue", name="Real Value")%>%
          layout(title="Scatter Plot",
                 yaxis=list(title="Miles per Gallon",range=c(0,50)),xaxis=list(title="Gross Horsepower",range=c(50,350)))
        p3} else if(input$Fit){
             p4<- plot_ly(mpgdf,x=~hp,y=~mpg,type="scatter",mode="markers", colors = "blue", name="Real Value")%>%
                    layout(title="Model Result", yaxis=list(title="Miles per Gallon",range=c(0,50)),xaxis=list(title="Gross Horsepower",range=c(50,350)))%>%
                    add_trace(x=~hp,y=~fitted(model),mode="lines", colors="organge", name="Fitted Value")%>%
                    add_ribbons(data = augment(model),
                           ymin = ~.fitted - 1.96 * .se.fit,
                           ymax = ~.fitted + 1.96 * .se.fit,
                           line = list(color = 'rgba(7, 164, 181, 0.05)'),
                           fillcolor = 'rgba(7, 164, 181, 0.2)',
                           name = "Standard Error") 
             p4
          } 
  })
  
  output$pred <- renderText({
    hpInput <- input$HP
    if(input$Result){
      round(modelpred(),2)
    }
 })
})