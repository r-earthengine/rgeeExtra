% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ee_ImageColletion.R
\name{ee_ImageCollection_spectralIndex}
\alias{ee_ImageCollection_spectralIndex}
\title{Spectral Indices Computation}
\usage{
ee_ImageCollection_spectralIndex(
  x,
  index = "NDVI",
  G = 2.5,
  C1 = 6,
  C2 = 7.5,
  L = 1,
  cexp = 1.16,
  nexp = 2,
  alpha = 0.1,
  slope = 1,
  intercept = 0,
  gamma = 1,
  kernel = "RBF",
  sigma = "0.5 * (a + b)",
  p = 2,
  c = 1,
  online = FALSE,
  drop = TRUE
)
}
\arguments{
\item{x}{ee$ImageCollection to compute indices on.}

\item{index}{Character. Default 'NDVI'. Index or list of indices
to compute. The available options are:

\itemize{
\item \strong{vegetation}: Compute all vegetation indices.
\item \strong{burn}: Compute all burn indices.
\item \strong{water}: Compute all water indices.
\item \strong{snow}: Compute all snow indices.
\item \strong{drought}: Compute all drought indices.
\item \strong{urban}: Compute all urban (built-up) indices.
\item \strong{kernel}: Compute all kernel indices.
\item \strong{all}: Compute all indices listed below.
}

Check the complete list of indices
\href{https://awesome-ee-spectral-indices.readthedocs.io/en/latest/list.html}{here}.}

\item{G}{Numeric. Gain factor. It must be set if index is 'EVI'. Default 2.5.}

\item{C1}{Numeric. Coefficient 1 for the aerosol resistance term. It must be
set if index is 'EVI'. Default 6.0.}

\item{C2}{Numeric. Coefficient 2 for the aerosol resistance term. It must
be set if index is 'EVI'. Default 7.5.}

\item{L}{Numeric. Canopy background adjustment. It must be set if index is
'EVI' or 'SAVI'. Default is 1.0.}

\item{cexp}{Numeric. It must be set if index is 'OCVI'. Default 1.16.}

\item{nexp}{Numeric. It must be set if index is 'GDVI'. Default 2.0.}

\item{alpha}{Numeric. Weighting coefficient. It must be set if index is
'WDRVI'. Default is 0.1.}

\item{slope}{Numeric. Soil line slope. Default is 1.0.}

\item{intercept}{Numeric. Soil line slope. Default = 0.0.}

\item{gamma}{Numeric. Weighting coefficient. It must be set if index
is 'ARVI'. Default is 1.0.}

\item{kernel}{Numeric. It must be set in kernel indices. The available
options are:
\itemize{
\item \strong{linear}: Linear Kernel.
\item \strong{RBF}: Radial Basis Function (RBF) Kernel.
\item \strong{linear}: Polynomial Kernel.
}
The default kernel is 'RBF'.}

\item{sigma}{Character or Numeric. Length-scale parameter. It must be set
in RBF kernel indices. If character, the expression needs to include 'a'
and 'b'. If numeric, it must be positive. Default is '0.5 * (a + b)'.}

\item{p}{Numeric. Kernel degree. It must be set in polynomial kernel
indices ('poly'). Default is 2.0.}

\item{c}{Numeric. Free parameter that trades off the influence of
higher-order versus lower-order terms in the polynomial kernel. It must be
set in polynomial kernel indices ('poly'). This must be greater than or equal
to 0. Default is 1.0.}

\item{online}{Logical. Whether to retrieve the most recent list of indices
directly from the GitHub repository and not from the local copy. Default is
FALSE.}

\item{drop}{Logical. If TRUE, drop the image bands. Default TRUE.}
}
\value{
ee$ImageCollection with the computed spectral index, or indices,
as new bands.
}
\description{
Computes one or more spectral indices for an ee$ImageCollection object.
}
\examples{
\dontrun{
library(rgee)
library(rgeeExtra)

ee_Initialize()

s2_indices <- ee$ImageCollection$Dataset$COPERNICUS_S2_SR \%>\%
 ee$ImageCollection$first() \%>\%
 ee_ImageCollection_preprocess() \%>\%
 ee_ImageCollection_spectralIndex(c("NDVI", "SAVI"))
names(s2_indices)
# "NDVI" "SAVI"
}
}
