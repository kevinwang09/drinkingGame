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
    distributions = c("Normal", "t_100")
    chosenDist = sample(distributions, 1)
    chosenData = dplyr::case_when(
      # chosenDist == "Exponential" ~ rexp(input$numDataPoints, rate = 1),
      chosenDist == "Normal" ~ rnorm(input$numDataPoints),
      # chosenDist == "Uniform" ~ runif(input$numDataPoints),
      chosenDist == "t_100" ~ rt(input$numDataPoints, df = 100)
    )
    
      result$chosenDist = chosenDist
      result$chosenData = chosenData
      
      removeUI(
        selector = "#numDataPoints"
      )
      
      removeUI(
        selector = "#computeButton"
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
  
  
  submittedAnswer = reactiveValues(submittedDist = NULL)
  
  observeEvent(input$distributionButton,{
    submittedAnswer$submittedDist = input$inputDist
    
    removeUI(
      selector = "#inputDist"
    )
    
    removeUI(
      selector = "#distributionButton"
    )
    
    removeUI(
      selector = "#qqPlotly"
    )
    
    removeUI(
      selector = "#summary"
    )
    
    removeUI(
      selector = "#densityPlotly"
    )
    
  })
  
  output$winning = renderPrint({
    if(is.null(submittedAnswer$submittedDist)){NULL} 
    else {
      if(submittedAnswer$submittedDist == result$chosenDist) {return("You Won!")}
        else{return(paste0("You lost! Drink ", input$numDataPoints, " shots!"))}
    }
  })
}