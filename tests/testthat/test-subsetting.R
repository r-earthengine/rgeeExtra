context("rgeeExtra: subsetting ee.Image")

library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

# -------------------------------------------------------------------------
ic <- ee$ImageCollection$Dataset$LANDFIRE_Fire_MFRI_v1_2_0
fc <- ee$FeatureCollection$Dataset$WWF_HydroSHEDS_v1_Basins_hybas_1

test_that("ee_get ImageCollection", {
  expect_error(rgeeExtra::ee_get(ic, -1))
  # expect_equal(ic$first()$getInfo(), ee_get(ic, 0:1)$first()$getInfo())
  # expect_equal(ic$first()$getInfo(), ee_get(ic, c(0, 2))$first()$getInfo())
  expect_error(rgeeExtra::ee_get(1:10, 1))
})

test_that("ee_get FeatureCollection", {
  expect_error(rgeeExtra::ee_get(fc, -1))
  expect_is(rgeeExtra::ee_get(fc, 0), "ee.featurecollection.FeatureCollection")
  expect_equal(fc$first()$getInfo(), ee_get(fc, 0:1)$first()$getInfo())
  expect_equal(fc$first()$getInfo(), ee_get(fc, c(0, 2))$first()$getInfo())
})