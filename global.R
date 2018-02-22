library(shiny)
library(plotly)
library(dplyr)


theme_set(theme_bw(18) +
            theme(legend.position = "bottom"))



qqPlotly = function(x){
  
  sortX = sort(x)
  range = ((1:length(sortX)) - 0.5) / length(sortX)
  theoQuantile = qnorm(range)
  df = data.frame(theoQuantile = theoQuantile, sortX = sortX) %>% 
    dplyr::arrange(sortX)
  
  # Find 1st and 3rd quartile for the Alto 1 data
  quantileX = quantile(x, probs = c(0.25, 0.75), type = 7)
  qnormQ = qnorm(c(0.25, 0.75))
  
  # Now we can compute the intercept and slope of the line that passes
  # through these points
  slope = diff(quantileX)/diff(qnormQ)
  int = quantileX[1L] - slope * qnormQ[1L]
  
  
  
  p = plot_ly(df, x = ~theoQuantile, y = ~sortX, type = "scatter", mode = "markers") %>% 
    add_lines(x = ~range(theoQuantile), y = ~int+slope*range(theoQuantile))
  p
}

denPlot = function(x){
  df = data.frame(x = x)
  
  return(ggplot(df, aes(x = x)) +
    geom_histogram(aes(y = ..density..),
                   fill = "#bfd7ff",
                   colour = "black",
                   bins = 30) +
    geom_density(aes(y = ..density..),
                 size = 2) +
    geom_point(y = 0, 
               size = 4, 
               shape = 3) + 
    labs(title = "Density plot of the data"))
}