context("rgeeExtra: GIF creator")
skip_if_no_pypkg()
# -------------------------------------------------------------------------



# -----------------------------------
# Setting data to test ee_gifcreator
# -----------------------------------

col <- ee$ImageCollection("JRC/GSW1_1/YearlyHistory")$map(function(img) {
  year <- img$date()$get("year")
  yearImg <- img$gte(2)$multiply(year)
  despeckle <- yearImg$connectedPixelCount(15, TRUE)$eq(15)
  yearImg$updateMask(despeckle)$selfMask()$set("year", year)
})
appendReverse <- function(col) col$merge(col$sort('year', FALSE))

bgColor = "FFFFFF" # Assign white to background pixels.
riverColor = "0D0887" # Assign blue to river pixels.

## 1.1 Create the dataset
annualCol = col$map(function(img) {
  img$unmask(0)$
    visualize(min = 0, max = 1, palette = c(bgColor, riverColor))$
    set("year", img$get("year"))
})
basicAnimation <- appendReverse(annualCol)


## 1.2 Set video arguments
aoi <- ee$Geometry$Rectangle(-74.327, -10.087, -73.931, -9.327)
videoArgs = list(
  dimensions = 600, # Max dimension (pixels), min dimension is proportionally scaled.
  region = aoi,
  framesPerSecond = 10
)


test_that("ee_utils_gif_creator", {
  animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
  expect_is(animation, "magick-image")
})


test_that("ee_utils_gif_annotate", {
  ## 1.2 Download, display and save the GIF!
  animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
  get_years <- basicAnimation$aggregate_array("year")$getInfo()
  new_animation <- animation %>%
    ee_utils_gif_annotate("Ucayali, Peru") %>%
    ee_utils_gif_annotate(get_years, size = 15, location = "+90+40",
                          boxcolor = "#FFFFFF") %>%
    ee_utils_gif_annotate("created using {magick} + {rgee}",
                          size = 15, font = "sans",location = "+70+20")

  expect_error(ee_utils_gif_annotate(1:10, new_animation))
  expect_is(new_animation, "magick-image")
})


test_that("ee_utils_gif_save", {
  animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
  isit_true <- ee_utils_gif_save(animation, path = paste0(tempfile(), ".gif"))
  expect_true(isit_true)
})
