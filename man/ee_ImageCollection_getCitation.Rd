% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ee_ImageColletion.R
\name{ee_ImageCollection_getCitation}
\alias{ee_ImageCollection_getCitation}
\title{Citing EE ImageCollection objects in publications}
\usage{
ee_ImageCollection_getCitation(x)
}
\arguments{
\item{x}{Image Collection to get the citation from.}
}
\value{
A character with citation information.
}
\description{
If it exists, retrieve the citation of an ee$ImageCollection object.
}
\examples{
\dontrun{
library(rgee)
library(rgeeExtra)

ee_Initialize()

ee$ImageCollection$Dataset$NASA_GPM_L3_IMERG_V06 \%>\%
  ee_ImageCollection_getCitation()
}
}
\seealso{
Other citation: 
\code{\link{ee_ImageCollection_getDOI}()},
\code{\link{ee_Image_getCitation}()}
}
\concept{citation}
