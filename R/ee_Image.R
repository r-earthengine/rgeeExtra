#' Citing EE Image objects in publications
#'
#' If it exists, retrieve the citation of an ee$Image object.
#'
#' @param x Image to get the citation from.
#'
#' @family citation
#' @returns A character with citation information.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06$first() %>%
#'   ee_Image_getCitation()
#' }
#' @export
ee_Image_getCitation <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getCitation(x = x)
}


#' Get the Digital Object Identifier (DOI) of an EE ImageCollection object
#'
#' If it exists, retrieve the DOI of an ee$ImageCollection object.
#'
#' @param x ee$ImageCollection.
#'
#' @family citation
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


#' Retrieve offset parameter from EE Image objects
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee_Image_getOffsetParams
#' retrieve the offset parameter for each band of an ee$Image.
#'
#' @param x ee$Image
#'
#' @family calibration
#' @returns A list with the offset parameters for each band.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06$first() %>%
#'   ee_Image_getOffsetParams()
#' }
#' @export
ee_Image_getOffsetParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getOffsetParams(x = x)
}


#' Retrieve scale parameter from EE Image objects.
#'
#' Earth Engine apply a simply lossless compression technique: IMG_Float_Values =
#' scale * IMG_Integer_Values + offset. ee_Image_getScaleParams
#' retrieve the scale parameter for each band of an ee$Image.
#'
#' @param x ee$Image.
#'
#' @family calibration
#' @returns A list with the scale parameters for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06$first() %>%
#'   ee_Image_getScaleParams()
#' }
#' @export
ee_Image_getScaleParams <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getScaleParams(x = x)
}


#' Retrieve EE Image STAC metadata
#'
#' Get the STAC of an ee$Image object.
#'
#' @family STAC
#' @param x ee$Image.
#' @returns Return STAC metadata for each band.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06$first() %>%
#'   ee_Image_getSTAC()
#' }
#' @export
ee_Image_getSTAC <- function(x) {
  EEextra_PYTHON_PACKAGE$STAC$core$getSTAC(x = x)
}


#' Adjust the image's histogram to match a target image
#'
#' @param x ee$Image to adjust.
#' @param target ee$Image image to match.
#' @param bands A dictionary of band names to match, with
#' source bands as keys and target bands as values.
#' @param geometry ee$Geometry. The region to match histograms in that
#' overlaps both images. If none is provided, the geometry of the source
#' image will be used.  Defaults is NULL.
#' @param maxBuckets Integer. The maximum number of buckets to use when building
#' histograms. Will be rounded to the nearest power of 2.  Default to 256.
#'
#' @returns The adjusted image containing the matched source bands.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06$first() %>%
#'   ee_Image_getSTAC()
#' }
ee_Image_matchHistogram <- function(x, target, bands, geometry=NULL, maxBuckets=256) {
  #_matchHistogram(self, target, bands, geometry, maxBuckets)
  FALSE
}


#' Automated EE Image preprocessing
#'
#' Preprocessing of ee$Image objects. This function performs the
#' following tasks:
#' \itemize{
#'  \item \strong{Cloud Masking}: Remove cloud and cloud shadow pixels.
#'  See ee_model_cloudmask.
#'  \item \strong{Decompress}: Convert integer pixels to float point numbers.
#' }
#'
#' @param x ee$Image.
#' @param ... Arguments to pass to ee_Image_preprocess.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
#'   ee$ImageCollection$first() %>%
#'   ee_Image_preprocess()
#' }
#' @return  An ee$Image object
#' @export
ee_Image_preprocess <- function(x, ...) {
  EEextra_PYTHON_PACKAGE$QA$pipelines$preprocess(x, ...)
}



#' Spectral Indices Computation
#'
#' Computes one or more spectral indices for an ee$Image object.
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
#' @returns ee$Image with the computed spectral index, or indices, as new bands.
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
#'  ee_Image_preprocess() %>%
#'  ee_Image_spectralIndex(c("NDVI", "SAVI"))
#' names(s2_indices)
#' # "NDVI" "SAVI"
#' }
#' @export
ee_Image_spectralIndex <- function(
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
