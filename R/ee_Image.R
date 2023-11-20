#' Citing EE objects in publications
#'
#' If it exists, retrieve the citation of an EE object.
#'
#' @param x An EE object to get the citation from.
#'
#' @name ee$Image$Extra_getCitation(x)
#' @usage `ee$Image$Extra_getCitation()`
#' @family ee_Image
#' @returns A character with citation information.
#'
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_getCitation()
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
#' @usage `ee$Image$Extra_getDOI()`
#' @param x An EE object.
#'
#' @returns A character with DOI information.
#'
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_getDOI()
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
#' @usage `ee$Image$Extra_getOffsetParams()`
#' @returns A list with the offset parameters for each band.
#'
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_getOffsetParams()
#'
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
#' @usage `ee$Image$Extra_getScaleParams()`
#' @returns A list with the scale parameters for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_getScaleParams()
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
#' @usage `ee$Image$Extra_getSTAC()`
#' @returns Return STAC metadata for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_getSTAC() %>%
#'   ee$Image$getInfo()
#' }
ee_Image_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}


#' Adjust the image's histogram to match a target image
#'
#' @usage `ee$Image$Extra_matchHistogram()`
#' @param image ee$Image to adjust.
#' @param target ee$Image image to match.
#' @param bands A dictionary of band names to match, with
#' source bands as keys and target bands as values.
#' @param geometry ee$Geometry. The region to match histograms in that
#' overlaps both images. If none is provided, the geometry of the source
#' image will be used.  Defaults is NULL.
#' @param maxBuckets Integer. The maximum number of buckets to use when building
#' histograms. Will be rounded to the nearest power of 2.  Default to 256.
#'
#' @returns The adjusted image containing the matched source bands.
#'
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
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
#' @usage `ee$Image$Extra_preprocess()`
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_preprocess()
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
#'
#' @param index Character. Default 'NDVI'. Index or list of indices
#' to compute. The available options are:
#'
#' \itemize{
#'  \item \strong{vegetation}: Compute all vegetation indices.
#'  \item \strong{burn}: Compute all burn indices.
#'  \item \strong{water}: Compute all water indices.
#'  \item \strong{snow}: Compute all snow indices.
#'  \item \strong{drought}: Compute all drought indices.
#'  \item \strong{urban}: Compute all urban (built-up) indices.
#'  \item \strong{kernel}: Compute all kernel indices.
#'  \item \strong{all}: Compute all indices listed below.
#' }
#'
#' Check the complete list of indices
#' \href{https://awesome-ee-spectral-indices.readthedocs.io/en/latest/list.html}{here}.
#'
#' @param G Numeric. Gain factor. It must be set if index is 'EVI'. Default 2.5.
#'
#' @param C1 Numeric. Coefficient 1 for the aerosol resistance term. It must be
#' set if index is 'EVI'. Default 6.0.
#'
#' @param C2 Numeric. Coefficient 2 for the aerosol resistance term. It must
#' be set if index is 'EVI'. Default 7.5.
#'
#' @param L  Numeric. Canopy background adjustment. It must be set if index is
#' 'EVI' or 'SAVI'. Default is 1.0.
#'
#' @param cexp Numeric. It must be set if index is 'OCVI'. Default 1.16.
#'
#' @param nexp Numeric. It must be set if index is 'GDVI'. Default 2.0.
#'
#' @param alpha Numeric. Weighting coefficient. It must be set if index is
#' 'WDRVI'. Default is 0.1.
#'
#' @param slope Numeric. Soil line slope. Default is 1.0.
#'
#' @param intercept Numeric. Soil line slope. Default = 0.0.
#'
#' @param gamma Numeric. Weighting coefficient. It must be set if index
#' is 'ARVI'. Default is 1.0.
#'
#' @param kernel Numeric. It must be set in kernel indices. The available
#' options are:
#' \itemize{
#'  \item \strong{linear}: Linear Kernel.
#'  \item \strong{RBF}: Radial Basis Function (RBF) Kernel.
#'  \item \strong{linear}: Polynomial Kernel.
#' }
#' The default kernel is 'RBF'.
#'
#' @param sigma Character or Numeric. Length-scale parameter. It must be set
#' in RBF kernel indices. If character, the expression needs to include 'a'
#' and 'b'. If numeric, it must be positive. Default is '0.5 * (a + b)'.
#'
#' @param p Numeric. Kernel degree. It must be set in polynomial kernel
#' indices ('poly'). Default is 2.0.
#'
#' @param c Numeric. Free parameter that trades off the influence of
#' higher-order versus lower-order terms in the polynomial kernel. It must be
#' set in polynomial kernel indices ('poly'). This must be greater than or equal
#' to 0. Default is 1.0.
#'
#' @param online Logical. Whether to retrieve the most recent list of indices
#' directly from the GitHub repository and not from the local copy. Default is
#' FALSE.
#'
#' @param drop Logical. If TRUE, drop the image bands. Default TRUE.
#'
#' @name ee-spectralindex
#' @usage `ee$Image$Extra_spectralIndex()`
#' @returns An ee$Image or an ee$ImageCollection with the computed spectral
#' index, or indices, as new bands.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' s2_indices <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$preprocess()%>%
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
#' Apply panchromatic sharpening to an ee$Image or an ee$ImageCollection. Optionally,
#' run quality assessments between the original and
#' sharpened Image to measure spectral distortion and set results
#' as properties of the sharpened Image.
#'
#' @param x An ee$Image or an ee$ImageCollection object. The image to sharpen.
#' @param method Character. The sharpening algorithm to apply. Current
#' options are “SFIM” (Smoothing Filter-based Intensity Modulation),
#' “HPFA” (High Pass Filter Addition), “PCS” (Principal Component
#' Substitution), and “SM” (simple mean). Different sharpening
#' methods will produce different quality sharpening results in
#' different scenarios.
#' @param qa Character. One or more optional quality assessment names to
#' apply after sharpening, e.g. “MSE”, “RASE”, “UIQI”, etc.
#' @param ... Keyword arguments passed to ee.Image.reduceRegion() such
#' as “geometry”, “maxPixels”, “bestEffort”, etc. These arguments are
#' only used for PCS sharpening and quality assessments.
#' @return The Image with all sharpenable bands sharpened to the
#' panchromatic resolution and quality assessments run and set
#' as properties.
#' @name ee-pansharpen
#' @usage `ee$Image$Extra_panSharpen()`
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' img <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
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
#' as well as clouds for the Sentinel-3 Radiance product
#' @usage `ee$Image$Extra_maskClouds()`
#' @param image An ee$Image
#' @param method The method to mask clouds. Available
#' options: "cloud_prob" and "qa".
#' @param prob A number between 0 and 100. Cloud probability threshold.
#' Valid just for method = 'cloud_prob'. This parameter is ignored for
#' Landsat products. Default value is 60.
#' @param maskCirrus Logical Whether to mask cirrus clouds.
#' Valid just for method = 'qa'. This parameter is ignored for Landsat
#' products. Default value is TRUE.
#' @param maskShadows Logical. Whether to mask cloud shadows.
#' For more info see 'Braaten, J. 2020. Sentinel-2 Cloud Masking
#' with s2cloudless. Google Earth Engine, Community Tutorials'. Default value
#' is TRUE.
#' @param scaledImage Logical. Whether the pixel values are scaled to the
#' range <0,1> (reflectance values). This parameter is ignored for Landsat products.
#' The default value is FALSE.
#' @param dark : Numerical value between <0-1>. NIR threshold. NIR values below
#' this threshold are potential cloud shadows. This parameter is ignored for
#' Landsat products. Default value is 0.15
#' @param cloudDist Numerical value. Maximum distance in meters (m) to look
#' for cloud shadows from cloud edges. This parameter is ignored for
#' Landsat products. Default value is 1000.
#' @param buffer Numerical value. Distance in meters (m) to dilate cloud and
#' cloud shadows objects. This parameter is ignored for Landsat products. Default
#' value is 250 meters.
#' @param cdi Numerical value between <-1, 1>. Cloud Displacement Index threshold.
#' Values below this threshold are considered potential clouds. A cdi = None means
#' that the index is not used. For more info see 'Frantz, D., HaS, E., Uhl, A.,
#' Stoffels, J., Hill, J. 2018. Improvement of the Fmask algorithm for Sentinel-2
#' images: Separating clouds from bright surfaces based on parallax effects.
#' Remote Sensing of Environment 2015: 471-481'. Default value is NULL.
#'
#' @return  ee.Image with a Cloud-shadow masked image.
#'
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#'
#' ee_Initialize()
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
#' @usage `ee$Image$Extra_tasseledCap()`
#' @param x ee$Image or ee$ImageCollection to calculate tasseled
#' cap components for. Must belong to a supported platform.
#'
#' @return ee$Image  or ee$ImageCollection with the tasseled cap
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
#' library(rgeeExtra)
#'
#' ee_Initialize()
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
#' @usage `ee$Image$Extra_scaleAndOffset()`
#' @return An ee$Image or an ee$ImageCollection with float pixel values.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection("COPERNICUS/S2_SR") %>%
#'   ee$ImageCollection$first() %>%
#'   ee$Image$Extra_scaleAndOffset()
#' }
ee_Image_scaleAndOffset <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$QA$pipelines$scaleAndOffset(
    x = x
  )
}
