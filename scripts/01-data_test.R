# read simualted data
data <- read.csv("inputs/simulated_data")

# create function to test
test_data <- function(data) {
  year_test <- all(sapply(data$year, is.numeric) & data$year >= 2000 & data$year <= 2022)
  years_test <- all(sapply(data$years, is.numeric) & data$years >= 0 & data$years <= 23)
  cause_test <- all(sapply(data$cause, is.character))
  total_deaths_test <- all(sapply(data$total_deaths, is.numeric) & data$total_deaths > 0)
  
  return(list(
    year_test = year_test,
    years_test = years_test,
    cause_test = cause_test,
    total_deaths_test = total_deaths_test
  ))
}

# run test function
test_data(data)