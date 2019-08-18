# global shiny functions

# create a data cache of survey variables and all geometries... server side.
cache <- function(){
for (i in c(1990, 2000, 2010)) {
  for(j in c("sf1", "sf3")){
    if (j == "sf3" && i == 2010) next
    load_variables(i, j, cache = TRUE)
  }
}
for (i in 2009:2017) {
  load_variables(i, "acs5", cache = TRUE)
}
for (i in 2010:2017) {
  load_variables(i, "acs1", cache = TRUE)
}
}
cache()



# ui button for downloading tables
downloadTable <- function(){
  
}

# custom download button
downloadImage <- function(outputId, label = "Save Image", class = NULL, ...){
  aTag <- tags$a(id = outputId, class = paste("btn btn-default shiny-download-link", 
                                              class), href = "", target = "_blank", download = NA, 
                 icon("image"), label, ...)
}

# ui button for sending map request
mapButton <- function(){
  
}

# parse queries made as equations
parse_query <- function(q, survey){
  # get new variable name
  newVar <- str_extract(q, "[:alnum:]{1,}")
  noname <- str_remove(q, "[:alnum:]{1,}")
  
  # get all of the variable names out first
  if(survey %in% c("SF-1", "SF-3")){
    regex = "[:alnum:]{7}"
  }
  else{
    regex = "[:alnum:]{6}[:punct:]{1}[:digit:]{3}"
  }
  vars <- unlist(str_extract_all(noname, pattern = regex))
  
  # evaluate the expression in a mutate call
  calc = paste0("data %<>% mutate(",q,")")
  
  return(list(name = newVar, variables = vars, calculation = calc))
}

# dictionary for picking geometries for mapping
geog_dict <- function(geography, region){
  
  if(region == "All States"){
    if(geography == "State"){
      return(tidycensus::state_laea)
    }else if(geography == "County"){
      return(tidycensus::county_laea)
    }
  }else{
    if(geography == "County"){
      return(tigris::counties(region, class = 'sf'))
    }else if(geography == "Tract"){
      return(tigris::tracts(region, class = 'sf'))
    }else if(geography == "Block"){
      return(tigris::blocks(region, class = 'sf'))
    }
  }
  
}

