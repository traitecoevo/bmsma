test_that("Execution and output", {
  expect_named(bmsma_model("ols"))
  expect_type(bmsma_model("ols"), "list")
  expect_visible(bmsma_model("ols"))

  expect_named(bmsma_model("bsma"))
  expect_type(bmsma_model("bsma"), "list")
  expect_visible(bmsma_model("bsma"))

  suppressWarnings(lm_test <- bmsma_model("ols") |>
    bmsma_assign_data(X = Loblolly$age,
                     Y = Loblolly$height,
                     N = nrow(Loblolly)) |>
    bmsma_run(chains = 2, iter = 300, verbose = FALSE, show_messages = FALSE)
  )

  expect_visible(lm_test)

  expect_s4_class(lm_test, "stanfit")
})
