library(shiny)
library(DT)
library(shinyWidgets)
source('copy.R')

shinyUI(navbarPage(HTML("<div><img src='conus.png' height='24px'> Choro</div>"), theme = "bootstrap.css", windowTitle = "Choro Mapping",
    tabPanel("Instructions", icon = icon('book'),
        titlePanel("Mapping Census Data"),
        fluidRow(
            column(12,
                instruction_copy
            )
        )
    ),
    tabPanel("Census Map", icon = icon('map-pin'),
        titlePanel('Create a Choropleth Map'),
        fluidRow(
            column(3,
                   pickerInput("survey", "Pick A Survey", c("SF-1", "SF-3", "ACS-5", "ACS-1"), "SF-1"),
                   uiOutput('year_dynamic'),
                   pickerInput("state", "Region", c("All States", state.name), "All States", options = list(`live-search` = TRUE)),
                   uiOutput('geog_dynamic'),
                   textInput("query", "Calculation", ""),
                   pickerInput('color', 'Color Scale', choices = list(
                       Viridis = c("Viridis", "Magma", "Plasma", "Inferno", "Cividis"),
                       ColorBrewer = c("YlOrRd", "YlOrBr", "YlGnBu", "YlGn", "Reds", "RdPu", "Purples", "PuRd", "PuBuGn", "PuBu", "OrRd", "Oranges", "Greys", "Greens", "GnBu", "BuPu", "BuGn", "Blues")
                                                                 )
                   ),
                   actionButton("map", "Generate Map", icon('map'))
                   #downloadImage("dl_map", label = "Download Image", inline = TRUE)
            ),
            column(9,
                   plotOutput("census_map")
            )
            #downloadTable()
        ),
        fluidRow(
            column(12,
                HTML("</br>"),
                dataTableOutput("census_dt", width = '100%')
            )
        )
    )
    
))
