library(MASS)
library(ggplot2)

shinyServer(
  function(input, output) {
    sample <- reactive({
      input$Refresh
      corMatrix <- matrix(c(1,input$rho,input$rho,1),2,2)
      sdMatrix <- matrix(c(input$sdX,0,0,input$sdY),2,2)
      Sigma <- sdMatrix %*% corMatrix %*% sdMatrix
      sample <- data.frame(mvrnorm(input$n,c(0,0),Sigma))
      names(sample) <- c('X','Y')
      sample
      })
    mdL <- reactive({lm(sample()[,2] ~ sample()[,1])})

    trueSlope <- reactive({input$rho * (input$sdY/input$sdX)})
    trueIntercept <- reactive({0})
    scatterplot <- reactive({
      
    qplot(sample()[,'X'],sample()[,'Y'], data=sample(), xlab = 'X', ylab = 'Y', main = "Actual (Green Line) vs Estimated (Red Line) ") + geom_abline(intercept = trueIntercept(), slope = trueSlope(), col = "green")+
            geom_abline(intercept = unname(mdL()$coefficients[1]), slope = unname(mdL()$coefficients[2]), col = "red")})

    results <- reactive({data.frame(Parameter = c("Intercept","Slope"),Actual = c(trueIntercept(),trueSlope()),
                        Estimated = c(mdL()$coefficients[1],mdL()$coefficients[2]),row.names = NULL)})

    
    output$plot <- renderPlot({plot(scatterplot())})
    output$result <- renderTable({results()})
    
    
    })

