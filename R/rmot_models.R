# Set list structures for different models
# An example for lm

rmot_lm <- function(){
list(X = NULL,
     Y = NULL,
     N = NULL,
     model = "linear")
}


# Need a mechanism to select models
# rmot_config(model = "linear")

rmot_config <- function(model=NULL){
  output <- switch(model,
                     linear = rmot_lm())

  class(output) <- "rmot_object"

  return(output)
}

# Need a mechanism to take user data and assign to slots in list
rmot_assign_data <- function(model_template, field, data){
  purrr::assign_in(model_template, field, data)
}


rmot_assign_data <- function(model_template, ...){
  # Grab user expressions
  user_code <- rlang::enexprs(..., .check_assign = TRUE)

  # Evaluate the RHS of expressions (the values)
  data <- purrr::map(user_code,
                     eval)

  # Grab the names
  fields <- names(user_code)

  for(i in fields){
    model_template <- purrr::list_modify(model_template, !!!data[i])
  }

  return(model_template)
}




list_rename = function(data, ...) {
  mapping = sapply(
    rlang::enquos(...),
    rlang::as_name
  )
  new_names = stats::setNames(nm=names(data))
  # `new_name = old_name` for consistency with `dplyr::rename`
  new_names[mapping] = names(mapping)
  # for `old_name = new_name` use: `new_names[names(mapping)] = mapping`
  stats::setNames(data, new_names)
}
