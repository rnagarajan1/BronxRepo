# RollingSales_Bronx Data
A.R.M.S  
June 17, 2017  

## Rolling-Sales-Data: Bronx

This is a group assignment created for MSDS 6306 Summer 2017 @SMU.

## Setting up initial variables and working directory

```r
mainDirectory <- "C:/Users/mohan/Desktop/BronxRepo"
dataDirectory <- "C:/Users/mohan/Desktop/BronxRepo/Data"
analysisDirectory <- "C:/Users/mohan/Desktop/BronxRepo/Analysis"

fileName <- "rollingsales_bronx.csv"
```
## Setting up the working directories.

```r
setwd(mainDirectory)
# Create data and analysis directory
if(!dir.exists(dataDirectory))
  dir.create(dataDirectory)

if(!dir.exists(analysisDirectory))
  dir.create(analysisDirectory)
```
## Moving the raw data from Local machine to data directory

```r
from <- "D:/MSDS/MSDS-6306(403)/unit6/rollingsales_bronx.csv"
file.copy(from,dataDirectory)
```

```
## [1] TRUE
```
## Now make your working directory as data directory and start your assignment

```r
setwd(dataDirectory)
# This will ensure you are inside working directory
getwd()
```

```
## [1] "C:/Users/mohan/Desktop/BronxRepo/Data"
```




