#' FMASK Cloud Masking
#'
#' Masks clouds and shadows in an image collection (valid just for Surface
#' Reflectance products). This method may mask water as well as clouds for
#' the Sentinel-3 Radiance product.
#'
#' @param x ee$Image or ee$ImageCollection.
#' @param method Character. Method used to mask clouds. The available options
#' are:
#' \itemize{
#'   \item \strong{cloud_prob}: Use cloud probability.
#'   \item \strong{qa}: Use Quality Assessment band.
#' }
#' Default 'cloud prob'. Ignore for Landsat products.
#'
#' @param prob Numeric from 0 to 100. Cloud probability threshold.
#' Valid just for method = 'cloud_prob'. Ignore for Landsat products.
#' Default 60.
#'
#' @param maskCirrus Logical. Whether to mask cirrus clouds. Valid just for
#' method = 'qa'. Ignore for Landsat products. Default TRUE.
#'
#' @param maskShadows Logical. Whether to mask cloud shadows. For more info
#' see 'Braaten, J. 2020. Sentinel-2 Cloud Masking with s2cloudless. Google
#' Earth Engine, Community Tutorials'. Default TRUE.
#'
#' @param scaledImage Logical. Whether the pixel values must be scaled to
#' the range (0 to 1) (reflectance values). Ignore for Landsat products. Default
#' FALSE.
#'
#' @param dark Float from 0 to 1. NIR threshold. NIR values below this
#' threshold are potential cloud shadows. Ignore for Landsat products. Default
#' 0.15.
#'
#' @param cloudDist Integer. Maximum distance in meters (m) to look for cloud
#' shadows from cloud edges. Ignore for Landsat products. Default 1000.
#'
#' @param buffer Integer. Distance in meters (m) to dilate cloud and cloud
#' shadows objects. Ignore for Landsat products. Default 250.
#'
#' @param cdi Float from -1 to 1. Cloud Displacement Index threshold. Values
#' below this threshold are considered potential clouds. A cdi = None means
#' that the index is not used. For more info see: 'Frantz, D., HaS, E., Uhl,
#' A., Stoffels, J., Hill, J. 2018. Improvement of the Fmask algorithm for
#' Sentinel-2 images: Separating clouds from bright surfaces based on parallax
#' effects. Remote Sensing of Environment 2015: 471-481'. Default NULL. Ignore
#' for Landsat products.
#'
#' @returns ee.ImageCollection with cloud/cloud shaodow masked
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' s2 <- ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$first() %>%
#'   ee_model_cloudmask()
#'
#' Map$centerObject(s2)
#' Map$addLayer(s2)
#' }
#' @export
ee_model_cloudmask <- function(
  x,
  method = "cloud_prob",
  prob = 60,
  maskCirrus = TRUE,
  maskShadows = TRUE,
  scaledImage = FALSE,
  dark = 0.15,
  cloudDist = 1000,
  buffer = 250,
  cdi = NULL
){
  EEextra_PYTHON_PACKAGE$QA$clouds$maskClouds(
    x = x, method = method, prob = prob, maskCirrus = maskCirrus,
    maskShadows = maskShadows, scaledImage = scaledImage,
    dark = dark, cloudDist = cloudDist, buffer = buffer, cdi = cdi
  )
}

#' Tasseled cap transformation
#'
#' Calculates tasseled cap brightness, wetness, and greenness components.
#' Tasseled cap transformations are applied using coefficients published
#' for these supported platforms:
#' \itemize{
#'   \item Sentinel-2 MSI Level 1C
#'   \item Landsat 8 OLI TOA
#'   \item Landsat 7 ETM+ TOA
#'   \item Landsat 5 TM Raw DN
#'   \item Landsat 4 TM Raw DN
#'   \item Landsat 4 TM Surface Reflectance
#'   \item MODIS NBAR
#' }
#'
#' @param x ee$ImageCollection or ee$Image. Must belong to a
#' supported platform.
#'
#' @return ee$ImageCollection or ee$Image with the tasseled cap components
#' as new bands in each image.
#' @references
#' \itemize{
#' \item Shi, T., & Xu, H. (2019). Derivation of Tasseled Cap Transformation
#' Coefficients for Sentinel-2 MSI At-Sensor Reflectance Data. IEEE Journal
#' of Selected Topics in Applied Earth Observations and Remote Sensing, 1–11.
#' doi:10.1109/jstars.2019.2938388
#' \item Baig, M.H.A., Zhang, L., Shuai, T. and Tong, Q., 2014. Derivation of a
#' tasselled cap transformation based on Landsat 8 at-satellite reflectance.
#' Remote Sensing Letters, 5(5), pp.423-431.
#' \item Huang, C., Wylie, B., Yang, L., Homer, C. and Zylstra, G., 2002.
#' Derivation of a tasselled cap transformation based on Landsat 7 at-satellite
#' reflectance. International journal of remote sensing, 23(8), pp.1741-1748.
#' \item Crist, E.P., Laurin, R. and Cicone, R.C., 1986, September. Vegetation and
#' soils information contained in transformed Thematic Mapper data. In
#' Proceedings of IGARSS’86 symposium (pp. 1465-1470). Paris: European Space
#' Agency Publications Division.
#' \item Crist, E.P. and Cicone, R.C., 1984. A physically-based transformation of
#' Thematic Mapper data---The TM Tasseled Cap. IEEE Transactions on Geoscience
#' and Remote sensing, (3), pp.256-263.
#' \item Crist, E.P., 1985. A TM tasseled cap equivalent transformation for
#' reflectance factor data. Remote sensing of Environment, 17(3), pp.301-306.
#' \item Lobser, S.E. and Cohen, W.B., 2007. MODIS tasselled cap: land cover
#' characteristics expressed through transformed MODIS data. International
#' Journal of Remote Sensing, 28(22), pp.5079-5101.
#' }
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#' library(rgee)
#'
#' ee_Initialize()
#'
#' col <- ee$ImageCollection("LANDSAT/LT05/C01/T1")
#' col <- ee_model_tasseledCap(col$first())
#' names(col)
#' }
#' @export
ee_model_tasseledCap <- function(x) {
  EEextra_PYTHON_PACKAGE$Spectral$core$tasseledCap(x)
}
