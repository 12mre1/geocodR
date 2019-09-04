#' \code{get_addresses} Identifies the address column in a csv file, and returns it as a
#' data frame object.
#'
#' @param infile A csv file to read as a character object. If in your cwd, you needn't specify
#' the filepath. If not, the file path should be attached.
#'
#' @param address_column A character object. The name of the column containing the addresses.
#'
#' @return Returns the address column as a dataframe object.
#'
#' @importFrom magrittr "%>%"
#'
#' @importFrom dplyr select
#'
#' @importFrom readr read_csv
#'
#' @examples \dontrun{
#' get_addresses('F:/gitrepos/R-sandbox/pei-test.csv','Business Address')
#'
#' test <- get_addresses("pei_test.csv", address_column = "Business Address")
#' }

get_addresses <- function(infile,address_column = "address"){
  in_df <<- readr::read_csv(infile, col_names = TRUE)
  in_df %>%
    dplyr::select(address_column) %>%
    as.data.frame()
}
