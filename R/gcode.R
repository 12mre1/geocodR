#' \code{gcode} Geocodes a dataframe of addresses using Google Maps API via ggmap
#'
#' @details The function takes a single-column dataframe of addresses. It then
#' geocodes those addresses, returning a new dataframe with additional columns for latitude,
#' longitude and full address. Postal code can also be included as a separate column.
#'
#' @param df A single-column dataframe of addresses.
#'
#' @param components Logical. Postal code is included if \code{components = TRUE}. Defaults to FALSE.
#'
#' @param infile The file name or path of the input csv. Used as the base to which reference
#' coordinates are appended
#'
#' @return A dataframe object with initial address, lat, long and full address. Postal code may
#' also be included.
#'
#' @importFrom magrittr "%>%"
#'
#' @importFrom dplyr rename
#'
#' @importFrom rlang .data
#'
#' @export
#'
#' @examples \dontrun{
#' test_str <- head(test,3)
#'
#' gcode(test_str, components = TRUE)
#' }
gcode <- function(df, infile, components = FALSE){
  in_df <- readr::read_csv(file = infile, col_names = TRUE)
  # Transpose the resulting dataframe before assigning it
  out <- t(apply(df,gcode_one, MARGIN = 1))
  in_df %>% cbind(out) %>%
    rename("latitude" = "1","longitude" = "2", "full_address" = "3") %>%
    {if(components) get_components(.data) else .data} %>%
    return()
  # View()
}
