## Session 2: Get me some data!

######################
## Built-in Data Sets #
######################

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



#########################
## Importing Excel Files #
#########################
## install.packages("readxl")
library(readxl)

read_excel("../data/mydata.xlsx", sheet = "Sheet5")

## people love to make notes at the top of Excel files
read_excel("../data/mydata.xlsx", sheet = "Sheet3")
read_excel("../data/mydata.xlsx", sheet = "Sheet3", skip = 2)



##############
## YOUR TURN! #
##############
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
## Scraping Online Files #
#########################

## scraping text files
url <- "https://www.data.gov/media/federal-agency-participation.csv" 
data_gov <- read.csv(url)

View(data_gov)

## scraping Excel files
library(gdata)

url <- "http://www.huduser.org/portal/datasets/fmr/fmr2015f/FY2015F_4050_Final.xls"
rents <- read.xls(url)

View(rents)




#########################
## Scraping SDMX Data   #
#########################

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




##############
## YOUR TURN! #
##############
## 1. Download the file stored at: https://dl.dropboxusercontent.com/u/1807228/reddit.csv?dl=1

url <- "https://dl.dropboxusercontent.com/u/1807228/reddit.csv?dl=1"
read.csv(url)

## 2. Save it as an object titled reddit
reddit <- read.csv(url)

## 3. Take a peek at what this data looks like
View(reddit)


