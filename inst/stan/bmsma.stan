// A multi-level sma model fit
data {
  int<lower=1> n_obs;
  int<lower=1> n_groups;
  int<lower=1> group[n_obs];
  vector[2] x[n_obs];
  }

parameters {
  // hyper parameters
  real mu_mu_x;
  real<lower=0> sigma_mu_x;
  real mu_b_0;
  real<lower=0> sigma_b_0;
  real mu_log_b_1;
  real<lower=0> sigma_log_b_1;
  real<lower=0> a_sigma_u1;
  real<lower=0> b_sigma_u1;
  real<lower=0> a_sigma_u2;
  real<lower=0> b_sigma_u2;

  // group-level effects
  real mu_x1[n_groups];
  real b_0[n_groups];
  real<lower=0> b_1[n_groups];
  real<lower=0> sigma_u1[n_groups];
  real<lower=0> sigma_u2[n_groups];
}

model {
  // Define variables used
  real u_c;             // constant
  vector[2] uv[n_obs];  // (u1,u2) data in vector form

  matrix[2,2] U[n_groups];        // Rotation matrices
  vector[2] mu_x[n_groups];       // vector means for x
  vector[2] sigma_u[n_groups];    // covariance matrices for u

  // Sample group parameters from distributions
  mu_x1 ~ normal(mu_mu_x, sigma_mu_x);
  b_0 ~ normal(mu_b_0, sigma_b_0);
  b_1 ~ lognormal(mu_log_b_1, sigma_log_b_1);
  sigma_u1 ~ normal(a_sigma_u1, b_sigma_u1);
  sigma_u2 ~ normal(a_sigma_u2, b_sigma_u2);
  // NB: sigmas should be sampled from gamma (or inverse gamma),
  // but that doesn't converge. Gelman says gamma performs badly
  // when variance is close to zero

  // Now calculate vectors and matrices from proposed parameters, indexed by group
  for (i in 1:n_groups) {
    mu_x[i, 1] = mu_x1[i];
    mu_x[i, 2] = b_0[i] + b_1[i] * mu_x1[i];

    // Rotation matrix, U
    u_c = 1 / sqrt(2) / b_1[i];
    U[i,1,1] =  b_1[i]^2 * u_c;
    U[i,1,2] =  b_1[i]   * u_c;
    U[i,2,1] = -b_1[i]   * u_c;
    U[i,2,2] =  1        * u_c;

    // Covariance matrix of U
    sigma_u[i,1] = sigma_u1[i];
    sigma_u[i,2] = sigma_u2[i];
  }

  for (j in 1:n_obs) {
    // Calculate u by centering then rotating x
    uv[j] = U[group[j]] * (log(x[j]) - mu_x[group[j]]);

    // Likelihood of data
    // consider re-parameterising as described on pg 218
    uv[j] ~ multi_normal(rep_vector(0,2), diag_matrix(sigma_u[group[j]]));
  }
}
