#' Earth Engine arithmetic, logic and compare generic functions
#'
#' Arithmetic, logic and compare operators for computation with \code{ee$Image}
#' objects and numeric values.
#'
#' \itemize{
#'   \item \strong{Arith}: +, -, *, /, ^, %%, %/%, %>>% and %>>%.
#'   \item \strong{Logic}: !, &, |.
#'   \item \strong{Comparison}: ==, !=, >, <, <=, >=
#' }
#'
#' @param e1 Numeric or ee$Image.
#' @param e2 Numeric or ee$Image.
#'
#' @examples
#' \dontrun{
#' library(rgee)
#' ee_Initialize()
#'
#' # Sum Operator
#' ee1 <- ee$Image(1)
#' ee2 <- ee$Image(2)
#' ee3 <- ee1 + ee2
#' ee_extract(ee3, ee$Geometry$Point(0, 0))
#'
#' v1 <- 1
#' v2 <- 2
#' v3 <- v1 + v2
#' v3
#'
#' # Multiple Operators
#' ee4 <- ee1 / 10
#' ee5 <- ee4 * (ee2 - 1 + ee1^2 / ee2)
#' ee_extract(ee5, ee$Geometry$Point(0, 0))
#'
#' v4 <- v1 / 10
#' v5 <- v4 * (v2 - 1 + v1^2 / v2)
#' v5
#'
#' # multi-layer object mutiplication, no recycling
#' ee6 <- ee1 + c(1, 5, 10)
#' ee_extract(ee6, ee$Geometry$Point(0, 0))
#'
#' v6 <- v1 + c(1, 5, 10)
#' v6
#' }
#' @name Ops-methods
#' @export
Ops.ee.image.Image <- function(e1, e2) {

  # Convert logical values to numeric.
  if (!missing(e2)) {
    if (is.logical(e2)) {
      e2 <- as.numeric(e2)
    }
  }

  if (is.logical(e1)) {
    e1 <- as.numeric(e1)
  }

  # Operators
  # If e2 is numeric the results persit the initial name oterwise it is
  # replaced by "layer"
  if (.Generic == "+") {
    if (missing(e2)) {
      ops_r <- e1
    } else {
      ops_r <- rgee::ee$Image(e1)$add(rgee::ee$Image(e2))
    }
  } else if(.Generic == "-") {
    if (missing(e2)) {
      ops_r <- e1$multiply(-1L)
    } else {
      ops_r <- rgee::ee$Image(e1)$subtract(rgee::ee$Image(e2))
    }
  } else if(.Generic == "*") {
    ops_r <- rgee::ee$Image(e1)$multiply(rgee::ee$Image(e2))
  } else if(.Generic == "^") {
    ops_r <- rgee::ee$Image(e1)$pow(rgee::ee$Image(e2))
  } else if(.Generic == "%%") {
    ops_r <- rgee::ee$Image(e1)$mod(rgee::ee$Image(e2))
  } else if(.Generic == "%/%") {
    ops_r <- rgee::ee$Image(e1)$divide(rgee::ee$Image(e2))$toInt64()
  } else if(.Generic == "/") {
    ops_r <- rgee::ee$Image(e1)$divide(rgee::ee$Image(e2))
  } else if (.Generic == "!") {
    if (missing(e2)) {
      ops_r <- rgee::ee$Image(e1)$Not()
    } else {
      stop("Unexpected use of !")
    }
  } else if(.Generic == "&") {
    ops_r <- rgee::ee$Image(e1)$And(rgee::ee$Image(e2))
  } else if(.Generic == "|") {
    ops_r <- rgee::ee$Image(e1)$Or(rgee::ee$Image(e2))
  } else if(.Generic == "==") {
    ops_r <- rgee::ee$Image(e1)$eq(rgee::ee$Image(e2))
  } else if(.Generic == "!=") {
    ops_r <- rgee::ee$Image(e1)$neq(rgee::ee$Image(e2))
  } else if(.Generic == "<") {
    ops_r <- rgee::ee$Image(e1)$lt(rgee::ee$Image(e2))
  } else if(.Generic == "<=") {
    ops_r <- rgee::ee$Image(e1)$lte(rgee::ee$Image(e2))
  } else if(.Generic == ">") {
    ops_r <- rgee::ee$Image(e1)$gt(rgee::ee$Image(e2))
  }  else if(.Generic == ">=") {
    ops_r <- rgee::ee$Image(e1)$gte(rgee::ee$Image(e2))
  }

  # Export results
  if (is.numeric(e2)) {
    ops_r
  } else {
    ops_r$rename("layer")
  }
}


#' Mathematical functions
#'
#' @param x ee$Image
#' @param ... Ignored
#'
#' Generic mathematical functions that can be used with an \code{ee$Image}
#' object as argument: \code{abs}, \code{sign}, \code{sqrt}, \code{ceiling},
#' \code{cumprod}, \code{cumsum}, \code{log}, \code{log10}, \code{log1p},
#' \code{log2}, \code{acos}, \code{floor}, \code{asin}, \code{atan}, \code{exp},
#' \code{expm1}, \code{cos}, \code{cosh}, \code{sin}, \code{sinh},
#' \code{tan}, and \code{tanh}.
#'
#' @name Math-methods
#' @export
Math.ee.image.Image <- function(x, ...) {
  if (.Generic == "abs") {
    rgee::ee$Image$abs(x)
  } else if(.Generic == "sign") {
    rgee::ee$Image$signum(x$float())
  } else if(.Generic == "sqrt") {
    rgee::ee$Image$sqrt(x)
  } else if(.Generic == "floor") {
    rgee::ee$Image$floor(x)
  } else if(.Generic == "ceiling") {
    rgee::ee$Image$ceil(x)
  } else if(.Generic == "round") {
    rgee::ee$Image$round(x)
  } else if(.Generic == "log") {
    args <- list(...)
    if (length(args) == 0) {
      rgee::ee$Image$log(x) / rgee::ee$Image$log(rgee::ee$Image$exp(1))
    } else {
      if (is.null(args$base)) {
        stop("Unused argument.")
      }
      rgee::ee$Image$log(x) / rgee::ee$Image$log(rgee::ee$Image(args$base))
    }
  } else if(.Generic == "log10") {
    rgee::ee$Image$log10(x)
  } else if(.Generic == "log2") {
    rgee::ee$Image$log(x) / rgee::ee$Image$log(2)
  } else if(.Generic == "log1p") {
    rgee::ee$Image$log(x + 1)
  } else if(.Generic == "exp") {
    rgee::ee$Image$exp(x)
  } else if(.Generic == "expm1") {
    rgee::ee$Image$exp(x) - 1
  } else if(.Generic == "sin") {
    rgee::ee$Image$sin(x)
  } else if(.Generic == "cos") {
    rgee::ee$Image$cos(x)
  } else if(.Generic == "tan") {
    rgee::ee$Image$tan(x)
  } else if(.Generic == "asin") {
    rgee::ee$Image$asin(x)
  } else if(.Generic == "acos") {
    rgee::ee$Image$acos(x)
  } else if(.Generic == "atan") {
    rgee::ee$Image$atan(x)
  } else if(.Generic == "cosh") {
    rgee::ee$Image$cosh(x)
  } else if(.Generic == "sinh") {
    rgee::ee$Image$sinh(x)
  } else if(.Generic == "tanh") {
    rgee::ee$Image$tanh(x)
  } else if(.Generic == "cumsum") {
    total <- 0
    x_list <- list() # List to save.
    x_bandnames <- x$bandNames()$getInfo() #band names.
    for (index in seq_along(x_bandnames)) {
      total <- total + x[[x_bandnames[[index]]]]
      x_list[[index]] <- total
    }
    rgee::ee$ImageCollection(x_list)$toBands()
  } else if(.Generic == "cumprod") {
    total <- 1
    x_list <- list() # List to save.
    x_bandnames <- x$bandNames()$getInfo() #band names.
    for (index in seq_along(x_bandnames)) {
      total <- total * x[[x_bandnames[[index]]]]
      x_list[[index]] <- total
    }
    rgee::ee$ImageCollection(x_list)$toBands()
  } else {
    stop(sprintf("rgee does not support %s yet.", .Generic))
  }
}

#' Summary Methods
#'
#' @param ... ee$Image.
#' @param na.rm Ignore.
#' @name Summary-methods
#' @export
Summary.ee.image.Image <- function(..., na.rm = TRUE) {
  img <- rgee::ee$ImageCollection(list(...))$toBands()

  if (.Generic == "max") {
    img$reduce(rgee::ee$Reducer$max())
  } else if (.Generic == "min") {
    img$reduce(rgee::ee$Reducer$min())
  } else if (.Generic == "range") {
    img$reduce(rgee::ee$Reducer$minMax())
  } else if (.Generic == "sum") {
    img$reduce(rgee::ee$Reducer$sum())
  } else if (.Generic == "prod") {
    img$reduce(rgee::ee$Reducer$product())
  } else {
    stop(sprintf("rgee does not support %s yet.", .Generic))
  }
}

#' @name Summary-methods
#' @export
mean.ee.image.Image <- function(..., na.rm = TRUE) {
  img <- rgee::ee$ImageCollection(list(...))$toBands()
  img$reduce(rgee::ee$Reducer$mean())
}

