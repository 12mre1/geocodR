#' \code{geocodr} This function batch geocodes csv files with the help of the ggmap package,
#' which uses the Google Maps API
#'
#' @details The function takes as input a csv file, one column of which contains addresses. The
#' addresses are geocoded, with lat and long appended as separate columns in the dataframe. Postal
#' code can also be added separately if the user specifies \code{components = TRUE}. The resulting
#' dataframe is written to an output csv file beside the input file.
#'
#' @param in_csv A character object. The name of the input CSV file with a column of addresses.
#' If the full path is not given, the function assumes the file is in cwd
#'
#' @param api_key A character object. The API key provided by Google Maps API. Geocoding will not
#' work without it.
#'
#' @param address_col A character object containing the name of the address column in the input file.
#'
#' @param bg_map A character object. The background map that will be pulled from Google Maps to
#' plot the geocoded points. Defaults to 'Canada'.
#'
#' @param out_file A character object. The desired name of the output CSV file.
#' If the full path is not given, the function puts the file in cwd.
#'
#' @param components Logical. If TRUE, the postal code will be included as a separate variable in
#' the output file. Defaults to \code{FALSE}.
#'
#' @importFrom magrittr "%>%"
#' @importFrom ggmap register_google
#'
#' @export
#'
#' @examples \dontrun{
#' geocodr(in_csv = 'yk_test.csv', api_key = KEY, address_col = 'Business Address', components = FALSE)
#' geocodr(in_csv = 'organizations.csv', api_key = KEY, address_col = 'address', components = TRUE)
#' }
geocodr <- function(in_csv, api_key, address_col, out_file = "./output.csv",
                    bg_map = 'Canada', components = FALSE){
  suppressWarnings(requireNamespace(ggmap))
  ggmap::register_google(key = api_key, write=TRUE)
  get_addresses(infile = in_csv,address_column = address_col) %>%
    check_for_blank() %>%
    remove_weird_characters() %>%
    gcode(components) %>%
    print_results() %>% # This is why print_results returns the original object
    write_to_file(name = out_file)
}

