context("rgee: Operators test")
skip_if_no_pypkg()
# -------------------------------------------------------------------------

test_that("Arithmetic Operator", {
  img <- ee$Image(1)
  img_m <- ee$ImageCollection(c(ee$Image(1), ee$Image(2)))$toBands()

  # sum
  expect_equal((img + img), (img$add(img)))
  expect_equal((img_m + img_m), (img_m$add(img_m)))

  # subtract
  expect_equal((img - img), (img$subtract(img)))
  expect_equal((img_m - img_m), (img_m$subtract(img_m)))

  # Negative (-) 1 -> -1
  expect_equal(ee_extract(-img, ee$Geometry$Point(0, 0))$layer, -1)
  expect_equal(ee_extract(-img_m, ee$Geometry$Point(0, 0))$layer_0001, -1)

  # multiply
  expect_equal(ee_extract(2 * img, ee$Geometry$Point(0, 0))$layer, 2)
  expect_equal(ee_extract(2 * img_m, ee$Geometry$Point(0, 0))$layer_0001, 2)

  # pow
  expect_equal(ee_extract(2 ** img, ee$Geometry$Point(0, 0))$layer, 2)
  expect_equal(ee_extract(2 ** img_m, ee$Geometry$Point(0, 0))$layer_0001, 2)

  # Module %%
  expect_equal(ee_extract(img %% 3, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(img_m %% 3, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # Integer division %/%
  expect_equal(ee_extract(img %/% 2, ee$Geometry$Point(0, 0))$layer, 0)
  expect_equal(ee_extract(img_m %/% 2, ee$Geometry$Point(0, 0))$layer_0001, 0)

  # Division /
  expect_equal(ee_extract(img / 2, ee$Geometry$Point(0, 0))$layer, 0.5)
  expect_equal(ee_extract(img_m / 2, ee$Geometry$Point(0, 0))$layer_0001, 0.5)
})


test_that("Logic Operator", {
  img <- ee$Image(0)
  img_m <- ee$ImageCollection(c(ee$Image(0), ee$Image(0)))$toBands()

  # Not !
  expect_equal(ee_extract(!img, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(!img_m, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # And &
  expect_equal(ee_extract(img & TRUE, ee$Geometry$Point(0, 0))$layer, 0)
  expect_equal(ee_extract(img_m & TRUE, ee$Geometry$Point(0, 0))$layer_0001, 0)

  # Or |
  expect_equal(ee_extract(1 | img, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(1 | img_m, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # eq ==
  expect_equal(ee_extract(1 == img, ee$Geometry$Point(0, 0))$layer, 0)
  expect_equal(ee_extract(1 == img_m, ee$Geometry$Point(0, 0))$layer_0001, 0)

  # neq !=
  expect_equal(ee_extract(1 != img, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(1 != img_m, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # lt <
  expect_equal(ee_extract(10 < img, ee$Geometry$Point(0, 0))$layer, 0)
  expect_equal(ee_extract(10 < img_m, ee$Geometry$Point(0, 0))$layer_0001, 0)

  # lte <=
  expect_equal(ee_extract(0 <= img, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(0 <= img_m, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # gt >
  expect_equal(ee_extract(10 > img, ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(10 > img_m, ee$Geometry$Point(0, 0))$layer_0001, 1)

  # gte >=
  expect_equal(ee_extract(img >= 0 , ee$Geometry$Point(0, 0))$layer, 1)
  expect_equal(ee_extract(img_m >= 0 , ee$Geometry$Point(0, 0))$layer_0001, 1)
})


test_that("Mathematical functions", {
  ee_geom <- ee$Geometry$Point(0, 0)

  # abs
  expect_equal(ee_extract(abs(ee$Image(-10)), ee_geom)$layer, 10)

  # sign
  expect_equal(ee_extract(sign(ee$Image(-10)), ee_geom)$layer, -1)

  # sqrt
  expect_equal(ee_extract(sqrt(ee$Image(10)), ee_geom)$layer, sqrt(10))

  # ceiling
  expect_equal(ee_extract(ceiling(ee$Image(10.4)), ee_geom)$layer, ceiling(10.4))

  # cumsum
  ee_series <- ee_extract(
    x = cumsum(ee$ImageCollection(lapply(1:10, function(x) ee$Image(x)))$toBands()),
    y =  ee_geom
  ) %>% as.numeric()
  expect_equal(ee_series, cumsum(1:10))

  # cumprod
  ee_series <- ee_extract(
    x = cumprod(ee$ImageCollection(lapply(1:10, function(x) ee$Image(x)))$toBands()),
    y =  ee_geom
  ) %>% as.numeric()
  expect_equal(ee_series, cumprod(1:10))

  # log
  expect_equal(ee_extract(log(ee$Image(10)), ee_geom)$layer, log(10))
  expect_equal(
    object = ee_extract(log(ee$Image(10), base = 5), ee_geom)$layer,
    expected = log(10, base = 5),
    tolerance = 1e-07
  )

  # log10
  expect_equal(ee_extract(log10(ee$Image(10)), ee_geom)$layer, log10(10))

  # log1p
  expect_equal(ee_extract(log1p(ee$Image(10)), ee_geom)$layer, log1p(10))

  # log2
  expect_equal(ee_extract(log2(ee$Image(10)), ee_geom)$layer, log2(10))

  # acos
  expect_equal(ee_extract(acos(ee$Image(0.1)), ee_geom)$layer, acos(0.1))

  # floor
  expect_equal(ee_extract(floor(ee$Image(0.1)), ee_geom)$layer, floor(0.1))

  # asin
  expect_equal(
    object = ee_extract(asin(ee$Image(0.1)), ee_geom)$layer,
    expected = asin(0.1),
    tolerance = 1e-07
  )

  # atan
  expect_equal(
    object = ee_extract(atan(ee$Image(0.1)), ee_geom)$layer,
    expected = atan(0.1),
    tolerance = 1e-07
  )

  # exp
  expect_equal(
    object = ee_extract(exp(ee$Image(0.1)), ee_geom)$layer,
    expected = exp(0.1),
    tolerance = 1e-07
  )

  # expm1
  expect_equal(
    object = ee_extract(expm1(ee$Image(0.1)), ee_geom)$layer,
    expected = expm1(0.1),
    tolerance = 1e-07
  )

  # cos
  expect_equal(
    object = ee_extract(cos(ee$Image(0.1)), ee_geom)$layer,
    expected = cos(0.1),
    tolerance = 1e-07
  )

  # cosh
  expect_equal(
    object = ee_extract(cosh(ee$Image(0.1)), ee_geom)$layer,
    expected = cosh(0.1),
    tolerance = 1e-07
  )

  # sin
  expect_equal(
    object = ee_extract(sin(ee$Image(0.1)), ee_geom)$layer,
    expected = sin(0.1),
    tolerance = 1e-07
  )

  # sinh
  expect_equal(
    object = ee_extract(sinh(ee$Image(0.1)), ee_geom)$layer,
    expected = sinh(0.1),
    tolerance = 1e-07
  )

  # tan
  expect_equal(
    object = ee_extract(tan(ee$Image(0.1)), ee_geom)$layer,
    expected = tan(0.1),
    tolerance = 1e-07
  )

  # tanh
  expect_equal(
    object = ee_extract(tanh(ee$Image(0.1)), ee_geom)$layer,
    expected = tanh(0.1),
    tolerance = 1e-07
  )
})


test_that("Summary functions", {
  ee_geom <- ee$Geometry$Point(0, 0)

  # mean Image
  mean_img <- mean(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(ee_extract(mean_img, ee_geom)$layer, 1.5)

  # max Image
  max_img <- max(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(ee_extract(max_img, ee_geom)$layer, 3)

  # min Image
  min_img <- min(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(ee_extract(min_img, ee_geom)$layer, 0)

  # range Image
  range_img <- range(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(mean(as.numeric(ee_extract(range_img, ee_geom))), 1.5)

  # sum Image
  sum_img <- sum(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(ee_extract(sum_img, ee_geom)$layer, 6)

  prod_img <- prod(ee$Image(0), ee$Image(1), ee$Image(2), ee$Image(3))
  expect_equal(ee_extract(prod_img, ee_geom)$layer, 0)
}
)


test_that("Extra functions", {

})
