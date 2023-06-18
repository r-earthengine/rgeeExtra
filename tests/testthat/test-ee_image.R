context("rgee: ee_image simple test")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()

test_that("ee_image_getCitation", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$getCitation() -> eestr
  expect_is(eestr, "character")
})

test_that("ee_image_getDOI", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$getDOI() -> eestr
  expect_is(eestr, "character")
})

test_that("ee_Image_getOffsetParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$ImageCollection$getOffsetParams() -> eestr
  expect_is(eestr, "list")
})

test_that("ee_Image_getScaleParams", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$ImageCollection$getScaleParams() -> eestr
  expect_is(eestr, "list")
})

test_that("ee_Image_getSTAC", {
  ee$ImageCollection("NASA/GPM_L3/IMERG_V06") %>%
    ee$ImageCollection$first() %>%
    ee$Image$getSTAC() -> eestr
  expect_is(eestr$getInfo(), "list")
})

test_that("ee_Image_matchHistogram", {
  source <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
  target <-ee$Image("LANDSAT/LE07/C01/T1_TOA/LE07_046027_20150701")
  bands <- list("B4"="B3", "B3"="B2", "B2"="B1")
  matched <- ee$Image$matchHistogram(source, target, bands)
  expect_is(matched, "ee.image.Image")
})

test_that("ee_Image_preprocess", {
  ee$ImageCollection$Dataset$COPERNICUS_S2_SR %>%
    ee$ImageCollection$first() %>%
    ee$Image$preprocess() -> eestr
  expect_is(eestr, "ee.image.Image")
})

test_that("ee_Image_spectralIndex", {
  s2_indices <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$preprocess()%>%
    ee$Image$spectralIndex(c("NDVI", "SAVI"))
  expect_is(s2_indices, "ee.image.Image")
})

test_that("ee_Image_panSharpen", {
  img <- ee$Image("LANDSAT/LC08/C01/T1_TOA/LC08_047027_20160819")
  img_sharp <- ee$Image$panSharpen(img, method="HPFA", qa=c("MSE", "RMSE"), maxPixels=1e13)
  expect_is(img_sharp, "ee.image.Image")
})

test_that("ee_Image_maskClouds", {
  img <- ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$maskClouds(prob = 75,buffer = 300,cdi = -0.5)
  expect_is(img, "ee.image.Image")
})

test_that("ee_Image_tasseledCap", {
  img <- ee$Image("LANDSAT/LT05/C01/T1/LT05_044034_20081011")
  img <- ee$Image$tasseledCap(img)
  expect_is(img, "ee.image.Image")
})

test_that("ee_Image_scaleAndOffset", {
  ee$ImageCollection("COPERNICUS/S2_SR") %>%
    ee$ImageCollection$first() %>%
    ee$Image$scaleAndOffset() -> eestr
  expect_is(eestr, "ee.image.Image")
})

