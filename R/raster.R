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
    ee_geom <- rgee::ee_as_sf(image$geometry()) %>% rgee::sf_as_ee(geodesic = FALSE)

    # get max values
    rect_result <- rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$max(),
      geometry = ee_geom$geometry(),
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
    if (is.null(rect_result)) {
      message("The image footprint is too large ... Running maxValue(..., mode = \"Point\")")
      maxValue(image = image, mode = "Rectangle", sample_size = sample_size)
    }
    rect_result
  } else if (mode == "Points") {
    # Create random points
    sample_points <- image$geometry() %>%
      rgee::ee_as_sf() %>%
      sf::st_sample(sample_size) %>%
      st_cast("MULTIPOINT", ids = 1) %>%
      sf_as_ee()

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

#' @rdname extremeValues
#' @export
minValue <- function(image, mode = "Rectangle", sample_size = 1000) {
  if (mode == "Rectangle") {
    # Create a clean geometry i.e. geodesic = FALSE
    ee_geom <- rgee::ee_as_sf(image$geometry()) %>% rgee::sf_as_ee(geodesic = FALSE)

    # get max values
    rect_result <- rgee::ee$Image$reduceRegion(
      image = image,
      reducer = rgee::ee$Reducer$min(),
      geometry = ee_geom$geometry(),
      bestEffort = TRUE
    ) %>% rgee::ee$Dictionary$getInfo() %>% unlist()
    if (is.null(rect_result)) {
      message("The image footprint is too large ... Running maxValue(..., mode = \"Point\")")
      maxValue(image = image, mode = "Rectangle", sample_size = sample_size)
    }
    rect_result
  } else if (mode == "Points") {
    # Create random points
    sample_points <- image$geometry() %>%
      rgee::ee_as_sf() %>%
      sf::st_sample(sample_size) %>%
      st_cast("MULTIPOINT", ids = 1) %>%
      sf_as_ee()

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
