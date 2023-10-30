test_that("Execution and output", {
  expect_named(bmsma_model("linear"))
  expect_type(bmsma_model("linear"), "list")
  expect_visible(bmsma_model("linear"))

  expect_named(bmsma_model("constant_single"))
  expect_type(bmsma_model("constant_single"), "list")
  expect_visible(bmsma_model("constant_single"))

  lm_test <- bmsma_model("linear") |>
    bmsma_assign_data(X = Loblolly$age,
                     Y = Loblolly$height,
                     N = nrow(Loblolly)) |>
    bmsma_run(chains = 2, iter = 300, verbose = FALSE, show_messages = FALSE)

  expect_visible(lm_test)

  expect_s4_class(lm_test, "stanfit")
})
