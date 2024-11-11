// An sma model with single group
data {
  int<lower=1> n_obs;
  vector[2] x[n_obs];
}

parameters {
  real mu_x1;
  real b_0;
  real<lower=0> b_1;

  real<lower=0> sigma_u1;
  real<lower=0> sigma_u2;
}

model {
  // Define variables used
  real u_c;             // constant
  matrix[2,2] U;        // Rotation matrix
  vector[2] uv[n_obs];  // (u1,u2) data in vector form
  vector[2] sigma_u;  // covariance matrix for uv
  vector[2] mu_x;       // vector mean of x

  // Now calculate from proposed parameters
  mu_x[1] = mu_x1;
  mu_x[2] = b_0  +  b_1 * mu_x1;

  // Rotation matrix, U
  u_c = 1 / sqrt(2) / b_1;
  U[1,1] = b_1^2 * u_c;
  U[1,2] = b_1 * u_c;
  U[2,1] = -b_1 * u_c;
  U[2,2] = 1 * u_c;

  // Covariance matrix of U
  sigma_u[1] = sigma_u1;
  sigma_u[2] = sigma_u2;

  // Calculate u by centering then rotating x
  for (j in 1:n_obs) {
    uv[j] = U * (log(x[j]) - mu_x);
  }

  // Likelihood of data
  uv ~ multi_normal(rep_vector(0,2), diag_matrix(sigma_u));
}
