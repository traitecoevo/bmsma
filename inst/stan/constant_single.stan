//Constant Growth - Single species

// Data structure
data {
  int N_obs;
  int N_ind;
  real S_obs[N_obs];
  int census[N_obs];
  real census_interval[N_obs];
  int id_factor[N_obs];
  real S_0_obs[N_ind];
}

// The parameters accepted by the model.
parameters {
  //Individual level
  real<lower=0> ind_S_0[N_ind];
  real<lower=0> ind_beta[N_ind];

  real species_beta_mu;
  real<lower=0> species_beta_sigma;

  //Global level
  real<lower=0> global_error_sigma;
}

// The model to be estimated.
model {
  real S_hat[N_obs];
  real G_hat[N_obs];

  for(i in 1:N_obs){
    if(id_factor[i+1]==id_factor[i]){
      if(census[i]==1){//Fits the first size
        S_hat[i] = ind_S_0[id_factor[i]];
      }

      if(i < N_obs){ //Analytic solution
        G_hat[i] = ind_beta[id_factor[i]];
        S_hat[i+1] = S_hat[i] + G_hat[i]*census_interval[i+1];
      }
    } else {
      G_hat[i] = 0; //Gives 0 as the growth estimate for the last data point.
    }
  }

  //Likelihood
  S_obs ~ normal(S_hat, global_error_sigma);

  //Priors
  //Individual level
  ind_S_0 ~ normal(S_0_obs, global_error_sigma);
  ind_beta ~ lognormal(species_beta_mu,
                    species_beta_sigma);

  //Species level
  species_beta_mu ~ normal(0.1, 1);
  species_beta_sigma ~cauchy(0.1, 1);

  //Global level
  global_error_sigma ~cauchy(0.1, 1);
}

// The output
generated quantities {
  real S_hat[N_obs];
  real G_hat[N_obs];

  for(i in 1:N_obs){
    if(id_factor[i+1]==id_factor[i]){
      if(census[i]==1){//Fits the first size
        S_hat[i] = ind_S_0[id_factor[i]];
      }

      if(i < N_obs){ //Analytic solution
        G_hat[i] = ind_beta[id_factor[i]];
        S_hat[i+1] = S_hat[i] + G_hat[i]*census_interval[i+1];
      }
    } else {
      G_hat[i] = 0; //Gives 0 as the growth estimate for the last data point.
    }
  }
}
