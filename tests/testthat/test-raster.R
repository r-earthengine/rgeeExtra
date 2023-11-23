library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

img <- ee$ImageCollection$Dataset$LANDSAT_LC08_C01_T1$first()[["B1"]]

test_that("ee$Image$Extra_maxValue/ee$Image$Extra_minValue", {
  expect_type(ee$Image$Extra_maxValue(img), "integer")
  expect_type(ee$Image$Extra_maxValue(img, "Points", sample_size = 1), "integer")
  expect_type(ee$Image$Extra_minValue(img), "integer")
  expect_type(ee$Image$Extra_minValue(img, "Points", sample_size = 1), "integer")

  expect_error(ee$Image$Extra_minValue(img, "points"))
  expect_error(ee$Image$Extra_maxValue(img, "points"))
})


test_that("ee_check_packages", {
  expect_error(rgeeExtra:::ee_check_packages("cesar", "aybar"))
})
