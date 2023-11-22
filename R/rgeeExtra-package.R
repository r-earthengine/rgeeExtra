#' rgeeExtra: Extra functionality for rgee
#'
#' Google Earth Engine (Gorelick et al., 2017) is a cloud computing platform
#' designed for planetary-scale environmental data analysis that only can be
#' accessed via the Earth Engine code editor, third-party web apps, and the
#' JavaScript and Python client libraries. \code{rgee} is a non-official
#' client library for R that uses \code{reticulate} to wrap the Earth Engine
#' Python API and provide R users with a familiar interface, rapid development
#' features, and flexibility to analyze data using open-source, R third-party
#' packages.
#'
#' @details  The package implements and supports:
#'
#' \itemize{
#'   \item Math operators
#' }
#'
#' @keywords package
#'
"_PACKAGE"




EEextra_PYTHON_PACKAGE <- NULL


.onAttach <- function(libname, pkgname) {
    options(rgee.print.option = "simply")
}




#' Load extra functionality for rgee
#' @param quiet  Logical. Suppress info messages.
#' @import cli
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize() # Initialize GEE
#' extra_Initialize() # Extent the GEE API
#' }
#' @returns TRUE if the function runs smoothly.
#' @export
extra_Initialize <- function(quiet = FALSE) {

    if (!quiet) {
        cat(
            "",
            crayon::green(cli::symbol[["tick"]]),
            crayon::blue("Initializing ee_Extra module:")
        )
    }

    # Initialize EXTRA MODULE
   

    if (!quiet) {
        cat(
            "\r",
            crayon::green(cli::symbol[["tick"]]),
            crayon::blue("Initializing ee_Extra module:"),
            crayon::green(" DONE!\n")
        )
    }

    # ee.Image
    ee$Image$Extra_getCitation <- ee_image_getCitation
    ee$Image$Extra_getDOI <- ee_image_getDOI
    ee$Image$Extra_getOffsetParams <- ee_Image_getOffsetParams
    ee$Image$Extra_getScaleParams <- ee_Image_getScaleParams
    ee$Image$Extra_getSTAC <- ee_Image_getSTAC
    ee$Image$Extra_spectralIndex <- ee_Image_spectralIndex
    ee$Image$Extra_preprocess <- ee_Image_preprocess
    ee$Image$Extra_panSharpen <- ee_Image_panSharpen
    ee$Image$Extra_maskClouds <- ee_Image_maskClouds
    ee$Image$Extra_matchHistogram <- ee_Image_matchHistogram
    ee$Image$Extra_tasseledCap <- ee_Image_tasseledCap
    ee$Image$Extra_scaleAndOffset <- ee_Image_scaleAndOffset
    ee$Image$Extra_maxValue <- ee_maxValue
    ee$Image$Extra_minValue <- ee_minValue
    
    # ee.ImageCollection
    ee$ImageCollection$Extra_closest <- ee_ImageCollection_closest
    ee$ImageCollection$Extra_getCitation <- ee_ImageCollection_getCitation
    ee$ImageCollection$Extra_getDOI <- ee_ImageCollection_getDOI
    ee$ImageCollection$Extra_getOffsetParams <- ee_ImageCollection_getOffsetParams
    ee$ImageCollection$Extra_getScaleParams <- ee_ImageCollection_getScaleParams
    ee$ImageCollection$Extra_getSTAC <- ee_ImageCollection_getSTAC
    ee$ImageCollection$Extra_preprocess <- ee_ImageCollection_preprocess
    ee$ImageCollection$Extra_scaleAndOffset <- ee_ImageCollection_scaleAndOffset
    invisible(TRUE)
}


#' ee_utils if the first call that rgee does to Python, so delay_load (reticulate::import)
#' will affected. This function was created to force n times the connection to Python virtual
#' env, before to display a error message.
#' @noRd
ee_connect_to_py <- function(path, n = 5) {
  ee_utils <- try(ee_source_python(oauth_func_path = path), silent = TRUE)
  # counter added to prevent problems with reticulate
  con_reticulate_counter <- 1
  while (any(class(ee_utils) %in%  "try-error")) {
    ee_utils <- try(ee_source_python(path), silent = TRUE)
    con_reticulate_counter <- con_reticulate_counter + 1
    if (con_reticulate_counter == (n + 1)) {
      python_path <- reticulate::py_discover_config()
      message_con <- c(
        sprintf("The current Python PATH: %s",
                crayon::bold(python_path[["python"]])),
        "does not have the Python package \"earthengine-api\" installed. Do you restarted/terminated",
        "your R session after install miniconda or run ee_install()?",
        "If this is not the case, try:",
        "> reticulate::use_python(): Refresh your R session and manually set the Python environment with all rgee dependencies.",
        "> ee_install(): To create and set a Python environment with all rgee dependencies.",
        "> ee_install_set_pyenv(): To set a specific Python environment."
      )

      stop(paste(message_con,collapse = "\n"))
    }
  }
  return(ee_utils)
}

#' Read and evaluate a python script
#' @noRd
ee_source_python <- function(oauth_func_path) {
  module_name <- gsub("\\.py$", "", basename(oauth_func_path))
  module_path <- dirname(oauth_func_path)
  reticulate::import_from_path(module_name, path = module_path, convert = FALSE)
}

load_ee_Extra <- function() {
  ee_extra_location <- sprintf("%s/ee_extra", system.file(package = "rgeeExtra"))
  EEextra_PYTHON_PACKAGE <- tryCatch(
      expr = reticulate::import_from_path("ee_extra", ee_extra_location, delay_load = list(priority = 10)),
      error = function(e) {
          "An error occurred while trying to import the ee Python package. Please, check if you have installed it correctly."
      }
  )
  return(EEextra_PYTHON_PACKAGE)
}