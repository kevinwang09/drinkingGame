# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Kevin Wang's Drinking Game"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      h3("Rules"),
      h5("This is a simple game. Pick the number of data points, and press the button."),
      p(),
      h5("A random data is generated. You must name the correct distribution to win."),
      p(),
      h5("If you picked the wrong distribution, then you drink the same number of drinks as your chosen number of data points"),
      
      
      h3("Setting up the game"),
      # Input: Slider for the number of data points ----
      shiny::numericInput(inputId = "numDataPoints",
                          label = "Number of Data Points",
                          min = 100,
                          max = 1000,
                          value = 100,
                          step = 100),
      
      actionButton(inputId = "computeButton",
                   label = "Generate data points", icon = icon("play-circle"),
                   style="text-transform: none; color: #fff; background-color: #337ab7; border-color: #2e6da4"),
      
      h3("Guess the distribution"),
      
      radioButtons("inputDist", 
                   label = h3("Available distributions"),
                   choices = list(
                     # "Exponential" = "Exponential", 
                     "Normal" = "Normal", 
                     # "Uniform" = "Uniform",
                     "t_100" = "t_100")),
      
      actionButton(inputId = "distributionButton",
                   label = "Distribution guessed", icon = icon("play-circle"),
                   style="text-transform: none; color: #fff; background-color: #337ab7; border-color: #2e6da4")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotlyOutput(outputId = "qqPlotly"),
      shiny::verbatimTextOutput("summary"),
      plotOutput("densityPlotly"),
      verbatimTextOutput("winning")
      
    )
  )
)