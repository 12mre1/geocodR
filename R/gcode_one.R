#' \code{gcode_one} Geocodes a single address using ggmap
#'
#' @details This function geocodes an address, returning a vector of information
#' containing latitude, longitude and full address.Google's API does not allow more
#' than 50 req/sec, so I force a pause of 1/40 of a sec just to be safe.
#'
#' @param address A single character object. The address to be geocoded.
#'
#' @importFrom ggmap geocode
#'
#' @return Returns a three element vector: c(lat,long, full_address)
#'
#'
gcode_one <- function(address) {
  # Since it's good practice to space requests, i'll force a pause
  Sys.sleep(0.025)
  #Geocode the address
  tryCatch({
    response <- ggmap::geocode(address, output = "latlona")
    # If the response is as expected, collect the data
    lat <- as.numeric(response[1])
    lng <- as.numeric(response[2])
    full_address <- as.character(response[3])
    # return information as a vector
    return(c(lat,lng,full_address))
    }, error = function(e){
      print(e)
      message('The address was too vague for Google to return a single reference point')
      return(c(NA,NA,NA))
    }, warning = function(w){
      print(w)
      return(c(NA,NA,NA))
  })
}
