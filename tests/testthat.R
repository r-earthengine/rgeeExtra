library(testthat)
library(rgee)
library(rgeeExtra)
library(stars)
library(sf)

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  test_check("rgeeExtra")
}


