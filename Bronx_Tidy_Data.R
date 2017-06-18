
setwd("E:/Users/Andy/Desktop")

## Read in only the first 4 lines of the data because it is only descriptive information about the dataset
bronx_descrip <- read.csv("rollingsales_bronx.csv", nrows=4, header= FALSE)

## Only keep the first column of the descriptive data
bronx_descrip2 <- bronx_descrip[,1, drop = FALSE]

## Read in the remainder of the dataset as is for now
bronx <- read.csv("rollingsales_bronx.csv", skip=4, header=TRUE)

## Create ZipCode file to use later to fill in missing zipcodes
blockCode <- bronx[c(5,11)]

## Look at structure of dataset
dim(bronx)
str(bronx)
names(bronx)

## Reformat Column Headings into R consistent variable naming convention 
names(bronx)[1:21] <- tolower(names(bronx)[1:21])
names(bronx) <- paste(toupper(substring(names(bronx), 1, 1)), tolower(substring(names(bronx), 2)), sep = "")
names(bronx) <- gsub("(\\..)","\\U\\1", names(bronx), perl=TRUE)
names(bronx) <- gsub("(\\.)", "", names(bronx))

## Transform the Borough of "2" into more meaningful such as text: "Bronx"
bronx$Borough <- ifelse(bronx$Borough == 2, "Bronx", "")

## Break up multiple variables stored in column and then delete the original column
bronx$BuildingClassCategoryCode <- substr(bronx$BuildingClassCategory,1,2)
bronx$BuildingClassDescription <- substr(bronx$BuildingClassCategory,4, length(bronx$BuildingClassCategory))

## Delete old multiple variable column from dataset **Easement contains no data removing from dataset as well
bronx <- bronx[, -c(3, 7)]

## Move newly created variables(columns) back to original place in dataset
bronx <- bronx[, c(1, 2, 20, 21, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)]

## Remove dashes "-" in the Residential and Commercial Units columns and set it reflect 0
bronx$ResidentialUnits <- gsub("(\\-)","0", (bronx$ResidentialUnits))
bronx$CommercialUnits <- gsub("(\\-)","0", (bronx$CommercialUnits))

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

## Removing $ and comma from the SalesPrice column so numerical analysis can be ran on numbers and replacing NAs with 0 
bronx$SalePrice <- as.numeric(gsub('\\$|,', '', bronx$SalePrice))
bronx$SalePrice[is.na(bronx$SalePrice)] <- 0
bronx$LandSquareFeet <- as.integer(gsub('\\,', '',bronx$LandSquareFeet))
bronx$LandSquareFeet[is.na(bronx$LandSquareFeet)] <- 0
bronx$GrossSquareFeet <- as.integer(gsub('\\,', '',bronx$GrossSquareFeet))
bronx$GrossSquareFeet[is.na(bronx$GrossSquareFeet)] <- 0
bronx$TaxClassAtPresent <- sub("^$", "0", bronx$TaxClassAtPresent)
bronx$SaleDate <- as.Date(bronx$SaleDate, format="%m/%d/%Y")

## Calculate TotalUnits from Residential + Commerical to correct after Factor conversion
bronx$TotalUnits <- bronx$ResidentialUnits + bronx$CommercialUnits

## Fill in missing zip codes using blockCode dataset
bronx$ZipCode <- ifelse(blockCode$BLOCK == bronx$Block, bronx$ZipCode <- blockCode$ZIP.CODE, bronx$ZipCode)

## Review the first few and last few rows of the tidy/clean dataset
head(bronx)
tail(bronx)

## Export new file
write.table(bronx, "mydata.txt", sep="\t")

## Plot data
bronx_sale <- bronx[bronx$SalePrice != 0,]
plot(bronx_sale$GrossSquareFeet, bronx_sale$SalePrice)
plot(log10(bronx_sale$GrossSquareFeet), log10(bronx_sale$SalePrice))

## Let's look at 1-, 2-, and 3-family homes
bronx_homes <- bronx_sale[which(grepl("FAMILY",bronx_sale$BuildingClassDescription)),]
dim(bronx_homes)
plot(log10(bronx_homes$GrossSquareFeet),log10(bronx_homes$SalePrice))
summary(bronx_homes[which(bronx_homes$salePrice<100000),])

## Remove outliers that seem like they weren't actual sales
bronx_homes$outliers <- (log10(bronx_homes$SalePrice) <=5) + 0
bronx_homes <- bronx_homes[which(bronx_homes$outliers==0),]
plot(log10(bronx_homes$GrossSquareFeet),log10(bronx_homes$SalePrice))

