# Set the number of rows for the dataset (e.g., 10,000 rows)
num_rows <- 300000

# Generate a sequence of timestamps starting from a given date-time
start_time <- as.POSIXct("2023-07-15 18:00:00", tz = "UTC")
timestamps <- seq(from = start_time, by = "1 sec", length.out = num_rows)

# Generate synthetic accelerometer data
set.seed(42) # For reproducibility
x <- rnorm(num_rows, mean = 0, sd = 1) # Random normal data for X axis
y <- rnorm(num_rows, mean = 0, sd = 1) # Random normal data for Y axis
z <- rnorm(num_rows, mean = 0, sd = 1) # Random normal data for Z axis

# Combine into a data frame
synthetic_data <- data.frame(
  timestamp = timestamps,
  x = x,
  y = y,
  z = z
)

# Write the dataset to a CSV file
write.csv(synthetic_data, "synthetic_data.csv", row.names = FALSE)