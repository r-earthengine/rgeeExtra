#' Extract parts of and EE FeatureCollection
#' @param x ee$FeatureCollection.
#' @param index Integer. Index specifying elements to extract or replace.
#' @return An ee$FeatureCollection
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#' library(sf)
#'
#' ee_Initialize(gcs = TRUE, drive = TRUE)
#' extra_Initialize()
#'
#' # Define a Image or ImageCollection: Terraclimate
#' fc_tiger <- ee$FeatureCollection('TIGER/2016/Roads')
#' fc_tiger_subset <- fc_tiger[[1:100]]
#' Map$centerObject(fc_tiger_subset)
#' Map$addLayer(fc_tiger_subset)
#' }
#' @export
'[[.ee.featurecollection.FeatureCollection' <- function(x, index) {
  if (is.numeric(index)) {
    # 1. Deal with negative and zero index
    if (any(index < 1)) {
      if (index == 0) {
        stop(
          "rgee respect the one-based index. Therefore if you want to obtain the ",
          "first ee$Image you must use 1 rather than 0."
        )
      } else {
        stop("Negative index are not supported.")
      }
    }

    if (length(index) > 1) {
      x %>% ee_get((index) - 1)
    } else {
      x %>% ee_get((index) - 1) %>% rgee::ee$ImageCollection$first()
    }
  } else if (is.character(index)) {
    x %>%
      rgee::ee$ImageCollection$get(index) %>%
      rgee::ee$ComputedObject$getInfo()
  } else {
    stop(
      sprintf("index must be a numeric or a character not a %s.", class(index))
    )
  }
}


#' Length of an Earth Engine FeatureCollection Object
#'
#' Get the length of an Earth Engine FeatureCollection.
#'
#' @param x an EE FeatureCollection Object.
#'
#' @return A numeric representing the length of a ee$FeatureCollection object.
#' @examples
#' \dontrun{
#'
#' library(rgeeExtra)
#' library(rgee)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' region <- ee$Geometry$Rectangle(-119.224, 34.669, -99.536, 50.064)
#' randomPoints <- ee$FeatureCollection$randomPoints(region)
#' length(randomPoints)
#' }
#' @export
'length.ee.featurecollection.FeatureCollection' <-function(x) {
  x$size()$getInfo()
}


#' Names of Earth Engine FeatureCollection object
#'
#' Get the properties names of FeatureCollection object
#' @param x an EE FeatureCollection object.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' fc <- ee$FeatureCollection('WRI/GPPD/power_plants')
#' fc$propertyNames()$getInfo()
#' }
#' @returns A vector representing the property names of the ee$FeatureCollection object
#' @export
'names.ee.feature.Feature' <-function(x) {
  x$propertyNames()$getInfo()
}

