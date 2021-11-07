#' Load Javascript modules
#'
#' Import a specified Earth Engin Javascript  module,
#' making it available for use from R.
#'
#' @param x Character. Javascript module path.
#' @param upgrade Upgrade the Js module
#' @param quiet Logical. Suppress info messages.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize("csaybar")
#'
#' # 1. load Javascript module
#' x <- "users/sofiaermida/landsat_smw_lst:modules/Landsat_LST.js"
#' LandsatLST <- module(x)
#' # module_uninstall(x)
#'
#' # 2. Set hyperparameters
#' geometry <- ee$Geometry$Rectangle(c(-8.91, 40.0, -8.3, 40.4))
#' satellite <- "L8"
#' date_start <- "2018-05-15"
#' date_end <- "2018-05-31"
#' use_ndvi <- TRUE
#'
#' # 3. Use Javascript module
#' LandsatColl <- LandsatLST$collection(
#'   landsat = satellite,
#'   date_start = date_start,
#'   date_end = date_end,
#'   geometry = geometry,
#'   use_ndvi = use_ndvi
#' )
#' exImage <- LandsatColl$first()
#'
#' # 4. Display results
#' cmap <- c('blue', 'cyan', 'green', 'yellow', 'red')
#' lmod <- list(min = 290, max = 320, palette = cmap)
#' Map$centerObject(geometry)
#' Map$addLayer(exImage$select('LST'), lmod, 'LST')
#' }
#' @export
module <- function(x, upgrade = FALSE, quiet = FALSE) {
  # install module
  ee_install <- EEextra_PYTHON_PACKAGE$JavaScript$install

  # Load the package if return error, first install it!
  tryCatch(
    expr = EEextra_PYTHON_PACKAGE$require(x),
    error = function(e) {
      EEextra_PYTHON_PACKAGE$install(
        x = x,
        update = upgrade,
        quiet = TRUE
      )
      if (!quiet) {
        message(
          sprintf(
            "Installing Js module in: %s",
            ee_install$'_get_ee_sources_path'()
          )
        )
      }
      EEextra_PYTHON_PACKAGE$install(
        x = x,
        update = upgrade,
        quiet = TRUE
      )
      EEextra_PYTHON_PACKAGE$require(x)
    }
  )
}

#' Delete a Js module from your local repository
#' @param x Character. Javascript module path.
#' @examples
#' \dontrun{
#' library(rgee)
#' library(rgeeExtra)
#'
#' ee_Initialize("csaybar")
#'
#' x <- "users/sofiaermida/landsat_smw_lst:modules/Landsat_LST.js"
#' LandsatLST <- module(x)
#' module_uninstall(x)
#' }
#' @export
module_uninstall <- function(x) {
  ee_install <- EEextra_PYTHON_PACKAGE$JavaScript$install
  ee_install$uninstall(x)
}
