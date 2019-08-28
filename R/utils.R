#####################################################################################
################################ UTILITY FUNCTIONS ##################################
#####################################################################################

# Author: Matthew Edwards
# Package: geocodr


#' \code{check_for_blank} Check to make sure there are no blank addresses in the address
#' column of the input file. 
#' 
#' @details The API query will throw an error and stop the geocoding 
#' process for the whole file if a URL is constructed with a blank address.This function 
#' prevents wasted queries (only so many are allowed at no charge) by throwing an error
#' that tells the user to fix blank addresses.
#' 
#' @param addresses The dataframe column containing the addresses.
#' 
#' @return Simply return the input addresses if there are no blanks.
#' 
#' @examples \dontrun{
#' check_for_blank(df['Business Address'])
#' }
#' 
check_for_blank <- function(addresses){
  if(sum(is.na(addresses)) > 0){
    stop('make sure there are no blank addresses')
  }
  return(addresses)
}



#' \code{remove_weird_characters} Removes certain characters from entries in the address column.
#' 
#' @details Some characters, like '#', '\', or '.' can throw off Google's API when included in the 
#' http request, since they serve specific purposes in dividing the URL. To avoid error, this 
#' function removes those special characters.
#' 
#' @param addresses The dataframe column containing the addresses.
#' 
#' @return returns the input dataframe column with special characters replaced by whitespace
#' 
#' @examples \dontrun{
#' remove_weird_characters(as.data.frame("720 Bathurst St #411, Toronto, ON M5S 2R4"))
#' remove_weird_characters(data['address'])
#' }

remove_weird_characters <- function(addresses){
  clean_one_address <- function(address){
    clean <- gsub('[#\\.\\+]',' ',address)
    return(clean)
  } 
  fixed <- as.data.frame(apply(addresses, MARGIN = 1, clean_one_address))
  return(fixed)
}



#' \code{print_results} Print the number of successful geocoded addresses to console.
#' The output will tell you how many addresses were in the CSV file, and how many were
#' successfully coded. 
#' 
#' @param df A dataframe object containing the input file contents. If the file does
#' not exist, the function returns an error.
#' 
#' @return The function displays messages, but does not return anything explicitly.
#' 
#' @examples \dontrun{
#' print_results(coded)
#' }
#'  

print_results <- function(df){
  false_count <- sum(is.na(df['latitude']))
  # If all addresses are geocoded, this is a non-issue
  if(false_count > 0){
    message(paste('Although you input a csv with ',as.character(nrow(df[lat_column])), ' addresses,',
                  'only ', as.character(nrow(df[lat_column]) - false_count), 
                  ' of them could be successfully geocoded.'))
    message('You will probably have to fill in missing values by hand :(')
  } 
  if(false_count == 0){
    message('All addresses successfully geocoded')
  }
}