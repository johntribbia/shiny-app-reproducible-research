# start coding the server part
server <- shinyServer(function(input, output) {
  # reactive operations
  data <- reactive({
    
    validate( # error message, if no input is selected
      need(input$city != "", "Please select at least one city")
    )
    # filter data for plot dependending on reactive data input with the filter()-function of dplyr
    plotdata <- txhousing  %>%
      as.data.frame() %>%
      # the content of "input$city" changes whenever the user changes the input
      filter(city %in% input$city ) 
    
    # important: make a list of the reactive results to be used for building the outputs
    list(plotdata = plotdata)
  })
  # build the plot
  output$mplot <- renderPlot({
    plot <- ggplot(data = data()$plotdata, aes(date, y = median)) + 
      geom_point(aes(color = city)) + 
      xlab("Date") + 
      ylab("Median House Sale Price") +
      theme_minimal() +
      ggtitle("Scatterplot of Median House Sale Price by City in Texas State\n") +
      guides(fill=guide_legend(title="Cities", reverse = T)) +
      theme(plot.title=element_text(family="Arial", face="bold", size=18),
            axis.text.x = element_text(angle = 0, family="Arial", size=13), 
            axis.text.y = element_text(angle = 0, family="Arial", size=13),
            axis.title.x = element_text(size=14, face="bold", vjust = -1),
            axis.title.y = element_text(size=14, face="bold", vjust = 2)
      )
    
    
    print(plot)
  })
  output$table <- renderTable({
    txhousing %>%
      filter(city %in% input$city)
  })
  output$datasource <- renderUI({
    tags$div(
      tags$strong("Source:"), 
      tags$a("TAMU Real Estate Center", href="http://recenter.tamu.edu/")
    )   
  })
  output$text <- renderUI({
    tags$div(
      HTML('<p style="color:black; font-size: 9pt">This data represents information about the housing market in Texas provided by the TAMU real estate center. 
           The data frame contains 8602 observations and 9 variables: city Name of MLS area, year,month,date Date,sales Number of sales
           volume Total value of sales, median Median sale price, listings Total active listings, inventory "Months inventory": 
           amount of time it would take to sell all current listings at current pace of sales.</p>')
      )   
  })
  })