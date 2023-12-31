#' Assign data to template
#'
#' @param model_template output from bmsma_model
#' @param ... data-masking name-value pairs
#'
#' @return updated named list with your data assigned to Stan model parameters
#' @export
#'
#' @examples
#' bmsma_model("linear") |> bmsma_assign_data(X = Loblolly$age, Y = Loblolly$height)
bmsma_assign_data <- function(model_template, ...){
  # Grab user expressions
  user_code <- rlang::enexprs(..., .check_assign = TRUE)

  # Grab the names
  fields <- names(user_code)

  #TODO: Check names are in model_template

  # Evaluate the RHS of expressions (the values)
  data <- purrr::map(user_code,
                     eval)

  for(i in fields){
    model_template <- purrr::list_modify(model_template, !!!data[i])
  }

  #TODO: Check if N is supplied, if not, assign by default to length(X) and give warning

  return(model_template)
}
