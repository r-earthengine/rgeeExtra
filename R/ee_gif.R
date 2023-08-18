#' Create a GIF from an Earth Engine ImageCollection
#'
#' Create an GIF (as a magick-image object) from a EE
#' ImageCollection. Note: Animations can only be created when ImageCollections
#' is composed by RGB or RGBA image. This can be done by mapping
#' a visualization function onto an ImageCollection
#' (e.g. \code{ic$map(function(img) img$visualize(...))})
#' or specifying three bands in parameters argument (See examples).
#' [ee_utils_gif_creator] is a
#' wrapper around \strong{\code{ee$ImageCollection$getVideoThumbURL}}.
#'
#' @author Jeroen Ooms
#'
#' @param ic An ee$ImageCollection.
#' @param parameters List of parameters for visualization and animation. See details.
#' @param quiet Logical. Suppress info message.
#' @param ... parameter(s) passed on to [download.file][utils::download.file]
#' @details
#' The parameters argument is identical to visParams (See \code{rgee::Map$addLayer}),
#' plus, optionally:
#' \itemize{
#'  \item \strong{dimensions}: A number or pair of numbers in format c(WIDTH,HEIGHT).
#'  Max dimensions of the thumbnail to render, in pixels. If only one number is
#'  passed, it is used as the maximum, and the other dimension is computed by
#'  proportional scaling.
#'  \item \strong{crs}: A CRS string specifying the projection of the output.
#'  \item \strong{crs_transform}: The affine transform to use for the output
#'  pixel grid.
#'  \item \strong{scale}: A scale to determine the output pixel grid; ignored if
#'  both crs and crs_transform are specified.
#'  \item \strong{region}: ee$Geometry$Polygon, GeoJSON or c(E,S,W,N). Geospatial
#'  region of the result. By default, the whole image.
#'  \item \strong{format}: String. The output format (only 'gif' is currently
#'  supported).
#'  \item \strong{framesPerSecond}: String. Animation speed.
#' }
#' @return A magick-image object of the specified ImageCollection.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' col <- ee$ImageCollection("JRC/GSW1_1/YearlyHistory")$map(function(img) {
#'   year <- img$date()$get("year")
#'   yearImg <- img$gte(2)$multiply(year)
#'   despeckle <- yearImg$connectedPixelCount(15, TRUE)$eq(15)
#'   yearImg$updateMask(despeckle)$selfMask()$set("year", year)
#' })
#'
#' appendReverse <- function(col) col$merge(col$sort('year', FALSE))
#'
#' # -----------------------------------
#' # 1 Basic Animation - Ucayali Peru
#' # -----------------------------------
#'
#' bgColor = "FFFFFF" # Assign white to background pixels.
#' riverColor = "0D0887" # Assign blue to river pixels.
#'
#' ## 1.1 Create the dataset
#' annualCol = col$map(function(img) {
#'   img$unmask(0)$
#'     visualize(min = 0, max = 1, palette = c(bgColor, riverColor))$
#'     set("year", img$get("year"))
#' })
#' basicAnimation <- appendReverse(annualCol)
#'
#'
#' ## 1.2 Set video arguments
#' aoi <- ee$Geometry$Rectangle(-74.327, -10.087, -73.931, -9.327)
#' videoArgs = list(
#'   dimensions = 600, # Max dimension (pixels), min dimension is proportionally scaled.
#'   region = aoi,
#'   framesPerSecond = 10
#' )
#'
#' ## 1.2 Download, display and save the GIF!
#' animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
#' get_years <- basicAnimation$aggregate_array("year")$getInfo()
#' animation %>%
#'   ee_utils_gif_annotate("Ucayali, Peru") %>%
#'   ee_utils_gif_annotate(get_years, size = 15, location = "+90+40",
#'                         boxcolor = "#FFFFFF") %>%
#'   ee_utils_gif_annotate("created using {magick} + {rgee}",
#'                         size = 15, font = "sans",location = "+70+20") ->
#'   animation_wtxt
#' gc(reset = TRUE)
#' ee_utils_gif_save(animation_wtxt, path = paste0(tempfile(), ".gif"))
#' }
#' @family GIF functions
#' @export
ee_utils_gif_creator <- function(ic, parameters, quiet = FALSE, ...) {
  # check packages
  ee_check_packages("ee_utils_gif_creator", "magick")

  if (!quiet) {
    message("1. Creating gif ... please wait ....")
  }
  animation_url <- rgee::ee$ImageCollection$getVideoThumbURL(ic, parameters)
  temp_gif <- tempfile()
  if (!quiet) {
    message("1. Downloading GIF from: ", animation_url)
  }
  utils::download.file(
    url = animation_url,
    destfile = temp_gif,
    quiet = TRUE,
    ...)
  magick::image_read(path = temp_gif)
}


#' Add text to a GIF
#'
#' Add text to a GIF (magick-image object). This function is a wrapper around
#' [image_annotate][magick::image_annotate].
#'
#' @author Jeroen Ooms
#'
#' @param image magick image object returned by [magick::image_read()] or [magick::image_graph()]
#' @param text character vector of length equal to 'image' or length 1
#' @param gravity string with [gravity](https://www.imagemagick.org/Magick++/Enumerations.html#GravityType)
#' value from [gravity_types][magick::gravity_types].
#' @param location geometry string with location relative to `gravity`
#' @param degrees rotates text around center point
#' @param size font-size in pixels
#' @param font string with font family such as `"sans"`, `"mono"`, `"serif"`,
#' `"Times"`, `"Helvetica"`, `"Trebuchet"`, `"Georgia"`, `"Palatino"` or `"Comic Sans"`.
#' @param style value of [style_types][magick::style_types] for example `"italic"`
#' @param weight thickness of the font, 400 is normal and 700 is bold.
#' @param kerning increases or decreases whitespace between letters
#' @param decoration value of [decoration_types][magick::decoration_types] for example `"underline"`
#' @param color a valid [color string](https://www.imagemagick.org/Magick++/Color.html) such as
#' `"navyblue"` or `"#000080"`. Use `"none"` for transparency.
#' @param strokecolor a [color string](https://www.imagemagick.org/Magick++/Color.html)
#' adds a stroke (border around the text)
#' @param boxcolor a [color string](https://www.imagemagick.org/Magick++/Color.html)
#' for background color that annotation text is rendered on.
#'
#' @return A magick-image object
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' col <- ee$ImageCollection("JRC/GSW1_1/YearlyHistory")$map(function(img) {
#'   year <- img$date()$get("year")
#'   yearImg <- img$gte(2)$multiply(year)
#'   despeckle <- yearImg$connectedPixelCount(15, TRUE)$eq(15)
#'   yearImg$updateMask(despeckle)$selfMask()$set("year", year)
#' })
#'
#' appendReverse <- function(col) col$merge(col$sort('year', FALSE))
#'
#' # -----------------------------------
#' # 1 Basic Animation - Ucayali Peru
#' # -----------------------------------
#'
#' bgColor = "FFFFFF" # Assign white to background pixels.
#' riverColor = "0D0887" # Assign blue to river pixels.
#'
#' ## 1.1 Create the dataset
#' annualCol = col$map(function(img) {
#'   img$unmask(0)$
#'     visualize(min = 0, max = 1, palette = c(bgColor, riverColor))$
#'     set("year", img$get("year"))
#' })
#' basicAnimation <- appendReverse(annualCol)
#'
#'
#' ## 1.2 Set video arguments
#' aoi <- ee$Geometry$Rectangle(-74.327, -10.087, -73.931, -9.327)
#' videoArgs = list(
#'   dimensions = 600, # Max dimension (pixels), min dimension is proportionally scaled.
#'   region = aoi,
#'   framesPerSecond = 10
#' )
#'
#' ## 1.2 Download, display and save the GIF!
#' animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
#' get_years <- basicAnimation$aggregate_array("year")$getInfo()
#' animation %>%
#'   ee_utils_gif_annotate("Ucayali, Peru") %>%
#'   ee_utils_gif_annotate(get_years, size = 15, location = "+90+40",
#'                         boxcolor = "#FFFFFF") %>%
#'   ee_utils_gif_annotate("created using {magick} + {rgee}",
#'                         size = 15, font = "sans",location = "+70+20") ->
#'   animation_wtxt
#' gc(reset = TRUE)
#' ee_utils_gif_save(animation_wtxt, path = paste0(tempfile(), ".gif"))
#' }
#' @family GIF functions
#' @export
ee_utils_gif_annotate <- function(image,
                                  text,
                                  gravity = "northwest",
                                  location = "+0+0",
                                  degrees = 0,
                                  size = 20,
                                  font = "sans",
                                  style = "normal",
                                  weight = 400,
                                  kerning = 0,
                                  decoration = NULL,
                                  color = NULL,
                                  strokecolor = NULL,
                                  boxcolor = NULL) {
  # check packages
  ee_check_packages("ee_utils_gif_annotate", "magick")

  if (length(text) == 1) {
    image <- magick::image_annotate(image, text, gravity = gravity,
                                    location = location, degrees = degrees, size = size,
                                    font = font, style = style, weight = weight,
                                    kerning = kerning, decoration = decoration,
                                    color = color, strokecolor = strokecolor,
                                    boxcolor = boxcolor)
  } else if(length(text) == length(image)) {
    image <- magick::image_annotate(image, text, gravity = gravity,
                                    location = location, degrees = degrees, size = size,
                                    font = font, style = style, weight = weight,
                                    kerning = kerning, decoration = decoration,
                                    color = color, strokecolor = strokecolor,
                                    boxcolor = boxcolor)
  } else {
    stop(
      "The text argument has not the same length as the magick-image object",
      "\nActual:",length(text),
      "\nExpected:", length(image)
    )
  }
  image
}


#' Write a GIF
#'
#' Write a magick-image object as a GIF file using the \code{magick} package. This
#' function is a wrapper around [image_write][magick::image_write].
#'
#' @author Jeroen Ooms
#'
#' @param image magick image object returned by [image_read][magick::image_read].
#' @param path path a file, url, or raster object or bitmap array.
#' @param format output format such as `"png"`, `"jpeg"`, `"gif"`, `"rgb"` or `"rgba"`.
#' @param quality number between 0 and 100 for jpeg quality. Defaults to 75.
#' @param depth color depth (either 8 or 16).
#' @param density resolution to render pdf or svg.
#' @param comment text string added to the image metadata for supported formats.
#' @param flatten should the image be flattened before writing? This also replaces
#' transparency with a background color.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize()
#'
#' col <- ee$ImageCollection("JRC/GSW1_1/YearlyHistory")$map(function(img) {
#'   year <- img$date()$get("year")
#'   yearImg <- img$gte(2)$multiply(year)
#'   despeckle <- yearImg$connectedPixelCount(15, TRUE)$eq(15)
#'   yearImg$updateMask(despeckle)$selfMask()$set("year", year)
#' })
#'
#' appendReverse <- function(col) col$merge(col$sort('year', FALSE))
#'
#' # -----------------------------------
#' # 1 Basic Animation - Ucayali Peru
#' # -----------------------------------
#'
#' bgColor = "FFFFFF" # Assign white to background pixels.
#' riverColor = "0D0887" # Assign blue to river pixels.
#'
#' ## 1.1 Create the dataset
#' annualCol = col$map(function(img) {
#'   img$unmask(0)$
#'     visualize(min = 0, max = 1, palette = c(bgColor, riverColor))$
#'     set("year", img$get("year"))
#' })
#' basicAnimation <- appendReverse(annualCol)
#'
#'
#' ## 1.2 Set video arguments
#' aoi <- ee$Geometry$Rectangle(-74.327, -10.087, -73.931, -9.327)
#' videoArgs = list(
#'   dimensions = 600, # Max dimension (pixels), min dimension is proportionally scaled.
#'   region = aoi,
#'   framesPerSecond = 10
#' )
#'
#' ## 1.2 Download, display and save the GIF!
#' animation <- ee_utils_gif_creator(basicAnimation, videoArgs, mode = "wb")
#' get_years <- basicAnimation$aggregate_array("year")$getInfo()
#' animation %>%
#'   ee_utils_gif_annotate("Ucayali, Peru") %>%
#'   ee_utils_gif_annotate(get_years, size = 15, location = "+90+40",
#'                         boxcolor = "#FFFFFF") %>%
#'   ee_utils_gif_annotate("created using {magick} + {rgee}",
#'                         size = 15, font = "sans",location = "+70+20") ->
#'   animation_wtxt
#' gc(reset = TRUE)
#' ee_utils_gif_save(animation_wtxt, path = paste0(tempfile(), ".gif"))
#' }
#' @family GIF functions
#' @return No return value, called to write a GIF file.
#' @export
ee_utils_gif_save <- function(image,
                              path = NULL,
                              format = NULL,
                              quality = NULL,
                              depth = NULL,
                              density = NULL,
                              comment = NULL,
                              flatten = FALSE) {

  # check packages
  ee_check_packages("ee_utils_gif_save", "magick")
  magick::image_write(image = image, path = path, format = format,
                      quality = quality, depth = depth, density = density,
                      comment = comment, flatten = flatten)
  return(TRUE)
}


