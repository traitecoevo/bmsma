#' Run a linear model in Stan
#'
#' @param x vector of numeric or integer predictor variable
#' @param y vector of numeric or integer response variable
#' @param ... additional arguments passed to rstan::sampling
#'
#' @return stanfit model output
#' @export
#'
#' @examples
#' mtcars
#' rmot_lm(mtcars$mpg, mtcars$disp)
rmot_lm <- function(x, y, ...) {
  standata <- list(x = x, y = y, N = length(y))
  out <- rstan::sampling(stanmodels$lm, data = standata, ...)
  return(out)
}
