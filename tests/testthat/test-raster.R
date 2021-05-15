context("rgee: Operators test")
skip_if_no_pypkg()
# -------------------------------------------------------------------------

img <- ee$Image$Dataset$JAXA_ALOS_AW3D30_V2_2$unmask(-999)

test_that("ee_maxValue/ee_minValue", {
  expect_type(ee_maxValue(img)[["AVE_DSM"]], "integer")
  expect_type(ee_maxValue(img, "Points", sample_size = 1)[["AVE_DSM"]], "integer")
  expect_type(ee_minValue(img)[["AVE_DSM"]], "integer")
  expect_type(ee_minValue(img, "Points", sample_size = 1)[["AVE_DSM"]], "integer")

  expect_error(ee_minValue(img, "points"))
  expect_error(ee_maxValue(img, "points"))
})


test_that("ee_check_packages", {
  expect_error(rgeeExtra:::ee_check_packages("cesar", "aybar"))
})
