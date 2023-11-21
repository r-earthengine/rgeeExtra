#' Get the temporal nearest image
#'
#' Gets the closest ee$Image to a specified date from an ee$ImageCollection.
#'
#' @param x ee$ImageCollection from which to get the closest image to the specified date.
#' @param ... Additional arguments for finding the nearest image.
#' See details for more information.
#'
#' @details
#' The `...` argument can include the following:
#' \itemize{
#'   \item{date}{ee$Date or R date object. Date of interest for searching the closest image.}
#'   \item{tolerance}{Numeric. Filters the collection within a range of (date - tolerance, date + tolerance). Default 1.}
#'   \item{unit}{Character. Units for tolerance. Options include "year", "month", "week", "day", "hour", "minute", "second". Default "month".}
#' }
#' These parameters allow for precise control over how the closest image is determined.
#'
#' @return An ee$Image closest to the specified date.
#'
#' @usage `ee$ImageCollection$Extra_closest(x, ...)`
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
#'   ee$ImageCollection$Extra_closest("2020-10-15",  2, "year") %>%
#'   ee$ImageCollection$first() %>%
#'   Map$addLayer()
#' }
#' @export

ee_ImageCollection_closest <- function(x, date, tolerance=1, unit="month") {
  # check if there is an image
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$closest(
    x = x,
    date = date,
    tolerance = tolerance,
    unit = unit
  )
}

#' @name ee-citation
#' @usage `ee$ImageCollection$Extra_getCitation(x)`
ee_ImageCollection_getCitation <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getCitation(x = x)
}


#' @name ee-getdoi
#' @usage `ee$ImageCollection$Extra_getDOI(x)`
ee_ImageCollection_getDOI <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getDOI(x = x)
}


#' @name ee-getoffset
#' @usage `ee$ImageCollection$Extra_getOffsetParams(x)`
ee_ImageCollection_getOffsetParams <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getOffsetParams(x = x)
}


#' @name ee-getscaleparams
#' @usage `ee$ImageCollection$Extra_getScaleParams(x)`
ee_ImageCollection_getScaleParams <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getScaleParams(x = x)
}


#' @name ee-getstac
#' @usage `ee$ImageCollection$Extra_getSTAC(x)`
ee_ImageCollection_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}


#' @name ee-preprocess
#' @usage `ee$ImageCollection$Extra_preprocess(x, ...)`
ee_ImageCollection_preprocess <- function(x, ...) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$QA$pipelines$preprocess(x, ...)
}

#' @name ee-scaleandoffset
#' @usage `ee$ImageCollection$Extra_scaleAndOffset(x)`
ee_ImageCollection_scaleAndOffset <- function(x) {
  EEextra_PYTHON_PACKAGE <- load_ee_Extra()
  EEextra_PYTHON_PACKAGE$QA$pipelines$scaleAndOffset(
    x = x
  )
}