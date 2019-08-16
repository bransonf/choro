library(shiny)
library(DT)
library(ggplot2)
library(RColorBrewer)
library(viridis)
library(tidycensus)
library(tigris)

# install census key
census_api_key("4ad70a5edc3991700f1eb1f25b63a843bf13af18")

shinyServer(function(input, output) {

    # dynamic UI for census data
    
        # select region first
         # conus by default
    
        region <- "conus"
        
    
        #
    
        # if year, survey
        # load and offer those variables
    
        # user select and defines those
    
    
    output$census_map <- renderPlot(plot(state_laea))
    
    output$census_dt <- DT::renderDataTable(data.frame(c(1,2,3), c(1,2,3)))
    
    output$custom_map <- renderPlot(plot(state_laea))
    
    output$custom_dt <- DT::renderDataTable(data.frame(c(1,2,3), c(1,2,3)))
})
