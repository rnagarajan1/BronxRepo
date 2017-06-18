# Rolling Sales Bronx Data
A.R.M.S  
June 18, 2017  

#Rolling-Sales-Data: Bronx
This is a group assignment created for MSDS 6306 Summer 2017 @SMU.

###*_Set up the working directory:_*

```r
setwd("E:/Users/Andy/Desktop")
```

###*_Skip the first four lines of the file and read in remainder on the csv file and create the blockcode dataset:_*

```r
bronx <- read.csv("rollingsales_bronx.csv", skip=4, header=TRUE)
blockCode <- bronx[c(5,11)]
```

###*_In order to tidy/clean up the dataset, need to look at the structure of it:_*

```r
dim(bronx)
```

```
## [1] 6842   21
```

```r
str(bronx)
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

```r
names(bronx)
```

```
##  [1] "BOROUGH"                        "NEIGHBORHOOD"                  
##  [3] "BUILDING.CLASS.CATEGORY"        "TAX.CLASS.AT.PRESENT"          
##  [5] "BLOCK"                          "LOT"                           
##  [7] "EASE.MENT"                      "BUILDING.CLASS.AT.PRESENT"     
##  [9] "ADDRESS"                        "APARTMENT.NUMBER"              
## [11] "ZIP.CODE"                       "RESIDENTIAL.UNITS"             
## [13] "COMMERCIAL.UNITS"               "TOTAL.UNITS"                   
## [15] "LAND.SQUARE.FEET"               "GROSS.SQUARE.FEET"             
## [17] "YEAR.BUILT"                     "TAX.CLASS.AT.TIME.OF.SALE"     
## [19] "BUILDING.CLASS.AT.TIME.OF.SALE" "SALE.PRICE"                    
## [21] "SALE.DATE"
```

###*_Now, reformat Column Headings into R consistent variable naming convention:_*

```r
names(bronx)[1:21] <- tolower(names(bronx)[1:21])
names(bronx) <- paste(toupper(substring(names(bronx), 1, 1)), tolower(substring(names(bronx), 2)), sep = "")
names(bronx) <- gsub("(\\..)","\\U\\1", names(bronx), perl=TRUE)
names(bronx) <- gsub("(\\.)", "", names(bronx))
names(bronx)
```

```
##  [1] "Borough"                   "Neighborhood"             
##  [3] "BuildingClassCategory"     "TaxClassAtPresent"        
##  [5] "Block"                     "Lot"                      
##  [7] "EaseMent"                  "BuildingClassAtPresent"   
##  [9] "Address"                   "ApartmentNumber"          
## [11] "ZipCode"                   "ResidentialUnits"         
## [13] "CommercialUnits"           "TotalUnits"               
## [15] "LandSquareFeet"            "GrossSquareFeet"          
## [17] "YearBuilt"                 "TaxClassAtTimeOfSale"     
## [19] "BuildingClassAtTimeOfSale" "SalePrice"                
## [21] "SaleDate"
```

###*_Next, transform the Borough of "2" into more meaningful such as text: "Bronx":_*

```r
bronx$Borough <- ifelse(bronx$Borough == 2, "Bronx", "")
```

###*_Break up multiple variables stored in column and then delete the original column:_*

```r
bronx$BuildingClassCategoryCode <- substr(bronx$BuildingClassCategory,1,2)
bronx$BuildingClassDescription <- substr(bronx$BuildingClassCategory,4, length(bronx$BuildingClassCategory))
```

###*_Delete old multiple variable column from dataset and Easement contains no data removing from dataset as well:_*

```r
bronx <- bronx[, -c(3, 7)]
```

###*_Move newly created variables(columns) back to original place in dataset:_*

```r
bronx <- bronx[, c(1, 2, 20, 21, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)]
head(bronx,1)
```

```
##   Borough              Neighborhood BuildingClassCategoryCode
## 1   Bronx BATHGATE                                         01
##                    BuildingClassDescription TaxClassAtPresent Block Lot
## 1  ONE FAMILY DWELLINGS                                     1  3028  25
##   BuildingClassAtPresent                                     Address
## 1                     A5  412 EAST 179 STREET                       
##   ApartmentNumber ZipCode ResidentialUnits              CommercialUnits
## 1                   10457                1                          -  
##   TotalUnits LandSquareFeet GrossSquareFeet YearBuilt TaxClassAtTimeOfSale
## 1          1          1,842           2,048      1901                    1
##   BuildingClassAtTimeOfSale                    SalePrice SaleDate
## 1                       A5                          -    4/4/2017
```
###*_Remove dashes "-" in the Residential/Commercial Units columns and set it reflect 0:_*

```r
bronx$ResidentialUnits <- gsub("(\\-)","0", (bronx$ResidentialUnits))
bronx$CommercialUnits <- gsub("(\\-)","0", (bronx$CommercialUnits))
```

###*_Convert variables into proper datatypes:_*

```r
## Convert variables into proper datatypes
bronx$Borough <- as.character(bronx$Borough)
bronx$Neighborhood <- as.character(bronx$Neighborhood)
bronx$Address <- as.character(bronx$Address)
bronx$ApartmentNumber <- as.character(bronx$ApartmentNumber)
bronx$ZipCode <- as.character(bronx$ZipCode)
bronx$ResidentialUnits <- as.integer(bronx$ResidentialUnits)
bronx$CommercialUnits <- as.integer(bronx$CommercialUnits)
bronx$TotalUnits <- as.integer(bronx$TotalUnits)
bronx$TaxClassAtTimeOfSale <- as.factor(bronx$TaxClassAtTimeOfSale)
str(bronx)
```

```
## 'data.frame':	6842 obs. of  21 variables:
##  $ Borough                  : chr  "Bronx" "Bronx" "Bronx" "Bronx" ...
##  $ Neighborhood             : chr  "BATHGATE                 " "BATHGATE                 " "BATHGATE                 " "BATHGATE                 " ...
##  $ BuildingClassCategoryCode: chr  "01" "01" "01" "01" ...
##  $ BuildingClassDescription : chr  " ONE FAMILY DWELLINGS                    " " ONE FAMILY DWELLINGS                    " " ONE FAMILY DWELLINGS                    " " ONE FAMILY DWELLINGS                    " ...
##  $ TaxClassAtPresent        : Factor w/ 9 levels "  ","1","1A",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ Block                    : int  3028 3030 3036 3037 3043 3046 3046 3048 3048 3053 ...
##  $ Lot                      : int  25 56 13 101 55 52 52 27 28 105 ...
##  $ BuildingClassAtPresent   : Factor w/ 97 levels "  ","A1","A2",..: 5 2 2 80 2 2 2 2 2 2 ...
##  $ Address                  : chr  " 412 EAST 179 STREET                       " " 412 EAST 182 STREET                       " " 4348 PARK AVENUE                          " " 443 EAST 180 STREET                       " ...
##  $ ApartmentNumber          : chr  "            " "            " "            " "            " ...
##  $ ZipCode                  : chr  "10457" "10457" "10457" "10457" ...
##  $ ResidentialUnits         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ CommercialUnits          : int  0 0 0 2 0 0 0 0 0 0 ...
##  $ TotalUnits               : int  3 3 3 41 3 3 3 3 3 3 ...
##  $ LandSquareFeet           : Factor w/ 1838 levels "              -  ",..: 273 53 1256 51 694 677 677 34 34 1828 ...
##  $ GrossSquareFeet          : Factor w/ 1932 levels "                  -  ",..: 653 188 368 1025 652 183 183 19 19 90 ...
##  $ YearBuilt                : int  1901 1899 1899 1952 1901 1901 1901 1901 1901 1901 ...
##  $ TaxClassAtTimeOfSale     : Factor w/ 3 levels "1","2","4": 1 1 1 1 1 1 1 1 1 1 ...
##  $ BuildingClassAtTimeOfSale: Factor w/ 96 levels " A1 "," A2 ",..: 4 1 1 79 1 1 1 1 1 1 ...
##  $ SalePrice                : Factor w/ 1492 levels "                        -   ",..: 1 270 870 1 398 497 420 1 527 1 ...
##  $ SaleDate                 : Factor w/ 306 levels "1/1/2017","1/10/2017",..: 172 10 119 279 216 294 294 293 298 133 ...
```

###*_Next, removed $ and comma from the SalesPrice column so numerical analysis can be ran on numbers and replacing NAs with 0:_* 

```r
bronx$SalePrice <- as.numeric(gsub('\\$|,', '', bronx$SalePrice))
```

```
## Warning: NAs introduced by coercion
```

```r
bronx$SalePrice[is.na(bronx$SalePrice)] <- 0
bronx$LandSquareFeet <- as.integer(gsub('\\,', '',bronx$LandSquareFeet))
```

```
## Warning: NAs introduced by coercion
```

```r
bronx$LandSquareFeet[is.na(bronx$LandSquareFeet)] <- 0
bronx$GrossSquareFeet <- as.integer(gsub('\\,', '',bronx$GrossSquareFeet))
```

```
## Warning: NAs introduced by coercion
```

```r
bronx$GrossSquareFeet[is.na(bronx$GrossSquareFeet)] <- 0
bronx$TaxClassAtPresent <- sub("^$", "0", bronx$TaxClassAtPresent)
bronx$SaleDate <- as.Date(bronx$SaleDate, format="%m/%d/%Y")
head(bronx$SalePrice)
```

```
## [1]      0 178000 420000      0 220000 273796
```

###*_Calculate TotalUnits from Residential + Commerical to correct after Factor conversion:_*

```r
bronx$TotalUnits <- bronx$ResidentialUnits + bronx$CommercialUnits
```

###*_Fill in missing zip codes using blockCode dataset:_*

```r
bronx$ZipCode <- ifelse(blockCode$BLOCK == bronx$Block, bronx$ZipCode <- blockCode$ZIP.CODE, bronx$ZipCode)
```

###*_Review the first few and last few rows of the revised tidy/clean dataset:_*

```r
head(bronx, n=3)
```

```
##   Borough              Neighborhood BuildingClassCategoryCode
## 1   Bronx BATHGATE                                         01
## 2   Bronx BATHGATE                                         01
## 3   Bronx BATHGATE                                         01
##                    BuildingClassDescription TaxClassAtPresent Block Lot
## 1  ONE FAMILY DWELLINGS                                     1  3028  25
## 2  ONE FAMILY DWELLINGS                                     1  3030  56
## 3  ONE FAMILY DWELLINGS                                     1  3036  13
##   BuildingClassAtPresent                                     Address
## 1                     A5  412 EAST 179 STREET                       
## 2                     A1  412 EAST 182 STREET                       
## 3                     A1  4348 PARK AVENUE                          
##   ApartmentNumber ZipCode ResidentialUnits CommercialUnits TotalUnits
## 1                   10457                1               0          1
## 2                   10457                1               0          1
## 3                   10457                1               0          1
##   LandSquareFeet GrossSquareFeet YearBuilt TaxClassAtTimeOfSale
## 1           1842            2048      1901                    1
## 2           1306            1440      1899                    1
## 3           3525            1764      1899                    1
##   BuildingClassAtTimeOfSale SalePrice   SaleDate
## 1                       A5          0 2017-04-04
## 2                       A1     178000 2017-01-19
## 3                       A1     420000 2017-02-03
```

```r
tail(bronx, n=3)
```

```
##      Borough              Neighborhood BuildingClassCategoryCode
## 6840   Bronx WOODLAWN                                         22
## 6841   Bronx WOODLAWN                                         22
## 6842   Bronx WOODLAWN                                         41
##                       BuildingClassDescription TaxClassAtPresent Block Lot
## 6840  STORE BUILDINGS                                          4  3365  79
## 6841  STORE BUILDINGS                                          4  3365  79
## 6842  TAX CLASS 4 - OTHER                                      4  3365  71
##      BuildingClassAtPresent                                     Address
## 6840                     K9  63 EAST 233RD STREET                      
## 6841                     K9  63 EAST 233RD STREET                      
## 6842                     Z9  69 EAST 233RD STREET                      
##      ApartmentNumber ZipCode ResidentialUnits CommercialUnits TotalUnits
## 6840                   10470                1               1          2
## 6841                   10470                1               1          2
## 6842                   10470                0               1          1
##      LandSquareFeet GrossSquareFeet YearBuilt TaxClassAtTimeOfSale
## 6840          10269            4228      1931                    4
## 6841          10269            4228      1931                    4
## 6842          15352            3825      1931                    4
##      BuildingClassAtTimeOfSale SalePrice   SaleDate
## 6840                       K9    1085250 2017-04-17
## 6841                       K9          0 2017-04-17
## 6842                       Z9    1414750 2017-04-17
```

###*_Export the revised tidy/clean datset:_*

```r
write.table(bronx, "mydata.txt", sep="\t")
```

###*_Plot the data as-is and then transformed using log transformation:_*

```r
bronx_sale <- bronx[bronx$SalePrice != 0,]
plot(bronx_sale$GrossSquareFeet, bronx_sale$SalePrice)
```

![](Bronx_ARMSV18Jun17_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

```r
plot(log10(bronx_sale$GrossSquareFeet), log10(bronx_sale$SalePrice))
```

![](Bronx_ARMSV18Jun17_files/figure-html/unnamed-chunk-16-2.png)<!-- -->

###*_Let's look at 1-, 2-, and 3-family homes_*

```r
bronx_homes <- bronx_sale[which(grepl("FAMILY",bronx_sale$BuildingClassDescription)),]
dim(bronx_homes)
```

```
## [1] 2811   21
```

```r
plot(log10(bronx_homes$GrossSquareFeet),log10(bronx_homes$SalePrice))
```

![](Bronx_ARMSV18Jun17_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

```r
summary(bronx_homes[which(bronx_homes$salePrice<100000),])
```

```
##    Borough          Neighborhood       BuildingClassCategoryCode
##  Length:0           Length:0           Length:0                 
##  Class :character   Class :character   Class :character         
##  Mode  :character   Mode  :character   Mode  :character         
##                                                                 
##                                                                 
##                                                                 
##                                                                 
##  BuildingClassDescription TaxClassAtPresent      Block          Lot     
##  Length:0                 Length:0           Min.   : NA   Min.   : NA  
##  Class :character         Class :character   1st Qu.: NA   1st Qu.: NA  
##  Mode  :character         Mode  :character   Median : NA   Median : NA  
##                                              Mean   :NaN   Mean   :NaN  
##                                              3rd Qu.: NA   3rd Qu.: NA  
##                                              Max.   : NA   Max.   : NA  
##                                                                         
##  BuildingClassAtPresent   Address          ApartmentNumber   
##         :0              Length:0           Length:0          
##  A1     :0              Class :character   Class :character  
##  A2     :0              Mode  :character   Mode  :character  
##  A3     :0                                                   
##  A5     :0                                                   
##  A6     :0                                                   
##  (Other):0                                                   
##     ZipCode    ResidentialUnits CommercialUnits   TotalUnits 
##  Min.   : NA   Min.   : NA      Min.   : NA     Min.   : NA  
##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA     1st Qu.: NA  
##  Median : NA   Median : NA      Median : NA     Median : NA  
##  Mean   :NaN   Mean   :NaN      Mean   :NaN     Mean   :NaN  
##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA     3rd Qu.: NA  
##  Max.   : NA   Max.   : NA      Max.   : NA     Max.   : NA  
##                                                              
##  LandSquareFeet GrossSquareFeet   YearBuilt   TaxClassAtTimeOfSale
##  Min.   : NA    Min.   : NA     Min.   : NA   1:0                 
##  1st Qu.: NA    1st Qu.: NA     1st Qu.: NA   2:0                 
##  Median : NA    Median : NA     Median : NA   4:0                 
##  Mean   :NaN    Mean   :NaN     Mean   :NaN                       
##  3rd Qu.: NA    3rd Qu.: NA     3rd Qu.: NA                       
##  Max.   : NA    Max.   : NA     Max.   : NA                       
##                                                                   
##  BuildingClassAtTimeOfSale   SalePrice      SaleDate 
##   A1    :0                 Min.   : NA   Min.   :NA  
##   A2    :0                 1st Qu.: NA   1st Qu.:NA  
##   A3    :0                 Median : NA   Median :NA  
##   A5    :0                 Mean   :NaN   Mean   :NA  
##   A6    :0                 3rd Qu.: NA   3rd Qu.:NA  
##   A7    :0                 Max.   : NA   Max.   :NA  
##  (Other):0
```

###*_Remove outliers that seem like they weren't actual sales and plot again:_*

```r
bronx_homes$outliers <- (log10(bronx_homes$SalePrice) <=5) + 0
bronx_homes <- bronx_homes[which(bronx_homes$outliers==0),]
plot(log10(bronx_homes$GrossSquareFeet),log10(bronx_homes$SalePrice))
```

![](Bronx_ARMSV18Jun17_files/figure-html/unnamed-chunk-18-1.png)<!-- -->






















