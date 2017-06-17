##test
setwd("E:/Users/Andy/Desktop")

## Read in only the first 4 lines of the data because it is only descriptive information about the dataset
bronx_descrip <- read.csv("rollingsales_bronx.csv", nrows=4, header= FALSE)

## Only keep the first column of the descriptive data
bronx_descrip2 <- bronx_descrip[,1, drop = FALSE]

## Read in the remainder of the dataset as is for now
bronx <- read.csv("rollingsales_bronx.csv", skip=4, header=TRUE)

## Look at structure of dataset
dim(bronx)
str(bronx)
names(bronx)

## Rename column headings to more meaningful and get rid of spaces:
names(bronx) <- c("Borough", "Neighborhood", "Bldg_Class_Category", "Current_Tax_Class", "Block", "Lot",
                 "Easement", "Current_Bldg_Class", "Address", "Apartment #", "Zip_Code", "# Residential_Units",
                 "# Commercial_Units", "Total_#_Units", "Dwelling_Sq_Ft", "Gross_Sq_Feet", "Year_Built",
                 "Tax_Class_At_Sale", "Bldg_Class_Category_At_Sale", "Sale_Price", "Date_of_Sale")

## Transform the Borough of "2" into more meaningful such as text: "Bronx"
if(bronx$Borough == 2) {
  as.character(bronx$Borough <- "Bronx")
} 

## Break up multiple variables stored in column and then delete the original column
bronx$Bldg_Class_Code <- substr(bronx$Bldg_Class_Category,1,2)
bronx$Bldg_Class_Description <- substr(bronx$Bldg_Class_Category,4, length(bronx$Bldg_Class_Category))

## Delete old multiple variable column from dataset
bronx <- bronx[, c(-3)]

## Move newly created variables(columns) back to original place in dataset
bronx <- bronx[, c(1, 2, 21, 22, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)]


## Change missing data/values into a value (0s, etc)
if(bronx$Current_Tax_Class == "") {
  bronx$Current_Tax_Class  <- "0" 
}



head(bronx)
tail(bronx)


write.table(bronx, "c:\\Users\\1028823491C\\Desktop\\mydata.txt", sep="\t")
