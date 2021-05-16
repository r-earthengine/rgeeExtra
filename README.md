<h1 align="center">
  <br>
  <a href="https://r-spatial.github.io/rgee/"><img src="https://user-images.githubusercontent.com/16768318/118376965-5f7dca80-b5cb-11eb-9a82-47876680a3e6.png" alt="Markdownify" width="200"></a>
  <a href="http://r-earthengine.github.io/rgeeExtra/"><img src="https://user-images.githubusercontent.com/16768318/118376968-63a9e800-b5cb-11eb-83e7-3f36299e17cb.png" alt="Markdownify" width="200"></a>
  <a href="https://rgeebook.netlify.app/"><img src="https://user-images.githubusercontent.com/16768318/118376966-60aef780-b5cb-11eb-8df2-ca70dcfe04c5.png" alt="Markdownify" width="200"></a>  
  <br>
  rgeeExtra: An Extension for rgee
  <br>
</h1>

<h4 align="center">High-level functions to process spatial and simple Earth Engine objects. Popular Third-party GEE algorithms are re-coded from Javascript and Python to R.</h4>


<p align="center">
<a href="https://colab.research.google.com/github/r-spatial/rgee/blob/examples/rgee_colab.ipynb"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open in Colab" title="Open and Execute in Google Colaboratory"></a>
<a href="https://github.com/r-earthengine/rgeeExtra/actions"><img src="https://github.com/r-earthengine/rgeeExtra/workflows/R-CMD-check/badge.svg" alt="R build status"></a>
<a href="https://www.repostatus.org/#active"><img src="https://www.repostatus.org/badges/latest/active.svg" alt="Project Status: Active – The project has reached a stable, usable
state and is being actively
developed."></a>
<a href="https://codecov.io/gh/r-earthengine/rgeeExtra">
  <img src="https://codecov.io/gh/r-earthengine/rgeeExtra/branch/master/graph/badge.svg?token=Q1SNZZU62W"/>
</a>
<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License"></a>
<a href="https://www.tidyverse.org/lifecycle/#maturing"><img src="https://img.shields.io/badge/lifecycle-maturing-blue.svg" alt="lifecycle"></a>
<br>
<a href="https://joss.theoj.org/papers/aea42ddddd79df480a858bc1e51857fc"><img src="https://joss.theoj.org/papers/aea42ddddd79df480a858bc1e51857fc/status.svg" alt="status"></a>
<a href="https://cran.r-project.org/package=rgeeExtra"><img src="https://www.r-pkg.org/badges/version/rgeeExtra" alt="CRAN
status"></a>
<a href="https://doi.org/10.5281/zenodo.3945409"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.3945409.svg" alt="DOI"></a>
<br>
<a href="https://www.buymeacoffee.com/csay" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
</p>



<p align="center">  
  • 
  <a href="#installation">Installation</a> &nbsp;•    
  <a href="#how-does-it-work">How does it work?</a> &nbsp;•
  <a href="#example">Example</a> &nbsp;•
  <a href="#contributing-guide">Contributing</a> &nbsp;•
  <a href="#share-the-love">Citation</a> &nbsp;•
  <a href="#credits">Credits</a>  
</p>

## What is Google Earth Engine?

[Google Earth Engine](https://earthengine.google.com/) is a cloud-based platform that allows users to have an easy access to a petabyte-scale archive of remote sensing data and run geospatial analysis on Google's infrastructure. Currently, Google offers support only for Python and JavaScript. `rgee` will fill the gap **starting to provide support to R!**. Below you will find the comparison between the syntax of `rgee` and the two Google-supported client libraries.

<table>
<tr>
<th> Python </th>
<th> rgee </th>
<th> rgeeExtra </th>
</tr>
<tr>
<td>
  
``` python
import ee
ee.Initialize()
db = 'CGIAR/SRTM90_V4'
image = ee.Image(db)
image.bandNames().getInfo()
#> [u'elevation']
```

</td>
<td>

``` r
library(rgee)
ee_Initialize()
db <- 'CGIAR/SRTM90_V4'
image <- ee$Image(db)
image$bandNames()$getInfo()
#> [1] "elevation"
```

</td>
<td>

``` r
library(rgee)
library(rgeeExtra)
ee_Initialize()
image <- ee$Image$Dataset$CGIAR_SRTM90_V4
names(image)
#> [1] "elevation"
```
</td>
</tr>
</table>
  
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

## Code of Conduct
  
Please note that the `rgeeExtra` project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

## Contributing Guide

👍 Thanks for taking the time to contribute! 🎉👍 Please review our [Contributing Guide](CONTRIBUTING.md).

## Share the love

Think **rgeeExtra** is useful? Let others discover it, by telling them in person via Twitter or a blog post.

Using **rgeeExtra** for a paper you are writing? Consider citing it

``` r
citation("rgeeExtra")
To cite rgee in publications use:
  
  C Aybar, Q Wu, L Bautista, R Yali and A Barja (2020) rgee: An R
  package for interacting with Google Earth Engine Journal of Open
  Source Software URL https://github.com/r-spatial/rgee/.

A BibTeX entry for LaTeX users is

@Article{,
  title = {rgee: An R package for interacting with Google Earth Engine},
  author = {Cesar Aybar and Quisheng Wu and Lesly Bautista and Roy Yali and Antony Barja},
  journal = {Journal of Open Source Software},
  year = {2020},
}
```


## Credits

We would like to mention the following third-party R/Python packages for contributing indirectly to the improvement of rgeeExtra:
  
-   [**eemont - David Montero Loaiza**](https://github.com/davemlz/eemont)
