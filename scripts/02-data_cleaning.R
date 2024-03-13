# set up
library(dplyr)

# Read the CSV file as lines
lines <- readLines("inputs/1310039401-eng.csv")

# Skip specified lines
lines_to_keep <- lines[-c(1:11, 13:15, 118:152)]

data <- read.csv(text = lines_to_keep, check.names = FALSE)

# roughly clean data
for (i in 2:nrow(data)) {
  if (i %% 2 == 0) {
    data[i, 1] <- data[i - 1, 1]
  }
}

data <- data[seq(0,nrow(data),2),]
data <- data[, -2]
names(data)[1] <- "cause"

# totally change the form into a new data frame
new <- data.frame(year = numeric(), cause = character(), total_deaths = numeric())

for (i in 1:nrow(data)) {
  for (n in 2:ncol(data)) {
    if (data[i, n] == "..")
      data[i, n] <- 0
    if (data[i, n] != 0) {
      new <- rbind(new, data.frame(year = as.numeric(names(data)[n]),
                                   cause = data$cause[i],
                                   total_deaths = data[i, n]))
    }
  }
}

# clean cause names
for (i in 1:length(new$cause)) {
  new$cause[i] <- gsub("\\s*\\[.*?\\]", "", new$cause[i])
}

# sort and add ranking
new <- new %>%
  arrange(year, desc(as.numeric(gsub(",", "", total_deaths))))%>%
  group_by(year) %>%
  mutate(ranking = row_number())

# count times of appear
new <- new %>%
  mutate(total_deaths = as.numeric(gsub(",", "", total_deaths))) %>%
  group_by(cause) %>%
  mutate(n = sum(total_deaths != 0))

write.csv(new, "inputs/cleaned_data")