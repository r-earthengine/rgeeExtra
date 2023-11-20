#' @name ee_subsetting
#' @export
'[[.ee.image.Image' <- function(x, index) {
  # 2. Select just an specific band
  if (is.numeric(index)) {

    # 2.1. Deal with negative and zero index
    if (any(index < 1)) {
      if (any(index == 0)) {
        stop(
          "rgee respect the one-based index. Therefore if you want to obtain the ",
          "first image-band you must use 1 rather than 0."
        )
      } else {
        stop("Negative index are not supported.")
      }
    }

    x$select(index - 1)
  } else if (is.character(index)) {
    x$select(index)
  } else {
    stop(
      sprintf("index must be a numeric or a character not a %s.", class(index))
    )
  }
}

#' @name ee_subsetting
#' @export
'[<-.ee.image.Image' <- function(x, index, value) {
  # 1. check if value is a ee.Image
  if (!inherits(index, "ee.image.Image")) {
    stop(sprintf("index must be a ee.Image not a %s.", class(index)[1]))
  }

  seed_mask <- x %>% rgee::ee$Image$pow(0)
  image_masked <- x %>%
    rgee::ee$Image$updateMask(index$Not()) %>%
    rgee::ee$Image$unmask(0)

  value <- rgee::ee$Image(value) %>%
    rgee::ee$Image$updateMask(index) %>%
    rgee::ee$Image$unmask(0, sameFootprint = TRUE)

  (image_masked + value)*seed_mask

}

#' @name ee_subsetting
#' @export
'[[<-.ee.image.Image' <- function(x, index, value) {
  # 1. check if value is a ee.Image
  if (!inherits(value, "ee.image.Image")) {
    stop(sprintf("value must be a ee.Image not a %s.", class(value)[1]))
  }

  # 2. From multiband Image to single-band ImageCollection
  x_ic <- x %>%
    rgee::ee$Image$bandNames() %>%
    rgee::ee$List$map(
      rgee::ee_utils_pyfunc(
        function(band) x$select(list(band))
      )
    ) %>% rgee::ee$ImageCollection()


  if (is.character(index)) {
    # 3. If index is a character obtain band name
    bdn <- rgee::ee$Image$bandNames(x)$getInfo()
    if (any(bdn %in% index)) {
      # 3.1. Send to '[['.ImageCollection operator the numerical index and the
      # length of the ImageCollection (to avoid estimate it again!)
      params <- list(index = which(bdn %in% index), length = length(bdn))
      x_ic[[params]] <- value
      x_ic$toBands()$rename(rgee::ee$Image$bandNames(x))
    } else {
      stop("Index does not match with any band in the ee$Image.")
    }
  } else if (is.numeric(index)) {
    # 3. Replace value
    x_ic[[index]] <- value
    x_ic$toBands()$rename(rgee::ee$Image$bandNames(x))
  } else {
    stop("index is not supported")
  }
}

#' Rename of Earth Engine Images layers (bands)
#'
#' Set the names of the layers of an Earth Engine Image object.
#'
#' @param x an EE Image object.
#' @param value a character vector with the same length as x.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' img_demo <- ee$Image("COPERNICUS/S2_SR/20190310T105851_20190310T110327_T30TVK")[[1:3]]
#' names(img_demo) <- c("B01", "B02", "B03")
#' }
#' @return An ee$Image with its bands renamed.
#' @export
'names<-.ee.image.Image' <-function(x, value) {
  rgee::ee$Image$rename(x, value)
}



#' Names of Earth Engine Images layers (bands)
#'
#' Get the names of the layers of an Earth Engine Image object.
#' @param x an EE Image object.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#'
#' img_demo <- ee$Image("COPERNICUS/S2_SR/20190310T105851_20190310T110327_T30TVK")[[1:3]]
#' names(img_demo)
#' }
#' @return A vector with the name of the bands.
#' @export
'names.ee.image.Image' <-function(x) {
  x %>% rgee::ee$Image$bandNames() %>% rgee::ee$List$getInfo()
}



#' Length of an Earth Engine Image Object
#'
#' Get or set the length of an Earth Engine Image.
#' @param x an EE Image Object.
#' @details
#'  If a vector is shortened, extra values are discarded and when a vector
#'  is lengthened, it is padded out to its new length with ee$Image(0), with
#'  band name of zzz_rgee_NA_%02d.
#' @examples
#' \dontrun{
#' library(rgeeExtra)
#' library(rgee)
#'
#' ee_Initialize()     # Initialize the Google Earth Engine API connection
#' extra_Initialize()  # Initialize the extended functionalities of rgeeExtra
#'
#' ic <- ee$Image("COPERNICUS/S2_SR/20190310T105851_20190310T110327_T30TVK")
#' length(ic)
#' }
#' @return A numeric value that indicate the number of bands in a ee$Image.
#' @export
'length.ee.image.Image' <-function(x) {
  x %>% rgee::ee$Image$bandNames() %>% rgee::ee$List$getInfo() %>% length()
}