library(shiny)

shinyUI(fluidPage(
  titlePanel("Data Science Dashboard"),
  p("This application contains two tabs. The tab /Exploratory Analysis/ allows some basic data exploratory analysis providing three datasets (Orange, 
    diamonds and mtcars) along with three different types of graphics to try with (Scatterplot, Boxplot and Histogram)."),
  p("The tab /Regression Model/ performs a linear regression with the selected combination of predictor and outcome from the dataset selected ((Orange, 
    diamonds and mtcars)."),
  tabsetPanel(
    tabPanel("Exploratory Analysis",  
      sidebarLayout(
        sidebarPanel(
          selectInput("datasets_exp", "Dataset to use:", c("Orange" = "Orange", "Diamonds " = "diamonds", "Cars" = "mtcars")),
          selectInput("graphic_exp", "Graphic to use:", c("Scatterplot" = "sca", "Boxplot" = "box", "Histogram" = "his")),
          uiOutput("varXControls_exp"),
          conditionalPanel(
            condition = "input.graphic_exp != 'his'",
            uiOutput("varYControls_exp")
          ),
          strong("Instructions:", style = "color:blue"),
          p("Select a dataset to use and the graphic that will be shown for data analysis. Then the variable used in the X and Y axis are selected (Histogram only has X)."),
          p("On the right side a plot is shown with some options available. An aesthetic attribute can be used (depending on the graphic type) and a existing variable to provide the 
            value for it. Facet is also available, being the graphic split by the variable selected.")
        ),
        mainPanel(
            textOutput("warning_mes_exp"), #In RED
            plotOutput("plot_exp"),
            br(),
            fluidRow(
              column(3,
                     uiOutput("aestheticsControls_exp")
              ),
              column(3,
                     uiOutput("varAestheticsControls_exp")
              ),
              column(3,
                   uiOutput("varFacetControls_exp")
              )
            )
        )
      )
  ),
  
  tabPanel("Regression Model",  
  
      sidebarLayout(
        sidebarPanel(
          selectInput("datasets_pre", "Dataset to use:", c("Orange" = "Orange", "Diamonds " = "diamonds", "Cars" = "mtcars")),
          uiOutput("outcomeControls_pre"),
          uiOutput("predictorControls_pre"),
          strong("Instructions:", style = "color:blue"),
          p("Select a dataset to use. Then the variable used for the predictor and the outcome are selected."),
          p("On the right side a plot is shown with a regression line with the predictor and outcom already selected.")
        ),
        mainPanel(
          plotOutput("plot_pre")
        )
      )
  )
)
))