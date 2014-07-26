shinyUI(fluidPage(
  titlePanel("regressionVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Show the effect of sample size and correlation on linear regression"),
      
      
      fixedRow(column(5, numericInput("sdX", 
               label = "Input standard deviation of independent variable X", 1.0), offset = 1),
               column(5, numericInput("sdY", 
               label = "Input standard deviation of dependent variable Y", 1.0), offset = 1)),   
      
      sliderInput("rho", 
                  label = "Set Correlation:",
                  min = -1.0, max = 1.0, value = 0.5, step = .05),
    
      sliderInput("n", 
                label = "Set Sample Size:",
                min = 5, max = 300, value = 20, step = 5),
      
      fixedRow(column(4,actionButton("Refresh", label = "ReSample"), offset = 1),
               column(4,submitButton("RePlot"), offset = 0)),
      br(),
      em("Instructions:"),
      p("Select and input values then hit Enter key to plot."),
      p("For fixed input values hit Resample and then Replot to view the resulting new sample."),
      p("Standard deviations must be greater than zero. For values less than 1.0 enter using a leading 0 e.g. 0.3 not .3.")
      
      ),
    
      mainPanel(plotOutput("plot"),
                tableOutput("result")
  )
))
)
