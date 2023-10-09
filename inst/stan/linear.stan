// A linear model
data {
  int<lower=1> N;
  vector[N] X;
  vector[N] Y;
}
parameters {
  real intercept;
  real beta;
  real<lower=0> sigma;
}
model {
  // ... priors, etc.

  Y ~ normal(intercept + beta * X, sigma);
}
