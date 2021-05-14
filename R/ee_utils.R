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


#' Change name
#' @noRd
ee_new_list_name <- function(ee_list, names = "layer") {
  ee_list_length <- rgee::ee$List$length(ee_list)
  ee_list_seq <- rgee::ee$List$sequence(1, ee_list_length)
  ee_list_string <- rgee::ee$List$'repeat'(names, ee_list_length)
  rgee::ee$Algorithms$If(
    ee_list_length$eq(1),
    rgee::ee$List(list(rgee::ee$String(names))),
    rgee::ee$List$zip(ee_list_string, ee_list_seq)$map(
      rgee::ee_utils_pyfunc(
        function(x) {
          string <- x %>% rgee::ee$List$get(0)
          number <- x %>% rgee::ee$List$get(1) %>% rgee::ee$Number$format("_%04d")
          rgee::ee$String$cat(string, number)
        }
      )
    )
  )
}
