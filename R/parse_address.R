source('utils.R')



#' @import magrittr
#' @importFrom dplyr select
#' @importFrom readr read_csv
#' 
#'  \code{get_addresses} Identifies the address column in a csv file, and returns it as a
#' data frame object.
#' 
#' @param infile A csv file to read as a character object. If in your cwd, you needn't specify
#' the filepath. If not, the file path should be attached.
#' 
#' @param address_column A character object. The name of the column containing the addresses.
#' 
#' @return Returns the address column as a dataframe object.
#' 
#' @examples \dontrun{
#' get_addresses('F:/gitrepos/R-sandbox/pei-test.csv','Business Address')
#' 
#' test <- get_addresses("pei_test.csv", address_column = "Business Address")
#' }
 
get_addresses <- function(infile,address_column = "address"){
  data <- read_csv(infile, col_names = TRUE)
  data %>%
    dplyr::select(address_column) %>%
    as.data.frame()
}


# This function registers the api key (only needed once to geocode)
#' @importFrom ggmap register_google
#' 
#' \code{register_key} Register's your API key needed to geocode. If the key is not registered, 
#' The geocoding functions will throw errors.
#' 
#' @param api_key The api key, as a character object.
#' 
#' @examples \dontrun{
#' register_key('ASnERN405060i7NDNS') # This key is fictional
#' }

register_key <- function(api_key){
  #read in the API key 
  KEY <- api_key
  # Register key
  register_google(key = KEY)
}


KEY = "AIzaSyBNbV3WdlnSxcRI7-6-_arNOqMylVm-tBM"


# Convert JSON object to nested lists for slicing
# response_to_json <- function(http_response){
#   out_json <- fromJSON(http_response, simplify = FALSE)
#   return(out_json)
# }


#' @importFrom ggmap geocode
#' 
#' \code{gcode_one} Geocodes a single address using ggmap
#' 
#' @details This function geocodes an address, returning a vector of information
#' containing latitude, longitude and full address.Google's API does not allow more 
#' than 50 req/sec, so I force a pause of 1/40 of a sec just to be safe.
#' 
#' @param address A single character object. The address to be geocoded.
#' 
#' @return Returns a three element vector: c(lat,long, full_address)
#' 
#' 
gcode_one <- function(address) {
  # Since it's good practice to space requests, i'll force a pause
  Sys.sleep(0.025)
  #Geocode the address
  response <- geocode(address, output = "latlona")
  # If the response is as expected, collect the data
  lat <- as.numeric(response[1])
  lng <- as.numeric(response[2])
  full_address <- as.character(response[3])
  # return information as a vector
  return(c(lat,lng,full_address))
  
}



# Grab the components of the address and make them separate columns
library(stringr)
get_components <- function(df) {
  get_comp_one <- function(address){
    postal_code <- str_extract(address, "[A-Za-z][0-9][A-Za-z][ -]?[0-9][A-Za-z][0-9]")
    return(postal_code)
  }
  new_col <- apply(df['full_address'],get_comp_one, MARGIN = 1)
  new_col <- as.data.frame(new_col)
  # print(new_col)
  df %>%
    cbind(new_col) %>%
    rename('postal_code' = 'new_col') %>%
    return()
}






library(ggmap)

# This function will geocode your entire dataframe column
gcode <- function(df, components = FALSE){
  # Transpose the resulting dataframe before assigning it
  out <<- t(apply(df,gcode_one, MARGIN = 1))
  df %>% cbind(out) %>% 
    rename("latitude" = "1","longitude" = "2", "full_address" = "3") %>%
    {if(components) get_components(.) else .} %>%
    return()
    # View()
}

# gcode_one(address = ADDRESS, key = KEY)
# test_str <- head(test,3)
# 
# gcode(test_str, components = TRUE)

# start_time <- Sys.time()
# coded <- gcode(test)
# end_time <- Sys.time()
# 
# print(end_time - start_time)
# 
# 
# get_components(full_ad_test)





# Map the results to a google map
library(ggplot2)
library(ggmap)
map_it <- function(df,background_map = 'Canada',lat = 'latitude',lon = 'longitude'){
  bg <- get_map(background_map)
  ggmap(bg) + 
    geom_point(data = coded,aes(x = lon, y = lat)) +
    theme_void()
}  

# Write to file
library(readr)
write_to_file <- function(df, name){
  write_csv(df,name)
}








# final function
library(tidyverse)
geocodR <- function(in_csv, api_key, address_col, out_file = "./output.csv", 
                    bg_map = 'Canada', components = FALSE){
  register_key(api_key)
  get_addresses(infile = in_csv,address_column = address_col) %>%
    check_for_blank() %>%
    remove_weird_characters() %>%
    gcode(components) %>% ## gcode uses the complex assignment operator to instantiate out
    write_to_file(name = out_file)
}

## Test it yourself ###  
geocodR(in_csv = 'yk_test.csv', api_key = KEY, address_col = 'Business Address', components = FALSE)
geocodR(in_csv = 'organizations.csv', api_key = KEY, address_col = 'address', components = TRUE)