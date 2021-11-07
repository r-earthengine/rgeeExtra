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
