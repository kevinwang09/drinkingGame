# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$plot1 = renderPlotly({
    x = rnorm(input$numDataPoints, mean = 0, sd = 1)
    sortX = sort(x)
    range = ((1:length(sortX)) - 0.5) / length(sortX)
    theoQuantile = qnorm(range)
    df = data.frame(theoQuantile = theoQuantile, sortX = sortX) %>% 
      dplyr::arrange(sortX)
    
    
    p = plot_ly(df, x = ~theoQuantile, y = ~sortX, type = "scatter", mode = "markers") 
    p
    # plot(x)
    # qqnorm(x)
    # qqline(x)
  })
  
}