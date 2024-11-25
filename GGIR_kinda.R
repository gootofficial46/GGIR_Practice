dataFolder <- "/Users/georgeannas/Desktop/CPC Research/Data/FALAH Unprocessed/"
outputFolder <- "/Users/georgeannas/Desktop/CPC Research/Data/FALAH Data"

# Load GGIR library
if (!requireNamespace("GGIR", quietly = TRUE)) {
  install.packages("GGIR")
}
library(GGIR)

# Check if output folder exists; if not, create it
if (!dir.exists(outputFolder)) {
  dir.create(outputFolder, recursive = TRUE)
}

# Run GGIR
GGIR(
  datadir = dataFolder,            # Input data folder
  outputdir = outputFolder,        # Output folder
  mode = 1:5,                      # Run all five GGIR modes
  overwrite = TRUE,                # Overwrite existing output
  do.imp = TRUE,                   # Imputation of non-wear time
  data_Format = 'csv',             # Specifies type of file
  chunksize = 1,                   # Number of days processed at a time
  extEpochData_timeformat = "%Y-%m-%d %H:%M:%S",
  read.myacc.csv(
    rmc.file = "/Users/georgeannas/Desktop/CPC Research/Data/FALAH Unprocessed/LAA_2023_020200005__029159_2023-06-22_13-09-03.csv",
    rmc.firstrow.acc = 2,
    rmc.firstrow.header = 1,
    rmc.header.length = 1,
    rmc.col.acc = c(2,3,4),
    rmc.col.temp = 5,
    rmc.col.time = 1,
    rmc.unit.time = "character",
    rmc.sf = 1,
    ),
    
  # Mode 1 (Pre-processing and calibration)
  do.cal = TRUE,                   # Perform auto-calibration
  do.enmo = TRUE,                  # Calculate ENMO (metric of acceleration)
  do.anglex = TRUE,                # Calculate angle relative to gravity
  windowsizes = c(1, 900, 3600),   # Indicates the short epoch, long epoch, and non-wear detection
  printsummary = TRUE,             # Print summary to console
  verbose = TRUE,
  
  # Mode 2 (Non-wear time and sleep detection)
  do.part2 = TRUE,                 # Enable mode 2
  strategy = 2,                    # Sleep detection strategy (default is 2)
  hrs.del.start = 0,               # Ignore data before midnight
  hrs.del.end = 0,                 # Ignore data after midnight
  
  # Mode 3 (Physical activity metrics)
  do.part3 = TRUE,                 # Enable mode 3
  threshold.lig = c(30, 100),      # Light activity thresholds (mg)
  threshold.mod = c(100, 400),     # Moderate activity thresholds (mg)
  threshold.vig = c(400, 1000),    # Vigorous activity thresholds (mg)
  
  # Mode 4 (Individual reports)
  do.part4 = TRUE,                 # Enable mode 4
  do.visual = TRUE,                # Generate sleep and activity plots
  
  # Mode 5 (Group summaries)
  do.part5 = TRUE                  # Enable mode 5
)

# Print message when done
cat("GGIR processing complete! Check the output folder for results.\n")