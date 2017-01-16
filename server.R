library(shiny)
library(ggplot2)

data(Orange)
data(diamonds)
data(mtcars)

shinyServer(function(input, output) {
  output$varXControls_exp <- renderUI({
    selectInput("varX_exp", "Variable in X axis:", names(get(input$datasets_exp)))
  })
  
  output$varYControls_exp <- renderUI({
    selectInput("varY_exp", "Variable in Y axis:", names(get(input$datasets_exp)))
  })

  output$aestheticsControls_exp <- renderUI({
    if(input$graphic_exp == "sca"){
      selectInput("aesthetics_exp", "Aesthetics attribute:", c("None" = "none", "Colour" = "colour", "Alpha" = "alpha", "Shape" = "shape", "Size" = "size"))
    }
    else if(input$graphic_exp == "box"){
      selectInput("aesthetics_exp", "Aesthetics attribute:", c("None" = "none", "Colour" = "colour", "Fill" = "fill", "Alpha" = "alpha", "Size" = "size"))
    }
    else if(input$graphic_exp == "his"){
      selectInput("aesthetics_exp", "Aesthetics attribute:", c("None" = "none", "Colour" = "colour", "Fill" = "fill", "Alpha" = "alpha", "Line Type" = "linetype", "Size" = "size"))
    }
  })

  output$varAestheticsControls_exp <- renderUI({
    selectInput("varAesthetics_exp", "Aesthetics variable:", names(get(input$datasets_exp)))
  })
  
  output$varFacetControls_exp <- renderUI({
    selectInput("varFacet_exp", "Facet variable:", c("none",names(get(input$datasets_exp))))
  })
  
  output$plot_exp <- renderPlot({
    if(input$graphic_exp == "sca"){
      exploratoryPlot <- ggplot(get(input$datasets_exp), aes(x=get(input$varX_exp), y=get(input$varY_exp))) 
      if(input$aesthetics_exp == "colour"){
        exploratoryPlot <- exploratoryPlot + geom_point(aes(colour=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "alpha"){
        exploratoryPlot <- exploratoryPlot + geom_point(aes(alpha=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "shape"){
        exploratoryPlot <- exploratoryPlot + geom_point(aes(shape=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "size"){
        exploratoryPlot <- exploratoryPlot + geom_point(aes(size=get(input$varAesthetics_exp)))
      }
      else{
        exploratoryPlot <- exploratoryPlot + geom_point()
      }
      if(input$varFacet_exp != "none"){
        exploratoryPlot <- exploratoryPlot + facet_grid(. ~ get(input$varFacet_exp))
      }
      exploratoryPlot <- exploratoryPlot + labs(title=paste("Scatterplot Diagram for",input$datasets_exp, "dataset"), x=input$varX_exp, y=input$varY_exp)
    }
    else if(input$graphic_exp == "box"){
      exploratoryPlot <- ggplot(get(input$datasets_exp), aes(x=get(input$varX_exp), y=get(input$varY_exp))) 
      if(input$aesthetics_exp == "colour"){
        exploratoryPlot <- exploratoryPlot + geom_boxplot(aes(colour=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "fill"){
        exploratoryPlot <- exploratoryPlot + geom_boxplot(aes(fill=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "alpha"){
        exploratoryPlot <- exploratoryPlot + geom_boxplot(aes(alpha=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "linetype"){
        exploratoryPlot <- exploratoryPlot + geom_boxplot(aes(size=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "size"){
        exploratoryPlot <- exploratoryPlot + geom_boxplot(aes(size=get(input$varAesthetics_exp)))
      }
      else{
        exploratoryPlot <- exploratoryPlot + geom_boxplot()
      }
      
      if(input$varFacet_exp != "none"){
        exploratoryPlot <- exploratoryPlot + facet_grid(. ~ get(input$varFacet_exp))
      }
      exploratoryPlot <- exploratoryPlot + labs(title=paste("Boxplot Diagram for",input$datasets_exp, "dataset"), x=input$varX_exp, y=input$varY_exp)
    }
    else if(input$graphic_exp == "his"){
      exploratoryPlot <- ggplot(get(input$datasets_exp), aes(x=get(input$varX_exp))) 
      if(input$aesthetics_exp == "colour"){
        exploratoryPlot <- exploratoryPlot + geom_histogram(aes(colour=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "fill"){
        exploratoryPlot <- exploratoryPlot + geom_histogram(aes(fill=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "alpha"){
        exploratoryPlot <- exploratoryPlot + geom_histogram(aes(alpha=get(input$varAesthetics_exp)))
      }
      else if(input$aesthetics_exp == "size"){
        exploratoryPlot <- exploratoryPlot + geom_histogram(aes(size=get(input$varAesthetics_exp)))
      }
      else{
        exploratoryPlot <- exploratoryPlot + geom_histogram()
      }

      if(input$varFacet_exp != "none"){
        exploratoryPlot <- exploratoryPlot + facet_grid(. ~ get(input$varFacet_exp))
      }
      exploratoryPlot <- exploratoryPlot + labs(title=paste("Histogram for",input$datasets_exp, "dataset"), x=input$varX_exp)
    }
    exploratoryPlot
  })

  output$outcomeControls_pre <- renderUI({
    selectInput("outcome_pre", "Outcome variable:", names(get(input$datasets_pre)))
  })
  
  output$predictorControls_pre <- renderUI({
    selectInput("predictor_pre", "Predictor variable:", names(get(input$datasets_pre)))
  })

  output$plot_pre <- renderPlot({
    regressionPlot <- ggplot(get(input$datasets_pre), aes(x=get(input$predictor_pre), y=get(input$outcome_pre))) 
    regressionPlot <- regressionPlot + geom_point(shape=1)
    regressionPlot <- regressionPlot + geom_smooth(method=lm)
    regressionPlot <- regressionPlot + labs(title=paste("Regression line for",input$datasets_pre, "dataset"), x=input$predictor_pre, y=input$outcome_pre)
    regressionPlot
  })
})