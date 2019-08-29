# geocodr 0.0.0.9000

## Aug 28,2019

The CRAN version of the `ggmap` package does not use a secure (https) request, which prevents the `map_it()` 
function from executing. To solve this, install the most recent version from GitHub by running: `devtools::install_github("dkahle/ggmap")` in your R console.

If you work for a company with a strict firewall, they may automatically block requests to google. This will give you an error like the following: 
```
Error in curl::curl_fetch_memory(url, handle = handle) : 
  Failed to connect to maps.googleapis.com port 443: Timed out
```
To solve this problem, you can use a proxy server to send your requests. It's easy to change the default server to a proxy in R using the `httr` package. 
```{R}
install.packages('httr') # You needn't do this if you already have the package installed
library(httr)
set_config(use_proxy(url="http://[proxy_url]", port = XXX))
```
You'll need to substitute a real url and port. 80 and 443 are the most common ports.

