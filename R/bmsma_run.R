#' Run a linear model in Stan
#'
#' @param model_template model template generated by bmsma_model and updated by bmsma_assign_data
#' @param ... additional arguments passed to rstan::sampling
#'
#' @return Stanfit model output
#' @export
#'
#' @examples
#' bmsma_model("ols") |>
#'   bmsma_assign_data(X = Loblolly$age,
#'                    Y = Loblolly$height,
#'                    N = nrow(Loblolly)) |>
#'   bmsma_run()
bmsma_run <- function(model_template, ...) {

  # Detect model
  out <- switch(model_template$model,
         ols = rstan::sampling(stanmodels$ols, data = model_template, ...),
         bsma = rstan::sampling(stanmodels$bsma, data = model_template, ...))

  return(out)
}
