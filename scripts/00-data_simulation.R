# basic set
set.seed(888)
num_entries <- 32

# create year, cause, total_death and years
years <- sample(2000:2022, num_entries, replace = TRUE)
causes <- sample(c("Malignant neoplasms", "Diseases of heart", 
                   "Cerebrovascular diseases", "Chronic lower respiratory diseases",
                   "Accidents (unintentional injuries)", "Diabetes mellitus", 
                   "Influenza and pneumonia", "Alzheimer’s disease",
                   "Nephritis, nephrotic syndrome, and nephrosis", "Septicemia"),
                 num_entries, replace = TRUE)
total_deaths <- sample(5000:70000, num_entries, replace = TRUE)
years_column <- ifelse(runif(num_entries) < 0.9, 23, sample(1:22, num_entries, replace = TRUE))

# make it a frame
data <- data.frame(year = years, cause = causes, total_deaths = total_deaths, years = years_column)

print(data)

# save simulated data
write.csv(data, "inputs/simulated_data")