library(data.table)

# Set the folder path
input_folder <- "/Users/georgeannas/Desktop/FALAH Min Convert Updated" # Replace with your folder path
output_folder <- "/Users/georgeannas/Desktop/FALAH Min Convert Updated 2" # Replace with your output folder path

# Ensure the output folder exists
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Define the specific renaming rules for the first four columns
rename_columns <- c("timestamp", "X", "Y", "Z")

# List all .csv files in the folder
csv_files <- list.files(input_folder, pattern = "\\.csv$", full.names = TRUE)

# Process each file
for (file_path in csv_files) {
  # Read the CSV file
  data <- fread(file_path)
  
  # Ensure there are at least 4 columns to rename
  if (ncol(data) >= 4) {
    # Rename the first four columns
    setnames(data, old = colnames(data)[1:4], new = rename_columns)
    
    # Create the output file path
    file_name <- basename(file_path) # Get the file name
    output_file <- file.path(output_folder, file_name)
    
    # Save the updated file
    fwrite(data, output_file)
    cat("Processed and saved:", output_file, "\n")
  } else {
    cat("Skipped (less than 4 columns):", file_path, "\n")
  }
}

# Load necessary libraries
library(GGIR)

# Set working directory containing the .csv files
workdir <- "/Users/georgeannas/Desktop/FALAH Min Convert Updated 2" # Update this path
outputdir <- "/Users/georgeannas/Desktop/FALAH Data"       # Update this path for output storage
datadir <- workdir

# Initialize GGIR parameters
GGIR::GGIR(
  datadir = datadir,
  outputdir = outputdir,
  mode = c(1, 2),          # Process data and calculate sleep metrics
  epochlength = 60,        # Specify 60-second (minute) epochs
  overwrite = TRUE,        # Allow overwriting existing outputs
  do.cal = TRUE,           # Perform calibration checks
  do.report = c(2),        # Generate sleep reports
  epochValues2csv = TRUE,  # Export epoch-level data to CSV
  do.imp = TRUE,           # Impute missing data
  includedaycrit = 16,     # Minimum valid hours of data per day
  def.noc.sleep = c(23, 5) # Default nocturnal sleep window
)

# Path to the meta sleep summary output
summary_file <- file.path(outputdir, "meta_sleep_summary.csv")

# Check if summary file exists
if (file.exists(summary_file)) {
  sleep_summary <- read.csv(summary_file)
  
  # Display sleep metrics: Sleep onset, midpoint, offset
  sleep_data <- sleep_summary[, c("ID", "onset", "midpoint", "wake")]
  print(sleep_data)
  
  # Plot actigraphy data
  plot_actigraphy <- function(file_path) {
    actigraphy_data <- read.csv(file_path)
    
    # Ensure timestamp and activity columns exist
    if (!all(c("time", "activity") %in% colnames(actigraphy_data))) {
      stop("The CSV file must contain 'time' and 'activity' columns.")
    }
    
    # Convert time to POSIXct for plotting
    timestamp <- as.POSIXct(actigraphy_data$time, format = "%Y-%m-%d %H:%M:%S")
    activity <- actigraphy_data$activity
    
    # Create plot
    plot(
      timestamp, activity,
      type = "l",
      col = "blue",
      xlab = "Time",
      ylab = "Activity",
      main = "Actigraphy Data"
    )
  }
  
  # Example: Plot data from the first CSV file
  csv_files <- list.files(workdir, pattern = "\\.csv$", full.names = TRUE)
  if (length(csv_files) > 0) {
    plot_actigraphy(csv_files[1])
  } else {
    message("No CSV files found in the specified directory.")
  }
} else {
  message("Summary file not found. Ensure GGIR processing was successful.")
  
  
  library(GGIR)
  GGIR(mode =c(1,2,3,4,5),
       datadir="/Users/georgeannas/Desktop/CPC Research/Data/FALAH Unprocessed",
       outputdir="/Users/georgeannas/Desktop/CPC Research/Data/FALAH Data",
       read.myacc.csv(rmc.file="LAA_2023_020200005__029159_2023-06-22_13-09-03.csv",
                      rmc.unit.acc = "g",
                      rmc.col.time = 2,
                      rmc.dec = ".",
                      rmc.unit.time = "character",
                      rmc.firstrow.acc = 3,
                      rmc.col.acc = c(3,4,5),
                      rmc.col.temp = 7,
                      rmc.unit.temp = "C",
                      rmc.format.time = "%Y/%m/%d %H:%M:%S",
                      desiredtz = "Vanuatu/Port Vila"))
}