context("rgee: ImageCollection simple test")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()

test_that("ee_ImageCollection_closest", {
  roi <- ee$Geometry$Point(c(-79, -12))
  ee$ImageCollection$Dataset$MODIS_006_MCD12Q1 %>%
    ee_ImageCollection_closest("2020-10-15",  2, "year") %>%
    ee$ImageCollection$first() -> ee_img
  expect_is(ee_img, "ee.image.Image")
})

test_that("ee_ImageCollection_getCitation", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$getCitation() -> eestr
  expect_is(eestr, "character")
})

test_that("ee_ImageCollection_getDOI", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$getDOI() -> eestr
  expect_is(eestr, "character")
})

test_that("ee_ImageCollection_getOffsetParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$getOffsetParams() -> eelist
  expect_is(eelist, "list")
})

test_that("ee_ImageCollection_getScaleParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$getScaleParams() -> eelist
  expect_is(eelist, "list")
})

test_that("ee_ImageCollection_getSTAC", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$getSTAC() -> eelist
  expect_is(eelist, "list")
})

test_that("ee_ImageCollection_spectralIndex", {
  s2_indices <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$preprocess() %>%
    ee$ImageCollection$spectralIndex(c("NDVI", "SAVI"))
  expect_is(s2_indices, "ee.imagecollection.ImageCollection")
})

test_that("ee_ImageCollection_preprocess", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$preprocess() -> eeic
  expect_is(eeic, "ee.imagecollection.ImageCollection")
})

test_that("ee_ImageCollection_scaleAndOffset", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$preprocess()%>%
    ee$ImageCollection$scaleAndOffset() -> eeic
  expect_is(eeic, "ee.imagecollection.ImageCollection")
})

test_that("ee_ImageCollection_panSharpen", {
  img <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
  img_sharp <- ee$ImageCollection$panSharpen(img, method="HPFA", qa=c("MSE", "RMSE"), maxPixels=1e13)
  expect_is(img_sharp, "ee.image.Image")
})

test_that("ee_ImageCollection_tasseledCap", {
  img <- ee$Image("LANDSAT/LT05/C01/T1/LT05_044034_20081011")
  img <- ee$ImageCollection$tasseledCap(img)
  expect_is(img, "ee.image.Image")
})
