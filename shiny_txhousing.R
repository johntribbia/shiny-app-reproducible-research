library(ggplot2)
library(dplyr)
library(readxl)
library(tidyr)
library(shiny)

# load data
data(txhousing)

# set order for appearance of the cities with a vector called "cities"
cities <- sort(unique(txhousing$city))

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)