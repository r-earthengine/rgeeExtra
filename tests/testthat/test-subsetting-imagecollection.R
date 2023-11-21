context("rgeeExtra: subsetting ee.ImageCollection")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

ic_demo <- ee$ImageCollection$Dataset$AU_GA_AUSTRALIA_5M_DEM

test_that("names.ee.imagecollection.ImageCollection", {
  expect_true(any(names(ic_demo) %in% "system:visualization_0_bands"))
})


test_that("[[.ee.imagecollection.ImageCollection", {
  pallete_dem <- ic_demo[["visualization_0_palette"]]
  expect_type(pallete_dem, "character")
  first_image <- ic_demo[[1]]
  # expect_equal(first_image$getInfo(), ic_demo$first()$getInfo())

  # ee.Image subsetting test
  expect_error(first_image[[0]])
  expect_error(first_image[[-1]])
  expect_error(first_image[[TRUE]])

  # ee.Image.Collection subsetting test
  expect_error(ic_demo[[0]])
  expect_error(ic_demo[[-1]])
  expect_error(ic_demo[[TRUE]])

})


test_that("[[<-.ee.imagecollection.ImageCollection", {
  x <- ee$ImageCollection$Dataset$AU_GA_AUSTRALIA_5M_DEM
  expect_is(x[[2:3]], "ee.imagecollection.ImageCollection")
  x[[1]] <- ee$Image(1)
  x[[2:3]] <- ee$ImageCollection(c(ee$Image(2), ee$Image(3)))
  x[[3:7]] <- lapply(3:7, function(x) ee$Image(x))
  expect_equal(ee_extract(x, ee$Geometry$Point(c(0, 0))) %>% as.numeric(), 1:7)

  expect_error(x[[1]] <- ee$ImageCollection(c(ee$Image(2), ee$Image(3))))
  expect_error(ic_demo[[0]] <- 1)
  expect_error(ic_demo[[-1]] <- 1)
  expect_error(ic_demo[[1]] <- TRUE)
  expect_error(ic_demo[[TRUE]] <- 1)
})


# test_that("length.ee.imagecollection.ImageCollection", {
#   expect_equal(length(ic_demo), 7)
# })
