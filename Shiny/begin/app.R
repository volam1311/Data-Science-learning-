#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("What is this cool UI?"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            radioButtons(
                "variablechoice",
                "Choice of variables",
                choices=c("Waiting Time", "Eruption Time"),
                selected = "Waiting Time"
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           verbatimTextOutput("summaryofvariable"),
           plotOutput("scatterss")
        )
        # The order in the mainPanel will show the order that the elements is placed on the UI
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        if (input$variablechoice == "Waiting Time") {
            x <- faithful[,2]
        }
        if (input$variablechoice == "Eruption Time") {
            x <- faithful[,1]
        }
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = paste('Histogram of ', input$variablechoice))
    })
    output$summaryofvariable <- renderPrint({
        
        if (input$variablechoice == "Waiting Time") {
          x <- faithful[,2]
        }
        if (input$variablechoice == "Eruption Time") {
          x <- faithful[,1]
        }
      summary(x)
      }
    )
    output$scatterss <- renderPlot({
      y <- faithful$eruptions
      x <- faithful$waiting
      plot(y~x, xlab="Waiting Time", ylab="Eruption Time")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
