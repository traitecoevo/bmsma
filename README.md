
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bmsma

<!-- badges: start -->

[![R-CMD-check](https://github.com/traitecoevo/bmsma/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/traitecoevo/bmsma/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/traitecoevo/bmsma/branch/master/graph/badge.svg)](https://app.codecov.io/gh/traitecoevo/bmsma?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of ‘bmsma’ is to …

## Installation

‘bmsma’ is under active development. You can install the current
developmental version of ‘bmsma’ from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("traitecoevo/bmsma")
```

## Quick demo

``` r
bmsma_model("linear") |>
  bmsma_assign_data(X = Loblolly$age,
                   Y = Loblolly$height,
                   N = nrow(Loblolly)) |>
  bmsma_run()
```

## Found a bug?

Please submit a [GitHub
issue](https://github.com/traitecoevo/bmsma/issues) with details of the
bug. A [reprex](https://reprex.tidyverse.org/) would be particularly
helpful with the bug-proofing process!
