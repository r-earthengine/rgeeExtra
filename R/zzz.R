.onAttach <- function(libname, pkgname) {
  options(rgee.print.option = "simply")
}

.onLoad <- function(libname, pkgname) {
  # Load Python package available in inst/ folder.
  ee_extra_location <- sprintf("%s/ee_extra", system.file(package = "rgeeExtra"))
  EEextra_PYTHON_PACKAGE <<- reticulate::import_from_path("ee_extra", ee_extra_location)
}

