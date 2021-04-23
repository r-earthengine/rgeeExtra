<h1 align="center">
  <br>
  <a href="http://r-earthengine.github.io/"><img src="https://user-images.githubusercontent.com/16768318/115897667-f340f880-a45c-11eb-9f82-096e4ec99818.png" alt="Markdownify" width="200"></a>
  <br>
  <h3 align="center">
    An R package that extends Google Earth Engine
  </h3>
  <br>
</h1>

<p align="center">  
  • 
  <a href="#installation">Installation</a> &nbsp;•    
  <a href="#how-does-it-work">How does it work?</a> &nbsp;•
  <a href="#example">Example</a> &nbsp;•
  <a href="#credits">Credits</a>  
</p>
  
## Installation

You can install rgeeExtra from [GitHub](https://github.com/r-earthengine/rgeeExtra) with:

``` r
remotes::install_github("r-earthengine/rgeeExtra")
```

## How does it work?

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

## Credits

We would like to mention the following third-party R/Python packages for contributing indirectly to the improvement of rgeeExtra:
  
-   [**eemont - David Montero Loaiza**](https://github.com/davemlz/eemont)
