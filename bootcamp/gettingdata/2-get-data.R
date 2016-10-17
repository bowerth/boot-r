## Session 2: Get me some data!

########################
## Built-in Data Sets ##
########################

## R built-in data sets
data()

mtcars
iris
USArrests

## package built-in data sets
library(ggplot2)
data(economics)
economics

## understand more behind the data
?economics



########################
## Importing Text Files #
########################

## importing text files
read.csv("../data/mydata.csv")
read.delim("../data/mydata.txt")

## assign data to new object
mydata <- read.delim("../data/mydata.tsv")
mydata

View(mydata)



##############
## YOUR TURN! #
##############
## 1. Read in the facebook.tsv file in the data folder
head(read.delim("../data/facebook.tsv"))

## 2. Read in and save the facebook.tsv file as an object titled facebook
facebook <- read.delim("../data/facebook.tsv")

## 3. Take a peek at what this data looks like
View(facebook)



###########################
## Importing Excel Files ##
###########################
## install.packages("readxl")
library(readxl)

read_excel("../data/mydata.xlsx", sheet = "Sheet5")

## people love to make notes at the top of Excel files
read_excel("../data/mydata.xlsx", sheet = "Sheet3")
read_excel("../data/mydata.xlsx", sheet = "Sheet3", skip = 2)



################
## YOUR TURN! ##
################
## 1. Read in the spreadsheet titled "3. Median HH income, metro" in the 
## "PEW Middle Class Data.xlsx" file
read_excel("../data/PEW Middle Class Data.xlsx", 
           sheet = "3. Median HH income, metro", 
           skip = 5)

## 2. Save it as an object titled pew
pew <- read_excel("../data/PEW Middle Class Data.xlsx", 
                  sheet = "3. Median HH income, metro", 
                  skip = 5)

## 3. Take a peek at what this data looks like
View(pew)



#########################
## Importing SAS files ##
#########################
## install.packages("haven")
library(haven)

helpfromSAS <- read_sas("../data/help.sas7bdat")
## Variable labels are stored in the "label" attribute of each variable
str(helpfromSAS[, 1:2])

## this dataset stores the SAS format for each variable
path_iris_bdat <- system.file("examples", "iris.sas7bdat", package = "haven")
iris_bdat <- read_sas(path_iris_bdat)
str(iris_bdat)



###########################
## Importing Stata files ##
###########################

carsdataSTATA <- read_dta("../data/carsdata.dta")
psych::describe(carsdataSTATA, skew = FALSE)

carsdataSTATA$cars[1] <- NA
write_dta(carsdataSTATA, path = "../data/carsdata_out.dta", version = 14)

## NA values are read as NaN
read_dta("../data/carsdata_out.dta")[1:3,]

## this dataset stores a label and the Stata format for each variable
## read_stata is equivalent to read_dta
path_iris_dta <- system.file("examples", "iris.dta", package = "haven")
iris_dta <- read_stata(path_iris_dta)
str(iris_dta)

## Older versions of Stata (13 and earlier) did not store the encoding used, and
## you'll need to specify manually. A commonly used value is "Win 1252".



###########################
## Scraping Online Files ##
###########################

## scraping text files
url <- "https://www.data.gov/media/federal-agency-participation.csv" 
data_gov <- read.csv(url)

View(data_gov)

## scraping Excel files
library(gdata)

url <- "http://www.huduser.org/portal/datasets/fmr/fmr2015f/FY2015F_4050_Final.xls"
rents <- read.xls(url)

View(rents)



################
## YOUR TURN! ##
################
## 1. Download the file stored at: https://dl.dropboxusercontent.com/u/1807228/reddit.csv?dl=1

url <- "https://dl.dropboxusercontent.com/u/1807228/reddit.csv?dl=1"
read.csv(url)

## 2. Save it as an object titled reddit
reddit <- read.csv(url)

## 3. Take a peek at what this data looks like
View(reddit)



########################
## Scraping SDMX Data ##
########################

library(RCurl)
curl <- RCurl::getCurlHandle()
## curlSetOpt(.opts = list(proxy = "wsg-proxy.oecd.org:80"), curl = curl)
## obtain from Internet Explorer LAN configuration or PAC automatic configuration script

baseurl <- "http://sdmx.rdata.work"

## manage different queries as list objects
config1 <- list(
  provider = "INSEE",
  flow = "CNA-2005-FBCF-SI-A17",
  dimensions = "S11ES14AA.*.IPCH",
  parameters = "?start=1990"
  )

config2 <- list(
  provider = "OECD",
  flow = "SNA_TABLE1",
  dimensions = "AUS+AUT+BEL.B1_GA+B1G_P119+B1G.C+V",
  parameters = "?start=2009"
  )

config3 <- list(
  provider = "ECB",
  flow = "EXR",
  dimensions = "A+Q+M.USD.EUR.SP00.A",
  parameters = "?start=2010"
  )

## f <- config1
f <- config2
## f <- config3

query <- file.path(f$provider, paste0(f$flow, ".", f$dimensions), f$parameters)
queryurl <- file.path(baseurl, query)

## queryurl
## [1] "http://fast-waters-66121.herokuapp.com/INSEE/CNA-2005-FBCF-SI-A17.S11ES14AA.*.IPCH/?start=1980"
## browseURL(url = queryurl)

## update data cache before export
http_response <- getURL(queryurl)

## export cached result to text string
downloadurl <- file.path(baseurl, "getdownloadsdmx?")
tt <- getURL(downloadurl)
read.csv(text = tt)

## how many missing values?
dat <- read.csv(text = tt)
table(is.na(dat))

## write to disk
csv_file <- "../data/sdmxwide.csv"

filecon <- file(csv_file)
writeLines(text = tt, con = csv_file)
close(filecon)


read.csv(file = csv_file)



#######################
## curling REST APIs ##
#######################

library(nsoApi)
library(xts)
library(dygraphs)

## first, we define the API URI and the dataset ID
api <- "http://opendata.cbs.nl/ODataApi/OData/"
DSD <- "82572ENG" # Input-Output: "83068ENG"

## next, we return the members of a dimension
scheme <- "SectorBranchesSIC2008"

## let's print the resulting REST query
cbs_query <- cbsODataAPI(api=api, DSD=DSD, scheme=scheme, query=TRUE)
cbs_query

## we can view the query result in a browser
browseURL(cbs_query)

cbs_dimension <- cbsODataAPI(api=api, DSD=DSD, scheme=scheme, query=FALSE)
head(cbs_dimension[, 1:2], 20)

## finally, we return a dataset in wide format
scheme <- "TypedDataSet"
cbs_data <- cbsODataAPI(api=api, DSD=DSD, scheme=scheme, query=FALSE)
cbs_data[1:10, 1:5]
str(cbs_data)

## convert to a long format
cbs_df <- cbsOdataDFgather(cbs_data)
str(cbs_df)

## create time series object
cbs_xts <- cbsOdataDFtoXTS(cbs_df)
str(cbs_xts)

## visualize time series
dygraph(data = cbs_xts[, 1:5])

