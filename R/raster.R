#' Minimum and Maximum Values
#'
#' Returns the minimum or maximum value of an ee.Image. The return value will
#' be an approximation if the polygon (area of the ee.Image) contains
#' too many pixels at the native scale.
#'
#' @param x ee$Image to analyze.
#' @param ... Additional arguments for specifying the mode and sampling.
#' See details for more information.
#'
#' @details
#' The `...` argument can include the following:
#' \itemize{
#'   \item{mode}{Character. Indicates the geometry over which to reduce data. Options: "Rectangle" (default) or "Points".}
#'   \item{sample_size}{Numeric. Number of points to be created. Relevant only if mode is "Points".}
#' }
#' The "Rectangle" mode uses the Image system:footprint, while the "Points" mode samples points over the Image system:footprint.
#'
#' @return A number representing the minimum or maximum value.
#'
#' @usage
#' `ee$Image$Extra_maxValue(x, ...)`
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' image <- ee$ImageCollection$Dataset$LANDSAT_LC08_C01_T1$first()[["B1"]]
#' # max values
#' ee$Image$Extra_maxValue(image)
#' ee$Image$Extra_maxValue(image, mode = "Points", sample_size = 2)
#'
#' # min values
#' ee$Image$Extra_minValue(image)
#' ee$Image$Extra_minValue(image, mode = "Points")
#' }
#' @family extremeValues
#' @name extremeValues
#' @export
ee_maxValue <- function(image, mode = "Rectangle", sample_size = 1000) {
  # Check the package
  ee_check_packages("ee_maxValue", "sf")

  if (mode == "Rectangle") {
    # Create a clean geometry i.e. geodesic = FALSE
    ee_geom <- rgee::ee_as_sf(image$geometry()) %>% rgee::sf_as_ee(geodesic = FALSE)

    # get max values
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$max(),
      geometry = ee_geom$geometry(),
      scale = 1000,
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
  } else if (mode == "Points") {
    # Create random points
    sample_points <- image$geometry() %>%
      rgee::ee_as_sf() %>%
      sf::st_sample(sample_size) %>%
      sf::st_cast("MULTIPOINT", ids = 1) %>%
      rgee::sf_as_ee()

    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$max(),
      geometry = sample_points,
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
  } else {
    stop("mode does not supported")
  }
}

#' @name extremeValues
#' @usage
#' `ee$Image$Extra_minValue(x, ...)`
#' @export
ee_minValue <- function(image, mode = "Rectangle", sample_size = 1000) {
  # Check the package
  ee_check_packages("ee_minValue", "sf")


  if (mode == "Rectangle") {
    # Create a clean geometry i.e. geodesic = FALSE
    ee_geom <- rgee::ee_as_sf(image$geometry()) %>% rgee::sf_as_ee(geodesic = FALSE)

    # get max values
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$min(),
      geometry = ee_geom$geometry(),
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
  } else if (mode == "Points") {
    # Create random points
    sample_points <- image$geometry() %>%
      rgee::ee_as_sf() %>%
      sf::st_sample(sample_size) %>%
      sf::st_cast("MULTIPOINT", ids = 1) %>%
      rgee::sf_as_ee()

    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$min(),
      geometry = sample_points,
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
  } else {
    stop("mode does not supported")
  }
}
