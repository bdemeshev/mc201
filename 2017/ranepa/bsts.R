# загрузим ряд
library(sophisthse)
View(series_info)
df <- sophisthse("UNEMPL_M")
View(sophisthse_metadata(df))
str(df)
# sophist.hse.ru

# 1. ETS - предшественник BS-TS
library(forecast) # ETS (предшественник BS-TS)
model_ets <- ets(df, model = "AAA", 
             damped = FALSE)
?ets
model_ets

forecast(model, h = 4)
# * интерпретируема
str(model$states)
plot(model_ets)
tsdisplay(model$states[, 3])
tsdisplay(model$states[, 2])

# auto ETS selection
model_auto_ets <- ets(df)
model_auto_ets

# ETS vs ARIMA vs others 
library(forecastHybrid)
model_hybrid <- hybridModel(df[, 1], 
                model = "aef")
# усредняет прогнозы нескольких моделей
?hybridModel
forecast(model_hybrid, h = 4)

# 2. bayesian structural time series
# априорное распределение
# модель для данных
# * одномерные врем ряды
# * интерпретируемы (в отличие от ARIMA)
library(bsts) # bayesian structural TS
library(tidyverse) # data manipulation
model_structure <- list() %>%
  AddLocalLinearTrend(df) %>% 
  AddSeasonal(df, nseasons = 12)
model <- bsts(df, state.specification = model_structure, 
              niter = 1000)
forecasts <- predict(model, h = 4)
 
forecasts$mean 
forecasts$median
forecasts$interval
qplot(x = forecasts$distribution[, 1])


plot(model, "comp")
plot(model)
plot(model, "seasonal")

?plot.bsts
# 3. BVARs
library(BMR)
library(bvarr)

