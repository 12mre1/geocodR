#' \code{gcode_one} Geocodes a single address using ggmap
#'
#' @details This function geocodes an address, returning a vector of information
#' containing latitude, longitude and full address.Google's API does not allow more
#' than 50 req/sec, so I force a pause of 1/40 of a sec just to be safe.
#'
#' @param address A single character object. The address to be geocoded.
#'
#' @return Returns a three element vector: c(lat,long, full_address)
#'
#'
gcode_one <- function(address) {
  # Since it's good practice to space requests, i'll force a pause
  Sys.sleep(0.025)
  #Geocode the address
  response <- ggmap::geocode(address, output = "latlona")
  # If the response is as expected, collect the data
  lat <- as.numeric(response[1])
  lng <- as.numeric(response[2])
  full_address <- as.character(response[3])
  # return information as a vector
  return(c(lat,lng,full_address))

}
