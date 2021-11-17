#' Get the temporal nearest image
#'
#' Gets the closest ee$Image to a specified date.
#'
#' @param x ee$ImageCollection. Image Collection from which to get
#' the closest image to the specified date.
#' @param date ee$Date or R date object. Date of interest. The function will
#' look for image closest to this date.
#' @param tolerance Numeric. Default 1. Filter the collection between
#' (date - tolerance: date + tolerance) before searching the closest
#' image. This speeds up the searching process for collections with a
#' high temporal resolution.
#' @param unit Character. Units for tolerance. Available units: "year",
#' "month", "week", "day", "hour", "minute" or "second". Default "month".
#'
#' @returns An ee$Image closest to the specified date.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' roi <- ee$Geometry$Point(c(-79, -12))
#' ee$ImageCollection$Dataset$MODIS_006_MCD12Q1 %>%
#'   ee_ImageCollection_closest("2020-10-15",  2, "year") %>%
#'   ee$ImageCollection$first() %>%
#'   Map$addLayer()
#' }
#' @export
ee_ImageCollection_closest <- function(x, date, tolerance=1, unit="month") {
  # check if there is an image
  EEextra_PYTHON_PACKAGE$closest(
    x = x,
    date = date,
    tolerance = tolerance,
    unit = unit
  )
}

#' Citing EE ImageCollection objects in publications
#'
#' If it exists, retrieve the citation of an ee$ImageCollection object.
#'
#' @param x Image Collection to get the citation from.
#'
#' @returns A character with citation information.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 %>%
#'   ee_ImageCollection_getCitation()
#' }
#' @export
ee_ImageCollection_getCitation <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getCitation(x = x)
}


#' Get the Digital Object Identifier (DOI) of an EE ImageCollection object
#'
#' If it exists, retrieve the DOI of an ee$ImageCollection object.
#'
#' @param x ee$ImageCollection.
#'
#' @returns A character with DOI information.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 %>%
#'   ee_ImageCollection_getDOI()
#' }
#' @export
ee_ImageCollection_getDOI <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getDOI(x = x)
}


#' Retrieve offset parameter from EE ImageCollection objects
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee_ImageCollection_getOffsetParams
#' retrieve the offset parameter for each band of an ee$ImageCollection.
#'
#' @param x ee$ImageCollection
#'
#' @returns A list with the offset parameters for each band.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 %>%
#'   ee_ImageCollection_getOffsetParams()
#' }
#' @export
ee_ImageCollection_getOffsetParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getOffsetParams(x = x)
}


#' Retrieve scale parameter from EE ImageCollection objects.
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee_ImageCollection_getScaleParams
#' retrieve the scale parameter for each band of an ee$ImageCollection.
#'
#' @param x ee$ImageCollection.
#'
#' @returns A list with the scale parameters for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 %>%
#'   ee_ImageCollection_getScaleParams()
#' }
#' @export
ee_ImageCollection_getScaleParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getScaleParams(x = x)
}


#' Retrieve EE ImageCollection STAC metadata
#'
#' Get the STAC of an ee$ImageCollection object.
#'
#' @param x ee$ImageCollection.
#' @returns Return STAC metadata for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 %>%
#'   ee_ImageCollection_getSTAC()
#' }
#' @export
ee_ImageCollection_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}


#' Spectral Indices Computation
#'
#' Computes one or more spectral indices for an ee$ImageCollection object.
#'
#' @param x ee$ImageCollection to compute indices on.
#'
#' @param index Character. Default 'NDVI'. Index or list of indices
#' to compute. The available options are:
#'
#' \itemize{
#'  \item \strong{vegetation}: Compute all vegetation indices.
#'  \item \strong{burn}: Compute all burn indices.
#'  \item \strong{water}: Compute all water indices.
#'  \item \strong{snow}: Compute all snow indices.
#'  \item \strong{drought}: Compute all drought indices.
#'  \item \strong{urban}: Compute all urban (built-up) indices.
#'  \item \strong{kernel}: Compute all kernel indices.
#'  \item \strong{all}: Compute all indices listed below.
#' }
#'
#' Check the complete list of indices
#' \href{https://awesome-ee-spectral-indices.readthedocs.io/en/latest/list.html}{here}.
#'
#' @param G Numeric. Gain factor. It must be set if index is 'EVI'. Default 2.5.
#'
#' @param C1 Numeric. Coefficient 1 for the aerosol resistance term. It must be
#' set if index is 'EVI'. Default 6.0.
#'
#' @param C2 Numeric. Coefficient 2 for the aerosol resistance term. It must
#' be set if index is 'EVI'. Default 7.5.
#'
#' @param L  Numeric. Canopy background adjustment. It must be set if index is
#' 'EVI' or 'SAVI'. Default is 1.0.
#'
#' @param cexp Numeric. It must be set if index is 'OCVI'. Default 1.16.
#'
#' @param nexp Numeric. It must be set if index is 'GDVI'. Default 2.0.
#'
#' @param alpha Numeric. Weighting coefficient. It must be set if index is
#' 'WDRVI'. Default is 0.1.
#'
#' @param slope Numeric. Soil line slope. Default is 1.0.
#'
#' @param intercept Numeric. Soil line slope. Default = 0.0.
#'
#' @param gamma Numeric. Weighting coefficient. It must be set if index
#' is 'ARVI'. Default is 1.0.
#'
#' @param kernel Numeric. It must be set in kernel indices. The available
#' options are:
#' \itemize{
#'  \item \strong{linear}: Linear Kernel.
#'  \item \strong{RBF}: Radial Basis Function (RBF) Kernel.
#'  \item \strong{linear}: Polynomial Kernel.
#' }
#' The default kernel is 'RBF'.
#'
#' @param sigma Character or Numeric. Length-scale parameter. It must be set
#' in RBF kernel indices. If character, the expression needs to include 'a'
#' and 'b'. If numeric, it must be positive. Default is '0.5 * (a + b)'.
#'
#' @param p Numeric. Kernel degree. It must be set in polynomial kernel
#' indices ('poly'). Default is 2.0.
#'
#' @param c Numeric. Free parameter that trades off the influence of
#' higher-order versus lower-order terms in the polynomial kernel. It must be
#' set in polynomial kernel indices ('poly'). This must be greater than or equal
#' to 0. Default is 1.0.
#'
#' @param online Logical. Whether to retrieve the most recent list of indices
#' directly from the GitHub repository and not from the local copy. Default is
#' FALSE.
#'
#' @param drop Logical. If TRUE, drop the image bands. Default TRUE.
#'
#' @returns ee$ImageCollection with the computed spectral index, or indices,
#' as new bands.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#'s2_indices <- ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'  ee$ImageCollection$first() %>%
#'  ee_ImageCollection_preprocess() %>%
#'  ee_ImageCollection_spectralIndex(c("NDVI", "SAVI"))
#' names(s2_indices)
#' # "NDVI" "SAVI"
#' }
#' @export
ee_ImageCollection_spectralIndex <- function(
  x,
  index = "NDVI",
  G = 2.5,
  C1 = 6.0,
  C2 = 7.5,
  L = 1.0,
  cexp = 1.16,
  nexp = 2.0,
  alpha = 0.1,
  slope = 1.0,
  intercept = 0.0,
  gamma = 1.0,
  kernel = "RBF",
  sigma = "0.5 * (a + b)",
  p = 2.0,
  c = 1.0,
  online = FALSE,
  drop = TRUE
) {
  EEextra_PYTHON_PACKAGE$Spectral$core$spectralIndices(
    x = x, index = index, G = G, C1 = C1, C2 = C2, L = L,
    cexp = cexp, nexp = nexp, alpha = alpha, slope = slope,
    intercept = intercept, gamma = gamma, kernel = kernel, sigma = sigma,
    p = p, c = c, online = online, drop = drop
  )
}


#' Automated EE ImageCollection preprocessing
#'
#' Preprocessing of ee$ImageCollection objects. This function performs the
#' following tasks:
#' \itemize{
#'  \item \strong{Cloud Masking}: Remove cloud and cloud shadow pixels.
#'  See ee_model_cloudmask.
#'  \item \strong{Decompress}: Convert integer pixels to float point numbers.
#' }
#'
#' @param x ee$ImageCollection.
#' @param ... Arguments to pass to ee_model_cloudmask.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$first() %>%
#'   ee_ImageCollection_preprocess()
#' }
#' @return  An ee$ImageCollection object
#' @export
ee_ImageCollection_preprocess <- function(x, ...) {
  EEextra_PYTHON_PACKAGE$QA$pipelines$preprocess(x, ...)
}


#' Automatic decompression of EE ImageCollection objects
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee_ImageCollection_scaleAndOffset backs
#' the integer pixel values to float point number.
#'
#' @param x : ee$ImageCollection.
#'
#' @return An ee$ImageCollection with float pixel values.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$first() %>%
#'   ee_ImageCollection_scaleAndOffset()
#' }
#' @export
ee_ImageCollection_scaleAndOffset <- function(x) {
  EEextra_PYTHON_PACKAGE$QA$pipelines$scaleAndOffset(
    x = x
  )
}
