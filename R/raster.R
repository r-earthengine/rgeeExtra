#' Minimum and maximum values
#'
#' Returns the minimum or maximum value of an ee.Image.
#' @param image ee.Image
#' @param mode Character. Indicates the geometry over which
#' to reduce data (max). Two types are supported: "Rectangle" (by default)
#' which use the Image system:footprint, and "Points" which use points
#' sampled over the Image system:footprint.
#' @param sample_size Number of points to created. Ignore if mode is Rectangle.
#' @return A number
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' image <- ee$Image$random()
#' maxValue(image)
#' maxValue(image, mode = "Points")
#' }
#' @family extremeValues
#' @name extremeValues
#' @export
maxValue <- function(image, mode = "Rectangle", sample_size = 1000) {
  if (mode == "Rectangle") {
    # Create a clean geometry i.e. geodesic = FALSE
    ee_geom <- ee_as_sf(image$geometry()) %>% sf_as_ee()

    # get max values
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$max(),
      geometry = ee_geom$geometry(),
      scale = image$projection()$nominalScale()$getInfo(),
      bestEffort = TRUE
    ) %>% ee$Dictionary$getInfo() %>% unlist()
  } else if (mode == "Points") {
    # Create random points
    local_geom <- ee_as_sf(image$geometry())
    ee_random_points <- suppressMessages(
      sf::st_sample(local_geom, sample_size) %>% sf_as_ee()
    )
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$max(),
      geometry = ee_random_points$geometry(),
      scale = image$projection()$nominalScale()$getInfo(),
      bestEffort = TRUE
    ) %>% ee$Dictionary$getInfo() %>% unlist()
  } else {
    stop("mode does not supported")
  }
}

#' @rdname extremeValues
#' @export
minValue <- function(image, mode = "Rectangle", sample_size = 1000) {
  if (mode == "Rectangle") {
    # Create a clean geometry i.e. geodesic = FALSE
    ee_geom <- ee_as_sf(image$geometry()) %>% sf_as_ee()

    # get max values
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$min(),
      geometry = ee_geom$geometry(),
      scale = image$projection()$nominalScale()$getInfo(),
      bestEffort = TRUE
    ) %>% ee$Dictionary$getInfo() %>% unlist()
  } else if (mode == "Points") {
    # Create random points
    local_geom <- ee_as_sf(image$geometry())
    ee_random_points <- suppressMessages(
      sf::st_sample(local_geom, sample_size) %>% sf_as_ee()
    )
    rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$min(),
      geometry = ee_random_points$geometry(),
      scale = image$projection()$nominalScale()$getInfo(),
      bestEffort = TRUE
    ) %>% ee$Dictionary$getInfo() %>% unlist()
  } else {
    stop("mode does not supported")
  }
}
