#' print Extra_EE_module
#' @param x Extra_EE_module object.
#' @param ... ignored
#' @return No return value, called for displaying Earth Engine objects.
#' @aliases print
#' @noRd
print.python.builtin.dict <- function(x, ...) {
  if (inherits(EEextra_PYTHON_PACKAGE, "Extra_EE_module")) {
    cat(ee_get_gogle_color(x))
  } else {
    print(x, ...)
  }
}


#' EarthEngine using Google Colors
#' @noRd
ee_get_gogle_color <- function(x) {
  paste0(
    "rgeeExtra ",
    ee_get_module_name(x) %>% crayon::bold(),
    sprintf(
      " module: Use '%s' to get the modules/functions.",
      crayon::bold("$")
    )
  )
}


#' EarthEngine using Google Colors
#' @noRd
ee_get_module_name <- function(x) {
  if (is.environment(x)) {
    # strsplit(deparse(substitute(x)), "\\$")[[1]] %>% tail(n = 1)
    if (any(names(x) %in%  "Image")) {
      return("Extra")
    }

    if (any(names(x) %in%  "Basic")) {
      return("Image")
    }

    if (any(names(x) %in%  "minvalue")) {
      return("Basic")
    }

  } else {
    x
  }
}

