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


#' Extra Earth Engine module
#'
#' Interface to extent the Earth Engine package. Provides access to the
#' top level classes and functions.
#'
#' @format Earth Engine module
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#' ee_Initialize()
#' }
#' @export
EEextra_PYTHON_PACKAGE <- NULL


.onAttach <- function(libname, pkgname) {
    options(rgee.print.option = "simply")
}


.onLoad <- function(libname, pkgname) {
    ee_extra_location <- sprintf("%s/ee_extra", system.file(package = "rgeeExtra"))
    EEextra_PYTHON_PACKAGE <<- tryCatch(
        expr = reticulate::import_from_path("ee_extra", ee_extra_location, delay_load = TRUE),
        error = function(e) {
            "An error occurred while trying to import the ee Python package. Please, check if you have installed it correctly."
        }
    )
}


#' Load extra functionality for rgee
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#' extra_Initialize()
#' }
#' @export
extra_Initialize <- function() {
    print("Extra loaded successfully!")

    # ee.Image
    ee$Image$getCitation <- ee_image_getCitation
    ee$Image$getDOI <- ee_image_getDOI
    ee$Image$getOffsetParams <- ee_Image_getOffsetParams
    ee$Image$getScaleParams <- ee_Image_getScaleParams
    ee$Image$getSTAC <- ee_Image_getSTAC
    ee$Image$getSTAC <- ee_Image_preprocess
    ee$Image$spectralIndex <- ee_Image_spectralIndex
    ee$Image$preprocess <- ee_Image_preprocess
    ee$Image$panSharpen <- ee_Image_panSharpen
    ee$Image$maskClouds <- ee_Image_maskClouds
    ee$Image$matchHistogram <- ee_Image_matchHistogram
    ee$Image$tasseledCap <- ee_Image_tasseledCap
    ee$Image$scaleAndOffset <- ee_Image_scaleAndOffset

    # ee.ImageCollection
    ee$ImageCollection$closest <- ee_ImageCollection_closest
    ee$ImageCollection$getCitation <- ee_ImageCollection_getCitation
    ee$ImageCollection$getDOI <- ee_ImageCollection_getDOI
    ee$ImageCollection$getOffsetParams <- ee_ImageCollection_getOffsetParams
    ee$ImageCollection$getScaleParams <- ee_ImageCollection_getScaleParams
    ee$ImageCollection$getSTAC <- ee_ImageCollection_getSTAC
    ee$ImageCollection$spectralIndex <- ee_ImageCollection_spectralIndex
    ee$ImageCollection$preprocess <- ee_ImageCollection_preprocess
    ee$ImageCollection$scaleAndOffset <- ee_ImageCollection_scaleAndOffset
    ee$ImageCollection$tasseledCap <- ee_ImageCollection_tasseledCap
    ee$ImageCollection$panSharpen <- ee_ImageCollection_panSharpen
}

