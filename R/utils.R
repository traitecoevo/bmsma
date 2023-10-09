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
