
# start coding the user interface with the fluid page design
ui <- shinyUI(
  fluidPage(
    # header panel with fluidRow-design    
    fluidRow(
      # dividing header panel in two columns      
      # column one contains the title
      column(width = 10, # width of first column 
             style = "font-size: 25pt; line-height: 40pt; width = 100", # font size etc.
             tags$strong("Median House Sale Prices in Texas State")) # "tags" is for using html-functions within the shiny app
    ),
    sidebarPanel(style = "background-color: #78d9c9;", # choose background color
                 tags$style(type='text/css', #  css-style to the lists of selected categories and the dropdown menu  
                            ".selectize-input { font-size: 12pt; line-height: 13pt;} 
                            .selectize-dropdown { font-size: 12pt; line-height: 13pt; }"),
                 width = 3, # set panel width
                 
                 # the cities are to be selected by clicking checkboxes AND it should be possible to freely select different groups
                 checkboxGroupInput("city", # name of this input to access it later in the server part
                                    label = HTML('<p style="color:white; font-size: 12pt"> Cities </p>'), # title of input menu with html style
                                    choices = cities, # adopt the choices to be displayed from our ordered "cities"- vector
                                    selected = "Abilene"), # make all cities to the default selected
                 helpText(HTML('<p style="color:white; font-size: 9pt">choose cities by clicking the check boxes</p>'))
                 ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Graphic", # name as displayed on the tab
                           plotOutput("mplot"), # name of output you'll use in the server part 
                           style = "width:100%"), 
                  tabPanel("Data", 
                           htmlOutput("text"), 
                           tableOutput("table"), 
                           style = "font-size:70%", htmlOutput("datasource"))
      )
    )
  ))