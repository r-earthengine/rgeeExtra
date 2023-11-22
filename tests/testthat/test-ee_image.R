context("rgee: ee_image simple test")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

test_that("ee$Image$Extra_getCitation", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_getCitation() -> eestr
  expect_is(eestr, "character")
})

test_that("ee$Image$Extra_getDOI", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_getDOI() -> eestr
  expect_is(eestr, "character")
})

test_that("ee$ImageCollection$Extra_getOffsetParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_getOffsetParams() -> eestr
  expect_is(eestr, "list")
})

test_that("ee$Image$Extra_getScaleParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_getScaleParams() -> eestr
  expect_is(eestr, "list")
})

test_that("ee$Image$Extra_getSTAC", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_getSTAC() -> eestr
  expect_is(eestr, "list")
})

test_that("ee$Image$Extra_matchHistogram", {
  source <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
  target <-ee$Image("LANDSAT/LE07/C01/T1_TOA/LE07_046027_20150701")
  bands <- list("B4"="B3", "B3"="B2", "B2"="B1")
  matched <- ee$Image$Extra_matchHistogram(source, target, bands)
  expect_is(matched, "ee.image.Image")
})

test_that("ee$Image$Extra_preprocess", {
  ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_preprocess() -> eestr
  expect_is(eestr, "ee.image.Image")
})

test_that("ee_Image_spectralIndex", {
  s2_indices <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_preprocess()%>%
    ee$Image$Extra_spectralIndex(c("NDVI", "SAVI"))
  expect_is(s2_indices, "ee.image.Image")
})

test_that("ee$Image$Extra_panSharpen", {
  img <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
  img_sharp <- ee$Image$Extra_panSharpen(img, method="HPFA", qa=c("MSE", "RMSE"), maxPixels=1e13)
  expect_is(img_sharp, "ee.image.Image")
})

test_that("ee$Image$Extra_maskClouds", {
  img <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_maskClouds(prob = 75,buffer = 300,cdi = -0.5)
  expect_is(img, "ee.image.Image")
})

test_that("ee$Image$Extra_tasseledCap", {
  img <- ee$Image("LANDSAT/LT05/C01/T1/LT05_044034_20081011")
  img <- ee$Image$Extra_tasseledCap(img)
  expect_is(img, "ee.image.Image")
})

test_that("ee_Image_scaleAndOffset", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$Extra_scaleAndOffset() -> eestr
  expect_is(eestr, "ee.image.Image")
})

