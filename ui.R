library(shiny)
library(plotly)
library(dplyr)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Kevin Wang's Drinking Game"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "numDataPoints",
                  label = "Number of Data Points",
                  min = 1,
                  max = 100,
                  value = 20)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotlyOutput(outputId = "plot1")
      
    )
  )
)