#' Get the temporal nearest image
#'
#' Gets the closest ee$Image to a specified date.
#'
#' @param x ee$ImageCollection. Image Collection from which to get
#' the closest image to the specified date.
#' @param date ee$Date or R date object. Date of interest. The function will
#' look for image closest to this date.
#' @param tolerance Numeric. Default 1. Filter the collection between
#' (date - tolerance: date + tolerance) before searching the closest
#' image. This speeds up the searching process for collections with a
#' high temporal resolution.
#' @param unit Character. Units for tolerance. Available units: "year",
#' "month", "week", "day", "hour", "minute" or "second". Default "month".
#'
#' @returns An ee$Image closest to the specified date.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' roi <- ee$Geometry$Point(c(-79, -12))
#' ee$ImageCollection$Dataset$MODIS_006_MCD12Q1 %>%
#'   ee_ImageCollection_closest("2020-10-15",  2, "year") %>%
#'   ee$ImageCollection$first() %>%
#'   Map$addLayer()
#' }
#' @export
ee_ImageCollection_closest <- function(x, date, tolerance=1, unit="month") {
  # check if there is an image
  EEextra_PYTHON_PACKAGE$closest(
    x = x,
    date = date,
    tolerance = tolerance,
    unit = unit
  )
}

#' @name ee-citation
ee_ImageCollection_getCitation <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getCitation(x = x)
}


#' @name ee-getdoi
ee_ImageCollection_getDOI <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getDOI(x = x)
}


#' @name ee-getoffset
ee_ImageCollection_getOffsetParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getOffsetParams(x = x)
}


#' @name ee-getscaleparams
ee_ImageCollection_getScaleParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getScaleParams(x = x)
}


#' @name ee-getstac
ee_ImageCollection_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}

#' @name ee-spectralindex
ee_ImageCollection_spectralIndex <- function(
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
  EEextra_PYTHON_PACKAGE$Spectral$core$spectralIndices(
    x = x, index = index, G = G, C1 = C1, C2 = C2, L = L,
    cexp = cexp, nexp = nexp, alpha = alpha, slope = slope,
    intercept = intercept, gamma = gamma, kernel = kernel, sigma = sigma,
    p = p, c = c, online = online, drop = drop
  )
}

#' @name ee-preprocess
ee_ImageCollection_preprocess <- function(x, ...) {
  EEextra_PYTHON_PACKAGE$QA$pipelines$preprocess(x, ...)
}

#' @name ee-scaleandoffset
ee_ImageCollection_scaleAndOffset <- function(x) {
  EEextra_PYTHON_PACKAGE$QA$pipelines$scaleAndOffset(
    x = x
  )
}

#' @name ee-pansharpen
ee_ImageCollection_panSharpen <- function(x, method="SFIM", qa = "MSE", ...) {
  EEextra_PYTHON_PACKAGE$Algorithms$panSharpening$'_panSharpen'(
    img = x,
    method = method,
    qa = qa,
    ...
  )
}

#' @name ee-tasseledcap
ee_ImageCollection_tasseledCap <- function(x) {
  EEextra_PYTHON_PACKAGE$Spectral$core$tasseledCap(x = x)
}
