library(rgee)
library(rgeeExtra)

ee_Initialize()
extra_Initialize()

test_that("ee_utils_gif_creator", {
  col <- ee$ImageCollection("JRC/GSW1_1/YearlyHistory")$map(function(img) {
    year <- img$date()$get("year")
    yearImg <- img$gte(2)$multiply(year)
    despeckle <- yearImg$connectedPixelCount(15, TRUE)$eq(15)
    yearImg$updateMask(despeckle)$selfMask()$set("year", year)
  })

  appendReverse <- function(col) col$merge(col$sort('year', FALSE))

  # -----------------------------------
  # 1 Basic Animation - Ucayali Peru
  # -----------------------------------

  bgColor <- "FFFFFF" # Assign white to background pixels.
  riverColor <- "0D0887" # Assign blue to river pixels.

  ## 1.1 Create the dataset
  annualCol <- col$map(function(img) {
    img$unmask(0)$
      visualize(min = 0, max = 1, palette = c(bgColor, riverColor))$
      set("year", img$get("year"))
  })
  basicAnimation <- appendReverse(annualCol)


  ## 1.2 Set video arguments
  aoi <- ee$Geometry$Rectangle(-74.327, -10.087, -73.931, -9.327)
  videoArgs <- list(
    dimensions = 600, # Max dimension (pixels), min dimension is proportionally scaled.
    region = aoi,
    framesPerSecond = 10
  )

  ## 1.2 Download, display and save the GIF!
  animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
  get_years <- basicAnimation$aggregate_array("year")$getInfo()
  animation %>%
    ee_utils_gif_annotate("Ucayali, Peru") %>%
    ee_utils_gif_annotate(get_years, size = 15, location = "+90+40",
                          boxcolor = "#FFFFFF") %>%
    ee_utils_gif_annotate("created using {magick} + {rgee}",
                          size = 15, font = "sans",location = "+70+20") ->
    animation_wtxt
  gc(reset = TRUE)
  ee_utils_gif_save(animation_wtxt, path = paste0(tempfile(), ".gif"))
  expect_s3_class(animation_wtxt, "magick-image")
})
