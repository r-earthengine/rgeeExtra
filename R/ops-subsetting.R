#' Return the element at a specified position in an Earth Engine Image or ImageCollection
#'
#' @param ee_c ImageCollection or FeatureCollection.
#' @param index Numeric. Specified position.
#' @return Depending of \code{ee_c} can return either an \code{ee$FeatureCollection}
#' or \code{ee$ImageCollection}.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(sf)
#'
#' ee_Initialize()
#'
#' nc <- st_read(system.file("shape/nc.shp", package = "sf")) %>%
#'   st_transform(4326) %>%
#'   sf_as_ee()
#'
#' ee_s2 <- ee$ImageCollection("COPERNICUS/S2")$
#'   filterDate("2016-01-01", "2016-01-31")$
#'   filterBounds(nc)
#'
#' ee_s2$size()$getInfo() # 126
#'
#' # Get the first 5 elements
#' ee_get(ee_s2, index = 0:4)$size()$getInfo() # 5
#' }
#' @export
ee_get <- function(ee_c, index = 0) {
  is_consecutive <- all(diff(index) == 1)
  if (any(index < 0)) {
    stop("index must be a positive value")
  }
  if (any(class(ee_c) %in%  c("ee.imagecollection.ImageCollection"))) {
    # Index is a single value?
    if (length(index) == 1) {
      ee_c %>%
        rgee::ee$ImageCollection$toList(count = 1, offset = index) %>%
        rgee::ee$ImageCollection()
    } else {
      # Index is a n-length vector and consecutive?
      if (length(index) > 1 & is_consecutive) {
        ee_c %>%
          rgee::ee$ImageCollection$toList(count = length(index), offset = min(index)) %>%
          rgee::ee$ImageCollection()
      } else {
        stop("ee_get only support ascending index order")
      }
    }
  } else  if (any(class(ee_c) %in%  c("ee.featurecollection.FeatureCollection"))) {
    # Index is a single value?
    if (length(index) == 1) {
      ee_c %>%
        rgee::ee$FeatureCollection$toList(count = 1, offset = index) %>%
        rgee::ee$FeatureCollection()
    } else {
      # Index is a n-length vector and consecutive?
      if (length(index) > 1 & is_consecutive) {
        ee_c %>%
          rgee::ee$FeatureCollection$toList(count = length(index), offset = min(index)) %>%
          rgee::ee$FeatureCollection()
      } else {
        stop("ee_get only support ascending index order")
      }
    }
  } else {
    stop("ee_get only support objects of class FeatureCollection and ImageCollection.",
         "\nEnter: ", class(ee_c)[1],
         "\nExpected: ee$ImageCollection or ee$FeatureCollection")
  }
}
