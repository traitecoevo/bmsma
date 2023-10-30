#' Select data configuration template for bmsma supported model
#'
#' @param model model name character string
#'
#' @return named list that matches Stan model parameters
#' @export
#'
#' @examples
#' bmsma_model("linear")

bmsma_model <- function(model=NULL){

  #TODO: Need a mechanism to check model requested in one that is supported by bmsma

  output <- switch(model,
                   linear = bmsma_lm(),
                   constant_single = bmsma_cgs())

  class(output) <- "bmsma_object"

  return(output)
}

#' Data configuration template for linear model
#' @keywords internal
#' @noRd

bmsma_lm <- function(){
  list(X = NULL,
       Y = NULL,
       N = NULL,
       model = "linear")
}

#' Data configuration template for constant growth single species model
#' @keywords internal
#' @noRd

bmsma_cgs <- function(){
  list(N_obs = NULL,
       N_ind = NULL,
       S_obs = NULL,
       census = NULL,
       census_interval = NULL,
       id_factor = NULL,
       S_0_obs = NULL,
       model = "constant_single")
}



