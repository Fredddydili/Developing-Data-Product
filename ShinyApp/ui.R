# Define UI for application that analyzes and regresses the data, mtcars (Motor Trend Car Road Tests), 
# shown on multiple flexible plotts and does prediction based on input.  
# Indepent variabels:hp (Gross horsepower)
# Outcome: mpg (Miles per gallon)

library(shiny)
library(plotly)
library(broom)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Plotting Data Analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("HP", "What is the gross horsepower of the car?",50,350,value=150, step = 10),
      checkboxInput("Hist1", "Distribution of Horsepower", value=TRUE),
      checkboxInput("Hist2", "Distribution of Miles per Gallon", value=TRUE),
      checkboxInput("Relation", "Scatter Plot", value=TRUE),
      checkboxInput("Fit", "Regression Model", value=TRUE),
      checkboxInput("Result", "Predicted Result", value=TRUE),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("distPlot"),
       h3("Predicted Miles per Gallon from Model:"),
       textOutput("pred")
    )
  )
))
