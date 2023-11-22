#' Citing EE objects in publications
#'
#' If it exists, retrieve the citation of an EE object.
#'
#' @param x An EE object to get the citation from.
#' @name ee-citation
#' @usage `ee$Image$Extra_getCitation(x)`
#' @returns A character with citation information.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#' 
#' # Retrieve citation for the first image in NASA's IMERG V06 collection
#' citation <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>% 
#'   ee$Image$Extra_getCitation()
#' 
#' # Display the citation
#' citation
#' 
#' # Fetching NASA/GPM_L3/IMERG_V06 image collection and retrieving its citation.
#' citation_ <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$Extra_getCitation()
#' 
#' # Display the citation
#' citation_
#' }

ee_image_getCitation <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getCitation(x = x)
}


#' Get the Digital Object Identifier (DOI) of an EE object
#'
#' If it exists, retrieve the DOI of an EE object.
#'
#' @name ee-getdoi
#' @usage `ee$Image$Extra_getDOI(x)`
#' @param x An EE object to get the DOI from.
#'
#' @returns A character with DOI information.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#' 
#' # Fetch DOI for first image in NASA IMERG V06 collection
#' doi <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>% 
#'   ee$Image$Extra_getDOI()
#'
#' doi 
#' 
#' # Retrieve and print the DOI for the NASA/GPM_L3/IMERG_V06 image collection.
#' doi_ <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$Extra_getDOI()
#' 
#' doi_
#' }
ee_image_getDOI <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getDOI(x = x)
}


#' Retrieve offset parameter from EE Image and EE ImageCollections objects
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee$Image$getOffsetParams or
#' ee$ImageCollection$getOffsetParams retrieve the offset parameter
#' for each band of an ee$Image.
#'
#' @param x An ee$Image or an ee$ImageCollection object.
#' @name ee-getoffset
#' @usage `ee$Image$Extra_getOffsetParams(x)`
#' @returns A list with the offset parameters for each band.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' # Retrieve offset parameters from the first image in NASA IMERG V06 collection
#' offset_params <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>%
#'   ee$Image$Extra_getOffsetParams()
#' 
#' # Display offset parameters for each band.
#' offset_params
#'
#' # Get offset parameters from NASA IMERG V06 image collection.
#' offset_params_ <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$Extra_getOffsetParams()
#' 
#' # Display offset parameters for each band.
#' offset_params_
#' }
ee_Image_getOffsetParams <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getOffsetParams(x = x)
}


#' Retrieve scale parameter from EE Image and EE ImageCollection objects.
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee$Image$getScaleParams and
#' ee$ImageCollection$getScaleParams retrieve the scale parameter
#' for each band of an ee$Image.
#'
#' @param x An ee$Image.or an ee$ImageCollection object.
#' @name ee-getscaleparams
#' @usage `ee$Image$Extra_getScaleParams(x)`
#' @returns A list with the scale parameters for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#' 
#' # Retrieve scale parameters from the first image in NASA IMERG V06 collection
#' scale_params <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>%
#'   ee$Image$Extra_getScaleParams()
#' 
#' # Display scale parameters for each band in the image.
#' scale_params
#' 
#' # Retrieve scale parameters for the NASA IMERG V06 collection.
#' scale_params_ <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$Image$Extra_getScaleParams()
#' 
#' # Display scale parameters for each band in the image.
#' scale_params_
#' }
ee_Image_getScaleParams <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getScaleParams(x = x)
}


#' Retrieve EE Image or EE ImageCollection STAC metadata
#'
#' Get the STAC of an ee$Image or ee$ImageCollection object.
#'
#' @param x An ee$Image or an ee$ImageCollection object.
#' @name ee-getstac
#' @usage `ee$Image$Extra_getSTAC(x)`
#' @returns Return STAC metadata for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' # Retrieve STAC metadata for the first image in NASA's GPM L3 IMERG V06 collection
#' stac_metadata <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>%
#'   ee$Image$Extra_getSTAC()
#' 
#' stac_metadata
#' 
#' # Retrieve STAC metadata from NASA's IMERG V06 image collection.
#' stac_metadata_ <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$Extra_getSTAC()
#' 
#' stac_metadata_
#' }
ee_Image_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}


#' Adjust the image's histogram to match a target image
#'
#' Matches the histogram of one image (source) to that of another image (target).
#'
#' @param x ee$Image to adjust.
#' @param ... Additional arguments for histogram matching.
#' See details for more information.
#'
#' @details
#' The `...` argument can include the following:
#' \itemize{
#'   \item{target}{ee$Image. The target image to match.}
#'   \item{bands}{Dictionary. Band names to match, with source bands as keys and target bands as values.}
#'   \item{geometry}{ee$Geometry. The region to match histograms in that overlaps both images. Default is NULL.}
#'   \item{maxBuckets}{Integer. The maximum number of buckets to use when building histograms. Default 256.}
#' }
#' These parameters allow for detailed customization of the histogram matching process.
#'
#' @return The adjusted image containing the matched source bands.
#'
#' @usage `ee$Image$Extra_matchHistogram(x, ...)`
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' source <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
#' target <-ee$Image("LANDSAT/LE07/C01/T1_TOA/LE07_046027_20150701")
#' bands <- list("B4"="B3", "B3"="B2", "B2"="B1")
#'
#' matched <- ee$Image$Extra_matchHistogram(source, target, bands)
#'
#' names(matched)
#' }
ee_Image_matchHistogram <- function(image, target, bands, geometry=NULL, maxBuckets=256) {
  #_matchHistogram(self, target, bands, geometry, maxBuckets)
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$Spectral$core$matchHistogram(
    source=image,
    target=target,
    bands=bands,
    geometry=geometry,
    maxBuckets=maxBuckets
  )
}


#' Automated EE Image or EE ImageCollection preprocessing
#'
#' Preprocessing of ee$Image or ee$ImageCollection objects. This
#' function performs the following tasks:
#' \itemize{
#'  \item \strong{Cloud Masking}: Remove cloud and cloud shadow pixels.
#'  See ee$Image$cloudmask.
#'  \item \strong{Decompress}: Convert integer pixels to float point numbers.
#' }
#'
#' @param x An ee$Image or an ee$ImageCollection object.
#' @param ... Arguments to pass to ee$Image$cloudmask.
#' @name ee-preprocess
#' @usage `ee$Image$Extra_preprocess(x, ...)`
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' # Load a Sentinel-2 image and apply automated preprocessing.
#' img <- ee$Image("COPERNICUS/S2_SR/20170328T083601_20170328T084228_T35SQA") %>%
#'   ee$Image$Extra_preprocess()
#' 
#' # Load and preprocess Sentinel-2 SR image collection.
#' ic <- ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$Extra_preprocess()
#' }
#' @return An ee$Image or ee$ImageCollection object
ee_Image_preprocess <- function(x, ...) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$QA$pipelines$preprocess(x, ...)
}


#' Spectral Indices Computation
#'
#' Computes one or more spectral indices for an ee$Image or an ee$ImageCollection object.
#'
#' @param x An ee$Image or an ee$ImageCollection to compute indices on.
#' @param ... Additional arguments passed to the underlying spectral index
#' computation function. See details for a complete list of possible arguments.
#'
#' @details
#' The `...` argument can include any of the following:
#' \itemize{
#'   \item{index}{Character. Index or list of indices to compute. Options include 'vegetation', 'burn',
#'   'water', 'snow', 'drought', 'urban', 'kernel', and 'all'. Default 'NDVI'.}
#'   \item{G}{Numeric. Gain factor for 'EVI'. Default 2.5.}
#'   \item{C1, C2}{Numerics. Coefficients for aerosol resistance in 'EVI'. Defaults are 6.0 and 7.5.}
#'   \item{L}{Numeric. Canopy background adjustment for 'EVI' or 'SAVI'. Default 1.0.}
#'   \item{cexp}{Numeric. Coefficient for 'OCVI'. Default 1.16.}
#'   \item{nexp}{Numeric. Exponent for 'GDVI'. Default 2.0.}
#'   \item{alpha}{Numeric. Weighting coefficient for 'WDRVI'. Default 0.1.}
#'   \item{slope, intercept}{Numerics. Soil line slope and intercept. Defaults are 1.0 and 0.0.}
#'   \item{gamma}{Numeric. Weighting coefficient for 'ARVI'. Default 1.0.}
#'   \item{kernel}{Character. Kernel type for kernel indices. Options are 'linear', 'RBF', and 'poly'. Default 'RBF'.}
#'   \item{sigma}{Character or Numeric. Length-scale parameter for RBF kernel. Default '0.5 * (a + b)'.}
#'   \item{p}{Numeric. Kernel degree for polynomial kernel. Default 2.0.}
#'   \item{c}{Numeric. Free parameter for polynomial kernel. Default 1.0.}
#'   \item{online}{Logical. Whether to retrieve the most recent list of indices online. Default FALSE.}
#'   \item{drop}{Logical. If TRUE, drop the image bands after calculation. Default TRUE.}
#' }
#' For a complete list of indices and their parameters, please refer to the
#' \href{https://awesome-ee-spectral-indices.readthedocs.io/en/latest/list.html}{spectral indices documentation}.
#'
#' @return An ee$Image or an ee$ImageCollection with the computed spectral
#' index, or indices, as new bands.
#'
#' @usage `ee$Image$Extra_spectralIndex(x, ...)`
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' s2_indices <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$preprocess() %>%
#'   ee$Image$Extra_spectralIndex(c("NDVI", "SAVI"))
#'
#' names(s2_indices)
#' # "NDVI" "SAVI"
#' }
ee_Image_spectralIndex <- function(
  x,
  index = "NDVI",
  G = 2.5,
  C1 = 6.0,
  C2 = 7.5,
  L = 1.0,
  cexp = 1.16,
  nexp = 2.0,
  alpha = 0.1,
  slope = 1.0,
  intercept = 0.0,
  gamma = 1.0,
  kernel = "RBF",
  sigma = "0.5 * (a + b)",
  p = 2.0,
  c = 1.0,
  online = FALSE,
  drop = TRUE
) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$Spectral$core$spectralIndices(
    x = x, index = index, G = G, C1 = C1, C2 = C2, L = L,
    cexp = cexp, nexp = nexp, alpha = alpha, slope = slope,
    intercept = intercept, gamma = gamma, kernel = kernel, sigma = sigma,
    p = p, c = c, online = online, drop = drop
  )
}




#' Apply panchromatic sharpening to an ee$Image or an ee$ImageCollection
#'
#' Apply panchromatic sharpening to an ee$Image. Optionally,
#' run quality assessments between the original and
#' sharpened Image to measure spectral distortion and set results
#' as properties of the sharpened Image.
#'
#' @param x An ee$Image object, the image to sharpen.
#' @param ... Additional arguments including sharpening method, quality 
#' assessments, and parameters for `ee.Image.reduceRegion()`. 
#' See details for more information.
#'
#' @details
#' The `...` argument can include the following:
#' \itemize{
#'   \item{method}{Character. The sharpening algorithm to apply. Options include “SFIM”, 
#'   “HPFA”, “PCS”, and “SM”. Default is “SFIM”.}
#'   \item{qa}{Character. One or more quality assessment names to apply after sharpening, 
#'   such as “MSE”, “RASE”, “UIQI”, etc.}
#'   \item{geometry, maxPixels, bestEffort, etc.}{Arguments passed to `ee.Image.reduceRegion()` 
#'   during PCS sharpening and quality assessments.}
#' }
#' For the PCS method, additional parameters for `ee.Image.reduceRegion()` can be specified, 
#' such as `geometry`, `maxPixels`, `bestEffort`, etc.
#'
#' @return The Image with all sharpenable bands sharpened to the
#' panchromatic resolution and quality assessments run and set
#' as properties.
#' @name ee-pansharpen
#' @usage `ee$Image$Extra_panSharpen(x, ...)`
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' img <- ee$Image("LANDSAT/LC09/C02/T1_TOA/LC09_047027_20230815")
#' img_sharp <- ee$Image$Extra_panSharpen(img, method="HPFA", qa=c("MSE", "RMSE"), maxPixels=1e13)
#'
#' Map$centerObject(img)
#' Map$addLayer(img_sharp, list(bands=c("B4", "B3", "B2"))) |
#' Map$addLayer(img, list(bands=c("B4", "B3", "B2")))
#' }
ee_Image_panSharpen <- function(x, method="SFIM", qa = "MSE", ...) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$Algorithms$panSharpening$'_panSharpen'(
      img = x,
      method = method,
      qa = qa,
      ...
  )
}


#' Masks clouds and shadows
#'
#' Masks clouds and shadows in an ee.Image. Valid just for
#' Surface Reflectance products. This function may mask water
#' as well as clouds for the Sentinel-3 Radiance product.
#'
#' @param x An ee$Image to be processed for cloud and shadow masking.
#' @param ... Additional arguments for cloud and shadow masking.
#' See details for more information.
#'
#' @details
#' The `...` argument can include the following:
#' \itemize{
#'   \item{method}{Character. The method to mask clouds. Options: "cloud_prob" and "qa".}
#'   \item{prob}{Numeric. Cloud probability threshold, between 0 and 100. Valid for 'cloud_prob' method. Default 60.}
#'   \item{maskCirrus}{Logical. Whether to mask cirrus clouds. Valid for 'qa' method. Default TRUE.}
#'   \item{maskShadows}{Logical. Whether to mask cloud shadows. Default TRUE.}
#'   \item{scaledImage}{Logical. If TRUE, scale pixel values to <0,1>. Default FALSE.}
#'   \item{dark}{Numeric. NIR threshold for potential cloud shadows, between 0-1. Default 0.15.}
#'   \item{cloudDist}{Numeric. Max distance in meters to search for cloud shadows from cloud edges. Default 1000m.}
#'   \item{buffer}{Numeric. Distance in meters to dilate cloud and shadow objects. Default 250m.}
#'   \item{cdi}{Numeric. Cloud Displacement Index threshold, between <-1, 1>. Default NULL.}
#' }
#' For more information on parameters and methods, refer to relevant cloud masking literature and tutorials.
#'
#' @return ee$Image with a Cloud-shadow masked image.
#'
#' @usage `ee$Image$Extra_maskClouds(x, ...)`
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' img <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_maskClouds(prob = 75,buffer = 300,cdi = -0.5)
#'
#' names(img)
#' }
ee_Image_maskClouds <- function(
    image,
    method="cloud_prob",
    prob=60,
    maskCirrus=TRUE,
    maskShadows=TRUE,
    scaledImage=FALSE,
    dark=0.15,
    cloudDist=1000,
    buffer=250,
    cdi=NULL
  ) {
    EEextra_PYTHON_PACKAGE <- load_ee_Extra()
    EEextra_PYTHON_PACKAGE$QA$clouds$maskClouds(
      x = image,
      method = method,
      prob = prob,
      maskCirrus = maskCirrus,
      maskShadows = maskShadows,
      scaledImage = scaledImage,
      dark = dark,
      cloudDist = cloudDist,
      buffer = buffer,
      cdi = cdi
    )
}


#' Calculates tasseled cap brightness, wetness, and greenness
#' components for an EE Image or EE ImageCollection
#'
#' Tasseled cap transformations are applied using coefficients
#' published for these supported platforms:
#' \itemize{
#'    \item{1.} Sentinel-2 MSI Level 1C  (1)
#'    \item{2.} Landsat 9 OLI-2 SR  (2)
#'    \item{3.} Landsat 9 OLI-2 TOA  (2)
#'    \item{4.} Landsat 8 OLI SR  (2)
#'    \item{5.} Landsat 8 OLI TOA  (2)
#'    \item{6.} Landsat 7 ETM+ TOA  (3)
#'    \item{7.} Landsat 5 TM Raw DN  (4)
#'    \item{8.} Landsat 4 TM Raw DN  (5)
#'    \item{9.} Landsat 4 TM Surface Reflectance  (6)
#'    \item{10.} MODIS NBAR  (7)
#' }
#' @usage `ee$Image$Extra_tasseledCap(x)`
#' @param x ee$Image to calculate tasseled
#' cap components for. Must belong to a supported platform.
#'
#' @return ee$Image with the tasseled cap
#' components as new bands.
#'
#' @details
#'
#' \itemize{
#'    \item{1.} Shi, T., & Xu, H. (2019). Derivation of Tasseled Cap Transformation
#'    Coefficients for Sentinel-2 MSI At-Sensor Reflectance Data. IEEE Journal
#'    of Selected Topics in Applied Earth Observations and Remote Sensing, 1–11.
#'    doi:10.1109/jstars.2019.2938388
#'    \item{2.} Zhai, Y., Roy, D.P., Martins, V.S., Zhang, H.K., Yan, L., Li, Z. 2022.
#'    Conterminous United States Landsat-8 top of atmosphere and surface reflectance
#'    tasseled cap transformation coefficeints. Remote Sensing of Environment,
#'    274(2022). doi:10.1016/j.rse.2022.112992
#'    \item{3.} Huang, C., Wylie, B., Yang, L., Homer, C. and Zylstra, G., 2002.
#'    Derivation of a tasselled cap transformation based on Landsat 7 at-satellite
#'    reflectance. International journal of remote sensing, 23(8), pp.1741-1748.
#'    \item{4.} Crist, E.P., Laurin, R. and Cicone, R.C., 1986, September. Vegetation
#'     and soils information contained in transformed Thematic Mapper data. In
#'     Proceedings of IGARSS’86 symposium (pp. 1465-1470). Paris: European Space
#'     Agency Publications Division.
#'    \item{5.} Crist, E.P. and Cicone, R.C., 1984. A physically-based transformation
#'    of Thematic Mapper data---The TM Tasseled Cap. IEEE Transactions on Geoscience
#'    and Remote sensing, (3), pp.256-263.
#'    \item{6.} Crist, E.P., 1985. A TM tasseled cap equivalent transformation for
#'    reflectance factor data. Remote sensing of Environment, 17(3), pp.301-306.
#'    \item{7.} Lobser, S.E. and Cohen, W.B., 2007. MODIS tasselled cap: land cover
#'    characteristics expressed through transformed MODIS data. International
#'    Journal of Remote Sensing, 28(22), pp.5079-5101.
#' }
#' @name ee-tasseledcap
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' img <- ee$Image("LANDSAT/LT05/C01/T1/LT05_044034_20081011")
#' img <- ee$Image$Extra_tasseledCap(img)
#' names(img)
#' }
ee_Image_tasseledCap <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$Spectral$core$tasseledCap(x = x)
}


#' Automatic decompression of EE Image or EE ImageCollection objects
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee$Image$scaleAndOffset or
#' ee$ImageCollection$scaleAndOffset backs the integer pixel values to
#' float point number.
#'
#' @family calibration
#' @param x  An ee$Image or an ee$ImageCollection object.
#' @name ee-scaleandoffset
#' @usage `ee$Image$Extra_scaleAndOffset(x)`
#' @return An ee$Image or an ee$ImageCollection with float pixel values.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' # Adjust first image in NASA IMERG V06 for scale and offset.
#' adjusted_image <- ee$ImageCollection("NASA/GPM_L3/IMERG_V06")[[1]] %>%
#'   ee$Image$Extra_scaleAndOffset()
#' 
#' # Adjust Sentinel-2 SR images for scale and offset.
#' adjusted_images <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
#'   ee$ImageCollection$Extra_scaleAndOffset()
#' }
ee_Image_scaleAndOffset <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$QA$pipelines$scaleAndOffset(
    x = x
  )
}
