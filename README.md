<h1 align="center">
  <a href="https://r-spatial.github.io/rgee/">
    <img src="https://user-images.githubusercontent.com/16768318/118376965-5f7dca80-b5cb-11eb-9a82-47876680a3e6.png" width="200"/>
  </a> 
  <a href="https://r-earthengine.com/rgeeExtra/">
    <img src="https://user-images.githubusercontent.com/16768318/118376968-63a9e800-b5cb-11eb-83e7-3f36299e17cb.png" width="200"/>
  </a> 
  <a href="https://r-earthengine.com/rgeebook/">
    <img src="https://user-images.githubusercontent.com/16768318/118376966-60aef780-b5cb-11eb-8df2-ca70dcfe04c5.png" width="200"/>
  </a> 
  <br>rgeeExtra: An Extension for rgee<br>
</h1>

<h4 align="center"> 
  Simplifies the interaction with the GEE API making it more R-like. Popular third-party GEE algorithms are made available to R users
</h4>

<p align="center">
  <a href="https://colab.research.google.com/github/r-spatial/rgee/blob/examples/rgee_colab.ipynb">
    <img src="https://colab.research.google.com/assets/colab-badge.svg" title="Open and Execute in Google Colaboratory" alt="Open in Colab"/>
  </a>
  <a href="https://www.repostatus.org/#active">
    <img src="https://www.repostatus.org/badges/latest/active.svg" alt="Project Status: Active – The project has reached a stable, usable state and is being actively developed."/>
  </a>
  <a href="https://codecov.io/gh/csaybar/rgeeExtra">
    <img src="https://codecov.io/gh/csaybar/rgeeExtra/branch/master/graph/badge.svg"/>
  </a> <a href="https://opensource.org/licenses/Apache-2.0">
    <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License"/>
  </a>
  <a href="https://www.tidyverse.org/lifecycle/#maturing">
    <img src="https://img.shields.io/badge/lifecycle-maturing-blue.svg" alt="lifecycle"/>
  </a>
  <a href="https://joss.theoj.org/papers/aea42ddddd79df480a858bc1e51857fc">
    <img src="https://joss.theoj.org/papers/aea42ddddd79df480a858bc1e51857fc/status.svg" alt="status"/>
  </a>
  <a href="https://cran.r-project.org/package=rgeeExtra">
    <img src="https://www.r-pkg.org/badges/version/rgeeExtra" alt="CRAN status"/>
  </a>
  <a href="https://doi.org/10.5281/zenodo.3945409">
    <img src="https://zenodo.org/badge/DOI/10.5281/zenodo.3945409.svg" alt="DOI"/>
  </a>
  <a href="https://github.com/r-earthengine/rgeeExtra/actions/workflows/R-CMD-check.yaml">
    <img src="https://github.com/r-earthengine/rgeeExtra/actions/workflows/R-CMD-check.yaml/badge.svg"/>
  </a>
</p>

<p align="center">
  • <a href="#installation-">Installation</a>
  • <a href="#how-does-it-work%EF%B8%8F-">How does it work?</a>
  • <a href="#example-">Example</a>
  • <a href="#code-of-conduct-">Code of conduct</a>
  • <a href="#contributing-guide-">Contributing</a>
  • <a href="#share-the-love-%EF%B8%8F">Citation</a>
  • <a href="#credits-">Credits</a>
</p>

## **Why rgeeExtra is needed?** 🤔

The goal of rgeeExtra is to enhance the user experience ⚡ of Google Earth Engine (GEE) 🌐 for R enthusiasts by simplifying its syntax. While GEE's primary language is JavaScript, which diverges from R's structure, rgeeExtra serves as a bridge 🌉, offering R users a suite of tools and functions to navigate GEE's complexity with ease. This extension elevates R interaction with GEE through high-level 📈 abstractions and tailored functions, all adapted from the JavaScript API.

<table>
<tr>
<th style="text-align: center;"> Python (ee) </th>
<th style="text-align: center;"> R (rgee) </th>
<th style="text-align: center;"> R (rgee + rgeeExtra) </th>
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
extra_Initialize()

image <- ee$Image$Dataset$CGIAR_SRTM90_V4
names(image)
#> [1] "elevation"
```
</td>
</tr>
</table>

## **Installation** 🚀

You can install rgeeExtra from [GitHub](https://github.com/r-earthengine/rgeeExtra) with:

``` r
remotes::install_github("r-earthengine/rgeeExtra")
```

For additional details on connecting GEE and R, refer to the documentation provided [here](https://github.com/r-spatial/rgee#installation). To set up an account, click [here](https://earthengine.google.com/signup/).

## **How does it work?️** 🛠

The rgeeExtra extends the following Earth Engine classes:

-   [ee\$Geometry](https://developers.google.com/earth-engine/guides/geometries)
-   [ee\$Feature](https://developers.google.com/earth-engine/guides/features)
-   [ee\$FeatureCollection](https://developers.google.com/earth-engine/guides/feature_collections)
-   [ee\$Image](https://developers.google.com/earth-engine/guides/image_overview)
-   [ee\$ImageCollection](https://developers.google.com/earth-engine/guides/ic_creating)

rgeeExtra develops and maintains new methods and constructors that extend the most popular GEE classes (e.g., `ee$Feature$Extra\_...`). All third-party methods implemented by rgeeExtra start with `Extra\_.` To learn more about all the functionalities that rgeeExtra offers, please refer to the article [Features](https://r-earthengine.com/rgeeExtra/articles/) for additional information.

## **Example** 💡

Look at this simple example to estimate the NDVI from a Landsat-8 Surface Reflectance image.

With [**rgee**](https://github.com/r-spatial/rgee):

``` r
# Load 'rgee' and initialize GEE
library(rgee)
ee_Initialize()

# Compute squared NDVI from Landsat 8 image
img <- ee$Image("LANDSAT/LC08/C02/T1_L2/LC08_007067_20140822")$
  normalizedDifference(c("SR_B5", "SR_B4"))$
  pow(2)

# Visualize squared NDVI on map
Map$centerObject(img)
Map$addLayer(
  eeObject = img, 
  visParams = list(
    min = 0, 
    max = 0.2, 
    palette = c("brown", "yellow", "green")
    ),
  name = "Squared NDVI")
```

With [**rgeeExtra**](https://github.com/r-earthengine/rgeeExtra):

``` r
# Load 'rgee' and initialize GEE
library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

# Compute squared NDVI from Landsat 8 image
img <- ee$Image("LANDSAT/LC08/C02/T1_L2/LC08_007067_20140822")
ndvi <- ((img[["SR_B5"]] - img[["SR_B4"]]) / (img[["SR_B5"]] + img[["SR_B4"]])) ** 2
names(ndvi) <- "NDVI"

# Visualize squared NDVI on map
Map$centerObject(ndvi)
Map$addLayer(
  eeObject = ndvi, 
  visParams = list(
    min = 0, 
    max = 0.2, 
    palette = c("brown", "yellow", "green")
    ),
  name = "Squared NDVI"
  )
```

<center><img src="inst/ndvi_example.png" width="80%"/></center>

## **Code of Conduct** 📜

Please note that the `rgeeExtra` project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

## **Contributing Guide** 🤝

👍 Thanks for taking the time to contribute! 🎉👍 Please review our [Contributing Guide](CONTRIBUTING.md).

## **Share the love** ❤️

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

## **Credits** 👏

We would like to mention the following third-party R/Python packages for contributing indirectly to the improvement of rgeeExtra:

-   [**eemont - David Montero Loaiza**](https://github.com/davemlz/eemont)
