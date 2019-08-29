#' @importFrom readr write_csv
#' \code{write_to_file} - Writes a dataframe as a CSV file.
#' 
#' @param df The dataframe to write.
#' 
#' @param name The name of the output file, as a character object. If a file path is not given, 
#' The function assumes cwd.
#' 
write_to_file <- function(df, name){
  write_csv(df,name)
}