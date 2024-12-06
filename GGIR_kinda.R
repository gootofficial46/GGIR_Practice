dataFolder <- "/Users/georgeannas/Desktop/CPC Research/Data/FALAH bin/"
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
  mode = 1:6,                      # Run all five GGIR modes
  overwrite = TRUE,                # Overwrite existing output
  do.imp = TRUE,                   # Imputation of non-wear time
  do.visual = TRUE,                # Generates visual plots in parts 4, 5 and 6
  data_Format = "bin",             # Specifies type of file
    
  # Mode 1 (Pre-processing and calibration)
  do.cal = TRUE,                   # Perform auto-calibration
  do.enmo = TRUE,                  # Calculate ENMO (metric of acceleration)
  do.anglex = TRUE,                # Calculate angle relative to gravity
  windowsizes = c(5, 900, 3600),  # Indicates the short epoch, long epoch, and non-wear detection
  printsummary = TRUE,             # Print summary to console
  
  # Mode 2 (Non-wear time and sleep detection)
  do.part2 = TRUE,                 # Enable mode 2
  data_masking_strategy = 1,       # Sleep detection strategy (default is 2)
  hrs.del.start = 0,               # Ignore data before midnight
  hrs.del.end = 0,                 # Ignore data after midnight
  
  # Mode 3 (Physical activity metrics)
  do.part3 = TRUE,                 # Enable mode 3
  
  # Mode 4 (Individual reports)
  do.part4 = TRUE,                 # Enable mode 4
  timethreshold = 5,               # 30 minute threshold for angle variation to be below angle threshold
  HASIB.algo = "Sadeh1994",        # Utilising the Sadeh inactivity bout algorithm
  Sadeh_axis = "Y",                # Specifying vertical movement for the Sadeh algorithm
  
  # Mode 5 (Group summaries)
  do.part5 = TRUE,                 # Enable mode 5
  threshold.lig = 87.5,            # Light activity thresholds (mg)
  threshold.mod = 250,             # Moderate activity thresholds (mg)
  threshold.vig = 750,             # Vigorous activity thresholds (mg)
  save_ms5rawlevels = TRUE,        # Preparation for Part 6
  save_ms5raw_format = "RData",    # Preparation for Part 6
  
  # Mode 6 (Circadian analysis)
  do.part6 = TRUE,                 # Enable mode 6
  part6CR = TRUE
)