test_that("Execution and output", {

  lm_loblloy <- bmsma_model("ols") |>
    bmsma_assign_data(X = Loblolly$age)

  expect_named(lm_loblloy)

  expect_visible(lm_loblloy)

  expect_type(lm_loblloy, "list")

  lm_empty <- bmsma_model("ols")

  expect_null(lm_empty$X)

  expect_true(length(lm_loblloy$X) > 0)
})
