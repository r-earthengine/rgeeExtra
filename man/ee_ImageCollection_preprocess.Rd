% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ee_ImageColletion.R
\name{ee_ImageCollection_preprocess}
\alias{ee_ImageCollection_preprocess}
\title{Automated EE ImageCollection preprocessing}
\usage{
ee_ImageCollection_preprocess(x, ...)
}
\arguments{
\item{x}{ee$ImageCollection.}

\item{...}{Arguments to pass to ee_model_cloudmask.}
}
\value{
An ee$ImageCollection object
}
\description{
Preprocessing of ee$ImageCollection objects. This function performs the
following tasks:
\itemize{
\item \strong{Cloud Masking}: Remove cloud and cloud shadow pixels.
See ee_model_cloudmask.
\item \strong{Decompress}: Convert integer pixels to float point numbers.
}
}
\examples{
\dontrun{
library(rgee)
library(rgeeExtra)

ee_Initialize()

ee$ImageCollection$Dataset$COPERNICUS_S2_SR \%>\%
  ee$ImageCollection$first() \%>\%
  ee_ImageCollection_preprocess()
}
}
