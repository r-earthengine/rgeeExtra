context("rgee: ImageCollection simple test")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

test_that("ee$ImageCollection$Extra_closest", {
  roi <- ee$Geometry$Point(c(-79, -12))
  ee$ImageCollection$Dataset$MODIS_006_MCD12Q1 %>%
    ee$ImageCollection$Extra_closest("2020-10-15",  2, "year") %>%
    ee$ImageCollection$first() -> ee_img
  expect_is(ee_img, "ee.image.Image")
})


test_that("ee$ImageCollection$Extra_getCitation", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$Extra_getCitation() -> eestr
  expect_is(eestr, "character")
})

test_that("ee$ImageCollection$Extra_getDOI", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$Extra_getDOI() -> eestr
  expect_is(eestr, "character")
})

test_that("ee$ImageCollection$Extra_getOffsetParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$Extra_getOffsetParams() -> eelist
  expect_is(eelist, "list")
})

test_that("ee$ImageCollection$Extra_getScaleParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$Extra_getScaleParams() -> eelist
  expect_is(eelist, "list")
})

test_that("ee$ImageCollection$Extra_getSTAC", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$Extra_getSTAC() -> eelist
  expect_is(eelist, "list")
})

test_that("ee$ImageCollection$Extra_preprocess", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$Extra_preprocess() -> eeic
  expect_is(eeic, "ee.imagecollection.ImageCollection")
})

test_that("ee$ImageCollection$Extra_scaleAndOffset", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$Extra_preprocess()%>%
    ee$ImageCollection$Extra_scaleAndOffset() -> eeic
  expect_is(eeic, "ee.imagecollection.ImageCollection")
})

