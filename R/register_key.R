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
  ggmap::register_google(key = KEY)
}
