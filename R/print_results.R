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
  return(df)
}
