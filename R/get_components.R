#' \code{get_components} A function that appends separate components, like postal code and province, as new variables
#' to a geocoded df.
#'
#' @details The function extracts the postal code (and later the province) from the full address
#' column of the input dataframe. It appends these components to the df as separate variables, and
#' returns a new dataset
#'
#' @param df A dataframe object with at least one column that contains the full addresses from which
#' components are extracted.
#'
#' @return A dataframe with full address and components (postal code, prov,..) and potentially other
#' data.
#'
#' @import magrittr
#'
#' @export
#'
#' @examples \dontrun{
#' get_components(coded)
#' }
get_components <- function(df) {
  get_comp_one <- function(address){
    postal_code <- stringr::str_extract(address, "[A-Za-z][0-9][A-Za-z][ -]?[0-9][A-Za-z][0-9]")
    return(postal_code)
  }
  new_col <- apply(df['full_address'],get_comp_one, MARGIN = 1)
  new_col <- as.data.frame(new_col)
  # print(new_col)
  df %>%
    cbind(new_col) %>%
    dplyr::rename('postal_code' = 'new_col') %>%
    return()
}
