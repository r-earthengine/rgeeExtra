context("rgeeExtra: subsetting ee.Image")
# -------------------------------------------------------------------------
library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

img <- ee$Image$Dataset$JAXA_ALOS_AW3D30_V2_2

x <- img
index <- c("AVE_DSM", "AVE_MSK")
value <- ee$ImageCollection(c(ee$Image(0), ee$Image(1)))$toBands()


test_that("[[.ee.image.Image", {
  expect_equal(img[[c("AVE_DSM", "AVE_MSK")]], img$select(c("AVE_DSM", "AVE_MSK")))
  # expect_equal(img[[1]]$getInfo(), img$select("AVE_DSM")$getInfo())
  expect_error(img[[0]])
  expect_error(img[[-1]])
  expect_error(img[[TRUE]])
})


test_that("[<-.ee.image.Image", {
  ee_gpoint <- ee$Geometry$Point(c(-72.73529, -14.58297))
  img_dem <- img$select("AVE_DSM")
  img_dem[img_dem > 2000] <- 5000
  expect_equal(ee_extract(img_dem, ee_gpoint)[[1]], 5000)
  expect_error(img_dem[0] <- 2)
})


test_that("[[<-.ee.image.Image", {
  imgs <- img
  ee_gpoint <- ee$Geometry$Point(c(-72.73529, -14.58297))
  imgs[["AVE_DSM"]] <- ee$Image(0)


  expect_equal(ee_extract(imgs[["AVE_DSM"]] * 1, ee_gpoint)[[1]], 0)

  imgs[[1]] <- ee$Image(1)
  expect_equal(ee_extract(imgs[[1]] * 1, ee_gpoint)[[1]], 1)
  expect_error(imgs[["dsdsd"]] <- ee$Image(0))
  expect_error(imgs[[T]] <- ee$Image(0))
  expect_error(imgs[[T]] <- 1)
})

# test_that("names.ee.image.Image", {
#   img_length <- length(ee$Image(1))
#   expect_equal(img_length, 1)
# })

test_that("names<-.ee.image.Image", {
  imx <- ee$Image(1)
  names(imx) <- "cesar"
  expect_equal(names(imx), "cesar")
})

# test_that("[[<-.ee.image.Image", {
#   imgt <- ee$ImageCollection(lapply(1:10, function(x) ee$Image(x)))$toBands()
#   length(imgt) <- 5L
#   expect_equal(length(imgt), 5)
# })


# test_that("length<-.ee.image.Image", {
#   imgt <- ee$ImageCollection(lapply(1:10, function(x) ee$Image(x)))$toBands()
#   length(imgt) <- 10
#   expect_equal(length(imgt), 10)
#   length(imgt) <- 15
#   expect_equal(length(imgt), 15)
# })
