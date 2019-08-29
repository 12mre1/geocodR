

# geocodr
<!-- badges: start -->
<!-- badges: end -->
## Basic overview
In almost every mapping project, one of the most important steps is converting address data into coordinates 
so that mapping software can plot them on the Earth's surface. The process of converting addresses into reference
coordinates (typcally latitude and longitude) is called __geocoding__. There are several great commercial APIs for 
doing exactly that, but even so I find myself often writing similar code to manipulate different datasets.

  GeocodR is an attempt to fully automate this process using batch conversion through the `ggmap` package. The user
 can simply input a csv file with the addresses requiring conversion, identify in which column those addresses
 are located and specify a name for the output file. The program will geocode the addresses, append the latitude, longitude and full address in three additional columns, and return the new dataset as a csv beside the input file. The package also allows for the postal codes to be listed as a separate variable in the output.
 
## Contents
1. [Installation](#Installation-Instructions)
2. [Details](#Details)
3. [Limitations](#Limitations)
4. [Google's API](#A-Note-About-Google-API-Features)
5. [Future Work](#Future-Work)

## Installation Instructions
The package is designed to work in R or RStudio (I am personally a big fan of the latter). If you do not have R, you can download it [here](https://www.r-project.org/), and RStudio can be downloaded [here](https://www.rstudio.com/products/rstudio/). Both are free.

Once you open R or RStudio, type the following into the console to install the package:
```
devtools::install_github('12mre1/geocodr', build_vignettes = TRUE)
```

If that doesn't work (for example if you have limited connection or a strong firewall), you may get the following error:
```
Error: Failed to install 'unknown package' from GitHub:
  Timeout was reached: Connection timed out after 10014 milliseconds
```
In that case, try downloading the repo and installing locally:
    1. Download the zip file and unzip it
    2. In RStudio, run `devtools::install('C:\\Users\\matthew.edwards\\Downloads\\geocodr-master.zip\\geocodr-master', build_vignettes = TRUE)`
    (Your file path would be different, but the double backslashes matter)

Once the package is installed, you should see:
```
* DONE (geocodr)
In R CMD INSTALL
```
Just load it into namespace:
```
library(geocodr)
```
After you have it installed, I highly recommend you read the vignette, which is a walkthrough of a specific example.
```
browseVignettes('geocodr')
vignette('basic_example')
```
## Details
 
 Virtually every reputable mapping API requires the user to register and obtain an application key that must
 be included in the URL during the HTTP request. This is so the company can track usage, but is also useful 
 for billing purposes. That is still true in this package (though I wish it were not), where the key (or for 
 privacy reasons a text file containing that key) is passed as an argument.
 
 Here is an example of the http request sent to API: </br>
 https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
 
 - The map of Canada in the background to plot geocoded points was obtained from [Exploratory](https://exploratory.io/map).

## Limitations
- For now, the only choice of input or output is a csv file. I may change this in future.
- Partial or ambiguous addresses that would normally return a menu of choices in your browser will 
return `NA` when the response provides multiple options. It is better to have exact addresses to reduce the likelihood of this 
happening.
- The package only allow for forward geocoding. Reverse geocoding (latlong to address) is not yet possible.
- The only choice of output is a csv file (will change this in future)

## A Note About Google API Features
As of 2018, GoogleMaps requires all users to pass a key in each request. You can register for an API key 
[here](https://developers.google.com/maps/documentation/geocoding/start).

The google servers limit geocoding requests to 50 per second, which means you cannot fully parallelize a 
list of addresses. This function will take a bit longer, but overall, this shouldn't be too much of
a burden. If you find that most of your requests return `NA`, it's likely you're hitting Google's
API rate limit. Google no longer has any daily rate limit.

A couple of other comments:
- Google Maps API does have their own JavaScript and Python clients, if you prefer to convert yourself in one of 
these languages (you still need that same API key)

- You get one free request, then you have to move to a pay-as-you-go plan

- To register for the API key, you must provide billing info and agree to the Google Maps 
__Terms of Service__

- They have tiered pricing structures:
    - 0-100,000 per month: 0.005 USD per request
    - 100,001-500,000 per month: 0.004 USD per request
    - 500,000+ per month: Contact them
    
 Requests are calculated as the sum of client and server side queries.
 - Google gives all users $300 in free credit, which is good for 60,000 requests under tier 1 pricing
 - Any more and you'll have to pay
 - Google asks for your credit card info to defend against bots, but will not charge you without your permission
 
 Note that Google's __Terms of Service__ requires that any geocoding results be used to map with google map, 
 so in future I'll implement a small map generator to satisfy this requirement.


## Future Work

Although the current version of this package adds substantial value, there are other improvements i'd like to 
implement in the future. The following list is not necessarily exhaustive:
- __Remove Blanks__: For now, the main function does not execute properly if some entries in the address column are blank. This needs to be fixed ASAP.
 - __Reverse Geocoding__: This first version allows for addresses to be converted to long/lat, but not the 
 reverse process. That should be changed going forward.
 - __Partial Addresses__: Google Maps API is already capable of finding partial addresses, but cases here assume
 that the first search result is the correct one. With a partial address, the API might return multiple options, 
 and this tool only ever assumes that the first choice is the correct one.
 - __Alternate Outputs__: It would be nice if the results could be output into other (non-csv) formats, like
 JSON or GeoJSON. Many open source mapping softwares take as inputs these types of files.
 - __Generate a Map with Coordinates__: Google's terms of service require that geocoded points be used on google's 
 maps. I should have a simple pop-up map with the correctly coded points to give the user an initial picture, and
 satisfy these requirements.
 - __Auto-identify Addresses__: It would be nice if you didn't have to specify which column contains the addresses.
 A simple regex search may be able to identify them automatically.
 - __Additional Components__: Right now, the only component (additional variable beyond lat,long and address) is the postal code. In future I'd like to enable the option of generating Province and Province code too.



