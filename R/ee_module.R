#' Load Javascript modules
#'
#' @param x Character. Javascript module path.
#' @param upgrade Upgrade the js module
#' @param quiet Logical. Suppress info messages.
#'
#' @export
module <- function(x, upgrade = FALSE, quiet = FALSE) {
  # fullname py modules
  mainf <- system.file("ee_extra/ee_extra/JavaScript/main.py", package = "rgeeExtra")
  installf <- system.file("ee_extra/ee_extra/JavaScript/install.py", package = "rgeeExtra")

  # Load them
  mainf_module <- reticulate::py_run_file(mainf)
  installf_module <- reticulate::py_run_file(installf)

  if (!quiet) {
    message(
      sprintf(
        "Installing Js module in: %s",
        installf_module$'_get_ee_sources_path'()
      )
    )
  }
  installf_module$install(x, update = upgrade, quiet = TRUE)
  mainf_module$ee_require(x)
}

#' List Javascript modules available
#'
#' @export
module_list <- function() {
  # fullname py modules
  installf <- system.file("ee_extra/ee_extra/JavaScript/install.py", package = "rgeeExtra")

  # Load them
  installf_module <- reticulate::py_run_file(installf)

  users <- list.files(
    path = paste0(installf_module$'_get_ee_sources_path'(), "/users/"),
    full.names = TRUE
  )

  usersx <- list()
  for (index in seq_along(users)) {
    user <- basename(users[index])
    package <- list.files(users[index])
    if (length(package) != 0) {
      usersx[[index]] <- sprintf("%s:%s", user, package)
    }
  }
  message(paste(unlist(usersx), collapse = "\n"))
}

#' Delete a Js module from your local repository
#' @param x Character. Javascript module path.
#' @export
module_uninstall <- function(x) {
  installf <- system.file("ee_extra/ee_extra/JavaScript/install.py", package = "rgeeExtra")
  installf_module <- reticulate::py_run_file(installf)
  installf_module$uninstall(x)
}
