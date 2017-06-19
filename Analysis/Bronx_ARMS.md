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
  dir.create("dataDirectory")

if(!dir.exists(analysisDirectory))
  dir.create(analysisDirectory)
```
## Moving the raw data from Local machine to data directory

```r
from <- "D:/MSDS/MSDS-6306(403)/unit6/rollingsales_bronx.csv"
file.copy(from,dataDirectory)
```

```
## [1] FALSE
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

```r
# Read csv file
bx <- read.csv("rollingsales_bronx.csv",skip=4,header=TRUE)
# Check the Data and its internal structure
dim(bx)
```

```
## [1] 6842   21
```

```r
str(bx)
```

```
## 'data.frame':	6842 obs. of  21 variables:
##  $ BOROUGH                       : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ NEIGHBORHOOD                  : Factor w/ 39 levels "BATHGATE                 ",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ BUILDING.CLASS.CATEGORY       : Factor w/ 34 levels "01  ONE FAMILY DWELLINGS                    ",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ TAX.CLASS.AT.PRESENT          : Factor w/ 9 levels "  ","1","1A",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ BLOCK                         : int  3028 3030 3036 3037 3043 3046 3046 3048 3048 3053 ...
##  $ LOT                           : int  25 56 13 101 55 52 52 27 28 105 ...
##  $ EASE.MENT                     : logi  NA NA NA NA NA NA ...
##  $ BUILDING.CLASS.AT.PRESENT     : Factor w/ 97 levels "  ","A1","A2",..: 5 2 2 80 2 2 2 2 2 2 ...
##  $ ADDRESS                       : Factor w/ 6218 levels " 1 EAST 213TH STREET                       ",..: 4329 4330 4535 4604 1705 1859 1859 4900 4902 2290 ...
##  $ APARTMENT.NUMBER              : Factor w/ 251 levels "            ",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ ZIP.CODE                      : int  10457 10457 10457 10457 10457 10457 10457 10457 10457 10458 ...
##  $ RESIDENTIAL.UNITS             : Factor w/ 98 levels "                         -  ",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ COMMERCIAL.UNITS              : Factor w/ 18 levels "                         -  ",..: 1 1 1 9 1 1 1 1 1 1 ...
##  $ TOTAL.UNITS                   : Factor w/ 100 levels "           -  ",..: 3 3 3 41 3 3 3 3 3 3 ...
##  $ LAND.SQUARE.FEET              : Factor w/ 1838 levels "              -  ",..: 273 53 1256 51 694 677 677 34 34 1828 ...
##  $ GROSS.SQUARE.FEET             : Factor w/ 1932 levels "                  -  ",..: 653 188 368 1025 652 183 183 19 19 90 ...
##  $ YEAR.BUILT                    : int  1901 1899 1899 1952 1901 1901 1901 1901 1901 1901 ...
##  $ TAX.CLASS.AT.TIME.OF.SALE     : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ BUILDING.CLASS.AT.TIME.OF.SALE: Factor w/ 96 levels " A1 "," A2 ",..: 4 1 1 79 1 1 1 1 1 1 ...
##  $ SALE.PRICE                    : Factor w/ 1492 levels "                        -   ",..: 1 270 870 1 398 497 420 1 527 1 ...
##  $ SALE.DATE                     : Factor w/ 306 levels "1/1/2017","1/10/2017",..: 172 10 119 279 216 294 294 293 298 133 ...
```





