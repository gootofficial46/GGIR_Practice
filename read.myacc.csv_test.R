library(GGIR)
read.myacc.csv(
  rmc.file = "/Users/georgeannas/Desktop/CPC Research/Data/FALAH Unprocessed/LAA_2023_020200006__029156_2023-06-22_10-11-25.csv",
  rmc.nrow = Inf,
  rmc.skip = 0,
  rmc.dec = ".",
  rmc.firstrow.acc = 2,
  rmc.firstrow.header = 1,
  rmc.col.acc = c(2,3,4),
  rmc.col.temp = 6,
  rmc.col.time = 1,
  rmc.unit.acc = "g",
  rmc.unit.temp = "C",
  rmc.unit.time = "character",
  rmc.format.time = "%Y-%m-%d %H:%M:%S",
  desiredtz = "Pacific/Noumea",
  rmc.sf = 1
)