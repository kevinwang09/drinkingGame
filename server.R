# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
  
  # gettingData = reactive({
  #   distributions = c("Exponential", "Uniform", "Normal")
  #   chosenDist = sample(distributions, 1)
  #   chosenData = dplyr::case_when(
  #     chosenDist == "Exponential" ~ rexp(input$numDataPoints, rate = 1),
  #     chosenDist == "Normal" ~ rnorm(input$numDataPoints),
  #     chosenDist == "Uniform" ~ runif(input$numDataPoints)
  #   )
  #   
  #   result = list(
  #     chosenDist = chosenDist, 
  #     chosenData = chosenData 
  #   )
  #   
  #   return(result)
  # })
  
  result = reactiveValues(chosenDist = NULL,
                          chosenData = NULL)
  
  observeEvent(input$computeButton,{
    distributions = c("Exponential", "Uniform", "Normal")
    chosenDist = sample(distributions, 1)
    chosenData = dplyr::case_when(
      chosenDist == "Exponential" ~ rexp(input$numDataPoints, rate = 1),
      chosenDist == "Normal" ~ rnorm(input$numDataPoints),
      chosenDist == "Uniform" ~ runif(input$numDataPoints)
    )
    
      result$chosenDist = chosenDist
      result$chosenData = chosenData
      
      removeUI(
        selector = "div:has(> numDataPoints)"
      )
      
      removeUI(
        selector = "div:has(> computeButton)"
      )
  })
  
  
  output$qqPlotly = renderPlotly({
    if(is.null(result$chosenData)){return(NULL)} 
    else {
      qqPlotly(result$chosenData)
    }
  })
  
  output$densityPlotly = renderPlot({
    
    if(is.null(result$chosenData)){return(NULL)} 
    else {
      denPlot(result$chosenData)
    }
  })
  
  
  
  output$summary = renderPrint({
    if(is.null(result$chosenData)){NULL} 
    else {summary(result$chosenData)}
  })
  
  
  
  # observeEvent(input$distributionButton,{
  #   win = input$inputDist == result$chosenDist
  # })
  
  
  output$winning = renderPrint({
    if(is.null(result$chosenData)){NULL} 
    else {input$inputDist == result$chosenDist}
  })
}