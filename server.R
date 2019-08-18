library(shiny)
library(DT)
library(ggplot2)
library(RColorBrewer)
library(viridis)
library(tidycensus)
library(tigris)
library(sf)
library(stringr)
library(magrittr)
library(dplyr)
options(tigris_use_cache = TRUE, scipen = 8)

# install census key
census_api_key("4ad70a5edc3991700f1eb1f25b63a843bf13af18")

shinyServer(function(input, output) {

    # dynamic UI for census data
    output$year_dynamic <- renderUI({
        if(input$survey == 'SF-1'){
            opts = c(1990, 2000, 2010)
        }
        else if (input$survey == 'SF-3'){
            opts = c(1990, 2000)
        }
        else if(input$survey == 'ACS-5'){
            opts = 2009:2017
        }
        else if(input$survey == 'ACS-1'){
            opts = 2010:2017
        }
        pickerInput("year", "Year", opts, opts[-1])
    })
    
    output$geog_dynamic <- renderUI({
        if(input$state == "All States"){
            pickerInput("geography", "Geography", c("State", "County"), "State")
        }else if(input$survey %in% c('SF-1', 'SF-3')){
            pickerInput("geography", "Geography", c("County", "Tract"), "County") # currently disabled , "Block"
        }else{
            pickerInput("geography", "Geography", c("County", "Tract"), "County")
        }
    })
    
    # dynamic variables and table
    survey_vars <- reactive({
        dset <- switch(input$survey, "SF-1" = "sf1", "SF-3" = "sf3", "ACS-5" = "acs5", "ACS-1" = "acs1")
        vars <- tidycensus::load_variables(input$year, dset, cache = TRUE)
        return(vars)
    })
    
    output$census_dt <- DT::renderDataTable({
                            datatable(survey_vars(),
                                      options = list(dom = 'lftipr',
                                                     pagelength = 25,
                                                     lengthMenu = c(25,50,100))
                            )
                        })
    
    
    # dynamic ggplot map
    gg <- eventReactive(input$map, {
        # print just geography if no measurement
        if(input$query == ""){
            ggplot() + 
                geom_sf(data = geog_dict(input$geography, input$state)) +
                theme_void()
        }else{
        
            q <- parse_query(input$query, input$survey)
            
            # choose all states
            if(input$state == "All States"){
                state <- NULL
            } else{
                state <- input$state
            }
            
            
            # by survey
            if(input$survey %in% c("SF-1", "SF-3")){
                if(is.null(state)){
                    if(input$geography == "State"){
                        data <- left_join(state_laea, get_decennial(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide"), by = "GEOID")
                    }else if(input$geography == "County"){
                        data <- left_join(county_laea, get_decennial(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide"), by = "GEOID")
                    }
                }else{
                data <- get_decennial(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide", geometry = TRUE)
                }
            }
            else{
                if(is.null(state)){
                    if(input$geography == "State"){
                        data <- left_join(state_laea, get_acs(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide"), by = "GEOID")
                    }else if(input$geography == "County"){
                        data <- left_join(county_laea, get_acs(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide"), by = "GEOID")
                    }
                }else{
                    data <- get_acs(tolower(input$geography), variables = q$variables, year = as.numeric(input$year), state = state, output = "wide", geometry = TRUE)
                }
                    names(data) %<>% gsub("E","",.) # get rid of the Estimate 'E' in the var names
            }
            
            # make the calculation
            eval(parse(text = q$calculation))
        
            # make the plot
            gg = ggplot() +
                geom_sf(data = data, mapping = aes_string(fill = q$name), col = NA) +
                theme_void()
            
            # choose a color ramp
            if(input$color %in% c("Viridis", "Magma", "Plasma", "Inferno", "Cividis")){
                gg = gg + scale_fill_viridis(option = tolower(input$color), guide = guide_colorbar(ticks = FALSE))
            }
            else{
                gg = gg + scale_fill_distiller(palette = input$color, guide = guide_colorbar(ticks = FALSE))
            }
                
            return(gg)
        }
    })
    
    # render, but if null then use states
    output$census_map <- renderPlot({
        if(input$map == 0){
            ggplot() +
                geom_sf(data = state_laea) +
                theme_void()
        }else{
            gg()
        }
    })
    
})
