#' Extract or replace parts of and ee$ImageCollection
#' @param x ee$ImageCollection or ee$Image.
#' @param index Integer. Index specifying elements to extract or replace.
#' @param value ee$ImageCollection or ee$Image to replace in.
#' @name ee_subsetting
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#' library(sf)
#'
#' ee_Initialize(gcs = TRUE, drive = TRUE)
#'
#' # Define a Image or ImageCollection: Terraclimate
#' terraclimate <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE") %>%
#'   ee$ImageCollection$filterDate("2001-01-01", "2002-01-01")
#'
#' # Define temperature Vis parameters
#' maximumTemperatureVis <- list(
#'   min = -300.0,
#'   max = 300.0,
#'   palette = c(
#'     '1a3678', '2955bc', '5699ff', '8dbae9', 'acd1ff', 'caebff', 'e5f9ff',
#'     'fdffb4', 'ffe6a2', 'ffc969', 'ffa12d', 'ff7c1f', 'ca531a', 'ff0000',
#'     'ab0000'
#'   )
#' )
#'
#' Map$setCenter(71.72, 52.48, 2)
#' tnames <- names(terraclimate[[2]])
#' m1 <- Map$addLayer(terraclimate[[2]][["tmmx"]], maximumTemperatureVis)
#'
#' terraclimate[[2]] <- terraclimate[[2]]*1.4
#' names(terraclimate[[2]]) <- tnames
#' m2 <- Map$addLayer(terraclimate[[2]][["tmmx"]], maximumTemperatureVis)
#' m1 | m2
#' }
#' @export
'[[.ee.imagecollection.ImageCollection' <- function(x, index) {
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

#' @name ee_subsetting
#' @export
'[[<-.ee.imagecollection.ImageCollection' <- function(x, index, value) {
  # 1. Deal with negative and zero index
  if (any(index < 1)) {
    if (any(index == 0)) {
      stop(
        "rgee respect the one-based index. Therefore if you want to obtain the ",
        "first ee$Image you must use 1 rather than 0."
      )
    } else {
      stop("Negative index are not supported.")
    }
  }

  # special trick for internal use (in [[<- ee.Image) ... please just ignore it :)
  if (is.list(index)) {
    if (all(names(index) %in% c("index", "length"))) {
      ee_ic_size <- index$length
      index <- index$index
    }
  } else if(is.numeric(index)) {
    # 2. Length of the ImageCollection
    ee_ic_size <- x %>%
      rgee::ee$ImageCollection$size() %>%
      rgee::ee$Number$getInfo()
  } else {
    stop("Index must be a numeric vector.")
  }

  # 3. From ImageCollection to list of images
  ic_list <- lapply(
    (seq_len(ee_ic_size) - 1),
    function(index) x %>% ee_get(index) %>% rgee::ee$ImageCollection$first()
  )

  # 4. Convert "value" from ee.Image, ee.ImageCollection or list of ee.Image to
  #    list of ee.Image.
  if (inherits(value, "ee.image.Image")) {
    list_value <- list(value)
  } else if(inherits(value, "ee.imagecollection.ImageCollection")) {
    # 4.1. Length of the ImageCollection
    ee_value_size <- value %>%
      rgee::ee$ImageCollection$size() %>%
      rgee::ee$Number$getInfo()

    # 4.2. From ImageCollection to list of images
    value_list <- lapply(
      (seq_len(ee_value_size) - 1),
      function(index) value %>% ee_get(index) %>% rgee::ee$ImageCollection$first()
    )
    list_value <- value_list
  } else if(is.list(value)) {
    list_value <- value
  } else {
    stop(
      sprintf(
        "value should be a ee.Image, ee.ImageCollection of a list of ee.Image not a %s.",
        class(value)
      )
    )
  }

  # 5. Do the index and value have the same length?
  if (length(index) != length(list_value)) {
    stop("The value to assign should have the same length that the ee$ImageCollection.")
  }

  # 6. Condition: Index is outside of ic
  # if (!any(seq_len(ee_ic_size) %in% seq_along(list_value))) {
  #   stop("Not a valid subset")
  # }

  # 7. Condition: Index is outside of ic

  counter <- 1
  for (list_value_index in seq_along(list_value)) {
    ic_list[[index[counter]]] <- list_value[[list_value_index]]
    counter <- counter + 1
  }
  rgee::ee$ImageCollection(ic_list)
}

#' Length of an Earth Engine ImageCollection Object
#'
#' Set the length of an Earth Engine Image.
#'
#' @param x an EE ImageCollection Object.
#' @name ee_length_ic
#' @export
'length.ee.imagecollection.ImageCollection' <-function(x) {
  x %>%
    rgee::ee$ImageCollection$size() %>%
    rgee::ee$Number$getInfo()
}


#' Names of Earth Engine ImagesCollection properties
#'
#' Get the names of the properties of an Earth Engine ImageCollection object.
#' @param x an EE ImageCollection object.
#' @name ee_name_ic
#' @export
'names.ee.imagecollection.ImageCollection' <-function(x) {
  x %>% rgee::ee$ImageCollection$propertyNames() %>% rgee::ee$List$getInfo()
}
