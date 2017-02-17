library(rstan)
library(bayesplot)

# Session - Set Working Directory - Source file loc

model <- stan_model(file = "coins.stan")
df <- list(N = 2, y = c(1, 1))
fit <- sampling(model, data = df)

fit

fit_array <- as.array(fit)
mcmc_hist(fit_array)
mcmc_trace(fit_array)
