#' @name ee_subsetting
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


#' Length of an Earth Engine Image Object
#'
#' Get or set the length of an Earth Engine Image.
#' @param x an EE FeatureCollection Object.
#' @name ee_length
#' @export
'length.ee.featurecollection.FeatureCollection' <-function(x) {
  x$size()$getInfo()
}


#' Length of an Earth Engine Image Object
#'
#' Get or set the length of an Earth Engine Image.
#' @param x an EE FeatureCollection Object.
#' @name ee_length
#' @export
'names.ee.feature.Feature' <-function(x) {
  x$propertyNames()$getInfo()
}
