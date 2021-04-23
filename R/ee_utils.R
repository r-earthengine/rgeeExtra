#' Display required packages error message
#' @noRd
ee_check_packages <- function(fn_name, packages) {
  pkg_exists <- rep(NA, length(packages))
  counter <- 0
  for(package in packages) {
    counter <- counter + 1
    pkg_exists[counter] <- requireNamespace(package, quietly = TRUE)
  }

  if (!all(pkg_exists)) {
    to_install <- packages[!pkg_exists]
    to_install_len <- length(to_install)
    error_msg <- sprintf(
      "%s required the %s: %s. Please install %s first.",
      crayon::bold(fn_name),
      if (to_install_len == 1) "package" else "packages",
      paste0(crayon::bold(to_install), collapse = ", "),
      if (to_install_len == 1) "it" else "them"
    )
    stop(error_msg)
  }
}
