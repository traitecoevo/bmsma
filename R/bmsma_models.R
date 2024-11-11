#' Select data configuration template for bmsma supported model
#'
#' @param model model name character string
#'
#' @return named list that matches Stan model parameters
#' @export
#'
#' @examples
#' bmsma_model("ols")

bmsma_model <- function(model=NULL){

  #TODO: Need a mechanism to check model requested in one that is supported by bmsma

  output <- switch(model,
                   ols = bmsma_ols(),
                   bsma = bmsma_bsma())

  class(output) <- "bmsma_object"

  return(output)
}

#' Data configuration template for linear model
#' @keywords internal
#' @noRd

bmsma_ols <- function(){
  list(X = NULL,
       Y = NULL,
       N = NULL,
       model = "ols")
}

#' Data configuration template for constant growth single species model
#' @keywords internal
#' @noRd

bmsma_bsma <- function(){
  list(
       n_obs = NULL,
       x = NULL,
       model = "bsma")
}



