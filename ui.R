library(shiny)
library(DT)
library(shinyWidgets)

shinyUI(navbarPage("Choro",
    tabPanel("Instructions", icon = icon('book'),
        titlePanel("How to Map"),
        h3("Mapping Census Data"),
        h3("Using Your Own Data"),
        "In order to use your own data, it needs to be arranged in a specific way. Currently, the following file formats are supported:
        .shp/.dbf
        .geojson/.json
        "
    ),
    tabPanel("Census Map", icon = icon('map'),
        titlePanel('Create a Choropleth Map'), # Center this
        fluidRow(
            column(3,
                   numericInput("year", label = "Year", min = 2000, max = 2017, step = 1, value = 2017),
                   pickerInput("survey", "Survey", c("Deccenial", "ACS-5", "ACS-3", "ACS-1"), "Deccenial"),
                   pickerInput("state", "Region", c("All States", state.name), "All States"),
                   pickerInput("geography", "Geography", c("State", "County", "Tract", "Block"), "State"),
                   "Select A Variable or Define One",
                   textInput("query", "Measurement", ""),
                   "Control Parameters",
                   
                   "Choose a Breaks System",
                   
                   "Choose a Color Palette",
                   
                   "Custom Title and Legend Options",
                   
                   "Submit button",
                   
                   "Map Button",
                   
                   "Download Button"
                   
            ),
            column(9, plotOutput("census_map")),
            dataTableOutput("census_dt"),
             "Download Button..."
        )
    ),
    # tabPanel("Custom Map", icon = icon('map', "r"),
    #     titlePanel('Create a Choropleth Map'),
    #     fluidRow(
    #          column(3,
    #             fileInput("shape_ul", "Upload a Shape"),
    #             fileInput("data_ul", "Upload Data"),
    #             "Control Parameters",
    #             "Select A Variable",
    #             "Choose a Breaks System",
    #             "Choose a Color Palette",
    #             "Custom Title and Legend Options",
    #             "Submit button",
    #             
    #             "Map Button",
    #             "Download Button"
    #             
    #          ),
    #          column(9, plotOutput("custom_map")),
    #          dataTableOutput("custom_dt")
    #     )
    # )
    
    
))
