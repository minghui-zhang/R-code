# cross validation by location
run_model_for_prediction_elimlocation <- function(full_data, formula, year_for_location, year_oi, plot_model_evals) {
  
  # year_oi is for mapping and visualization only
  # year_for_location is the year whose locations are looped through in cross validation
  
  # use only data points that existed in one year (2004)
  data_in_year <- full_data[full_data$year == year_for_location,]
  
  prediction_results <- data.frame()
  
  for (row_index in 1:nrow(data_in_year)) {
    test_location_sf <- data_in_year[row_index,]
    
    # turn test location into point, otherwise will get multiple cells as test location
    test_location_sp <- as(test_location_sf, "Spatial")
    st_geometry(test_location_sf) <- NULL # turn into data frame
    centroids <- coordinates(test_location_sp)
    test_location_point <- SpatialPointsDataFrame(coords = centroids, data = test_location_sf)
    test_location_sf <- st_as_sf(test_location_point)
    st_crs(test_location_sf) <- st_crs(full_data)
    
    # get test data for all years
    test_sgbp = st_intersects(x = full_data, y = test_location_sf)
    test_logical = lengths(test_sgbp) > 0
    test_data = full_data[test_logical, ]
    
    # get train data for all years 
    train_data <- full_data[test_location_sf, , op = st_disjoint]
    
    model = lm(formula, data=train_data) 
    model_intercept = lm(plant ~ 1, data=train_data)
    
    # extract onset coef and R2 from model
    onset_coef <- model$coefficients['onset']
    train_data$residuals <- residuals(model)
    SST <- sum((train_data$plant - mean(train_data$plant))^2)
    SSE <- sum((train_data$residuals - mean(train_data$residuals))^2)
    R2 <- 1 - SSE/SST
    
    # prediction
    prediction <- predict(model, test_data)
    RMSE <- rmse(prediction, test_data$plant)
    error <- mean(prediction - test_data$plant, na.rm = TRUE)
    
    prediction_intercept <- predict(model_intercept, test_data)
    error_intercept <- rmse(prediction_intercept, test_data$plant)
    
    diff_RMSE <- error_intercept - RMSE
    
    # output
    output <- c(onset_coef, R2, RMSE, diff_RMSE, error)
    names(output) <- c("onset", "R2", "RMSE", "RMSE_improvement", "error")
    
    prediction_results <- rbind(prediction_results, output)
    
    # plot train and test data for a specific year
    
    # test_year <- test_data[test_data$year == year_oi & test_data$intensity == "DC", ]
    # ggplot(test_year) +
    #    geom_sf(aes(fill = plant)) +
    #    scale_fill_viridis() +
    #    ggtitle(paste("test data for ", year_oi)) +
    #    geom_polygon(data = MT_outline, aes(x = long, y = lat), color = "black", alpha = 0, linetype = 1) +
    #    theme_bw()
    # 
    # train_year <- train_data[train_data$year == year_oi & train_data$intensity == "DC", ]
    # ggplot(train_year) +
    #    geom_sf(aes(fill = plant)) +
    #    scale_fill_viridis() +
    #    ggtitle(paste("train data for ", year_oi)) +
    #    geom_polygon(data = MT_outline, aes(x = long, y = lat), color = "black", alpha = 0, linetype = 1) +
    #    theme_bw()
  }
  
  names(prediction_results) <- names(output)
  prediction_results$index <- 1:nrow(prediction_results)
  
  if (plot_model_evals) {
    plot(prediction_results$index, prediction_results$RMSE, 
         ylab = "RMSE", xlab = "location index", ylim = c(5, 25), type = "l", main = "Prediction RMSE, spatial sampling")
    
    plot(prediction_results$index, prediction_results$error, 
         ylab = "error", xlab = "location index", ylim = c(-25, 25), type = "l", main = "Prediction error, spatial sampling")
    
    # plot(prediction_results$index, prediction_results$RMSE_improvement, 
    #      ylab = "RMSE", xlab = "location index", ylim = c(0, 10), type = "l", main = "Prediction RMSE improvement over intercept, spatial sampling")
    # 
    # plot(prediction_results$index, prediction_results$onset, type = "l", col = "red", ylab = "coef or R2", xlab = "location index", ylim = c(0.1, 0.7), main = "Prediction onset and R2, spatial sampling")
    # lines(prediction_results$index, prediction_results$R2, col = "blue")
    # legend(1, 0.65, legend = c("onset coef", "R2"), col = c("red", "blue"), lty= c(1,1))
  }
  
  # map of prediction error
  
  data_in_year$prediction_rmse <- prediction_results$RMSE
  data_in_year$prediction_error <- prediction_results$error
  data_in_year_DC <- data_in_year[data_in_year$intensity == "DC", ]
  
  if (plot_model_evals) {
    rmse_map <- ggplot(data_in_year_DC) +
      geom_sf(aes(fill = prediction_rmse)) +
      scale_fill_viridis() +
      ggtitle("prediction rmse") +
      geom_polygon(data = MT_outline, aes(x = long, y = lat), color = "black", alpha = 0, linetype = 1) +
      theme_bw()
    print(rmse_map)
    
    error_map <- ggplot(data_in_year_DC) +
      geom_sf(aes(fill = prediction_error)) +
      scale_fill_viridis() +
      ggtitle("prediction error") +
      geom_polygon(data = MT_outline, aes(x = long, y = lat), color = "black", alpha = 0, linetype = 1) +
      theme_bw()
    print(error_map)
  }
  
  return(prediction_results)
  
}

##############################################################################################################################################

# runs the model with options to eliminate a year
run_model_for_prediction_elimyear <- function(full_data, year_to_elim, elim_year, formula) {
  
  
  # separate training and test data
  if (elim_year) {
    train_data <- full_data[full_data$year != year_to_elim,]
    test_data <- full_data[full_data$year == year_to_elim,]
  }
  else {
    train_data <- full_data
    test_data <- full_data
  }
  
  model = lm(formula, data=train_data) 
  model_intercept = lm(plant ~ 1, data=train_data)
  
  # extract onset coef and R2 from model
  onset_coef <- model$coefficients['onset']
  train_data$residuals <- residuals(model)
  SST <- sum((train_data$plant - mean(train_data$plant))^2)
  SSE <- sum((train_data$residuals - mean(train_data$residuals))^2)
  R2 <- 1 - SSE/SST
  
  # prediction
  prediction <- predict(model, test_data)
  error <- rmse(prediction, test_data$plant)
  
  prediction_intercept <- predict(model_intercept, test_data)
  error_intercept <- rmse(prediction_intercept, test_data$plant)
  
  diff_error <- error_intercept - error
  
  # output
  output <- c(as.integer(year_to_elim), onset_coef, R2, error, diff_error)
  names(output) <- c("eliminated_year", "onset", "R2", "RMSE", "RMSE_improvement")
  return(output)
}