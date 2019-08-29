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
