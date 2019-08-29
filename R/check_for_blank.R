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
