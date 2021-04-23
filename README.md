
# rgeeExtra

A R package that extends Google Earth Engine. Similar to [eemont](https://github.com/davemlz/eemont)

# How does it work?

The rgeeExtra extends the following Earth Engine classes:

- [ee.Feature](https://developers.google.com/earth-engine/guides/features)
- [ee.FeatureCollection](https://developers.google.com/earth-engine/guides/feature_collections)
- [ee.Geometry](https://developers.google.com/earth-engine/guides/geometries)
- [ee.Image](https://developers.google.com/earth-engine/guides/image_overview)
- [ee.ImageCollection](https://developers.google.com/earth-engine/guides/ic_creating)

rgeeExtra develops and maintains new methods and constructors that extents the most popular GEE classes (See ee$Extra$...). Besides, it supports functional programming (FP) style to make R users feel more comfortable with the API.

The main user-relevant R functions are:
  
  - under dev

The main user-relevant server-side methods are:

  - under dev
  
## Installation

You can install rgeeExtra from [GitHub](https://github.com/r-earthengine/rgeeExtra) with:

``` r
remotes::install_github("r-earthengine/rgeeExtra")
```

## Example

Look at this simple example to estimate the NDVI from a Landsat-8 Surface Reflectance image.

With [**rgee**](https://github.com/r-spatial/rgee):

``` r
library(rgee)

ee_Initialize()

# Define an image.
img <- ee$Image("LANDSAT/LC08/C01/T1_SR/LC08_038029_20180810")$
  normalizedDifference(c("B5", "B4"))$
  pow(2)

Map$centerObject(img,zoom=12)
Map$addLayer(img)
```

With [**rgeeExtra**](https://github.com/r-earthengine/rgeeExtra):

``` r
library(rgee)

ee_Initialize()

img <- ee$Image("LANDSAT/LC08/C01/T1_SR/LC08_038029_20180810")
ndvi <- (img[["B5"]] - img[["B4"]])/(img[["B5"]] + img[["B4"]])**2
names(ndvi) <- "pow_ndvi"

Map$centerObject(img,zoom=12)
Map$addLayer(img)
```
