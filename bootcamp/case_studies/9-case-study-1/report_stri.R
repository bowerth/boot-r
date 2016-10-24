## Load packages
library(brew)
library(knitr)
library(markdown)
library(readxl)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(gridExtra)
library(scales)
library(dplyr)
library(tidyr)

## Set working directory
## path <- file.path(dbpath, "GitHub", "jekyll", "sti", "extras", "brew_report_stri")
path <- getwd()
path.Rmd <- file.path(path, "Rmd") # Rnw and tex files are created here
path.rmd <- file.path(path, "md")
setwd(path)

## Load data
data_figures <-
    file.path("data", "stri_figures_aut_deu_notes_2015.csv") %>%
        read.csv() %>%
            setNames(tolower(names(.))) %>%
                tidyr::gather(key = var, value = value, -membership, -cou3, -sector_id, -sector_name, -sector_code)

## Sorting factor levels
sector_levels <- unique(data_figures$sector_name[order(data_figures$sector_id)])
data_figures$sector_name = factor(data_figures$sector_name, levels = sector_levels)

data_shares <-
    file.path("data", "stri_services_shares_graphs_2015.csv") %>%
        read.csv() %>%
            setNames(tolower(names(.))) %>%
                tidyr::gather(key = var, value = value, -cou_label, -cou3)
## h(data_shares)

namereg <-
    file.path("data", "namereg.csv") %>%
        read.csv()

cntext <-
  file.path("text", "CN_custom_text.xlsx") %>%
  readxl::read_excel(sheet = 1) %>%
  as.data.frame

## Set parameters
year <- 2014

## Define colours
fill_1 <- rgb(red = 41, green = 80, blue = 131, alpha = 255, maxColorValue = 255)
fill_2 <- rgb(red = 255, green = 255, blue = 201, alpha = 255, maxColorValue = 255)
fill_3 <- rgb(red = 252, green = 163, blue = 82, alpha = 255, maxColorValue = 255)
fill_4 <- rgb(red = 220, green = 212, blue = 232, alpha = 255, maxColorValue = 255)
fill_5 <- rgb(red = 61, green = 147, blue = 61, alpha = 255, maxColorValue = 255)
plot_fill <- c(fill_1, fill_2, fill_3, fill_4, fill_5)

colour_1 <- rgb(red = 255, green = 102, blue = 153, alpha = 255, maxColorValue = 255)
colour_2 <- rgb(red = 75, green = 172, blue = 198, alpha = 255, maxColorValue = 255)
plot_colour <- c(colour_1, colour_2)

## Create function md output
create.report <- function(x, prepend = "report_stri_"){
  Rmd.file <- file.path(path.Rmd, paste0(prepend, x, ".Rmd"))
  rmd.file <- file.path(path.rmd, paste0(prepend, x, ".md"))
  brew(file = file.path(path, "report_stri.brew"), output = Rmd.file)
  knit(input = Rmd.file, output = rmd.file)
  out.file <- paste0(prepend, x, ".md")
  return(out.file)
}

## Create function pdf output
path.pdf <- file.path(path, "pdf")
create.report.pdf <- function(x, prepend = "report_stri_"){
  Rmd.file <- file.path(path.Rmd, paste0(prepend, x, ".Rmd"))
  brew(file = file.path(path, "report_stri.brew"), output = Rmd.file)
  pdf.file <- file.path(path.pdf, paste0(prepend, x, ".pdf"))
  rmarkdown::render(input = Rmd.file, output_dir = path.pdf, output_format = "pdf_document")
  return(pdf.file)
}

## scipen: fixed notation will be preferred unless it is more than ‘scipen’
## digits wider
options(scipen=8)

## Modify text size
axis.text.size=12
legend.text.size=14

## coulist <- sample(STAN.COU[["OECD"]], 5)
coulist <- c("AUT", "DEU") # , "ESP", "IRL", "USA")
seeds <- as.character(coulist)

results <- sapply(seeds, create.report)
## results <- sapply(seeds, create.report.pdf)


# ## Include output in jekyll site
# for (file in list.files(file.path(path, "md"))) {
#   file.copy(from = file.path(path, "md", file), to = file.path(dbpath, "GitHub", "jekyll", "industry", file), overwrite = TRUE)
# }

# if (Sys.info()["sysname"]=="Windows") {
#     system(paste0('xcopy "', file.path(path, "figures", "report_stri"), '" "', file.path(dbpath, "GitHub", "jekyll", "sti", "figures", "report_stri"), '" /e /Y'))
# } else {
#     system(paste('cp -r', file.path(path, "figures", "report_stri"), file.path(dbpath, "GitHub", "jekyll", "sti", "figures")))
# }


#########################
## include menus
#########################
cou.label <- STAN.COUEN[STAN.COUEN$cou%in%coulist,]
cat(paste0('<li><a href="report_stri_', cou.label[,1], '.html">', cou.label[,2], '</a></li>', '\n'))


## #########################
## ## test code scripts
## #########################
## cat(paste0('source(file.path( path, "code", "', list.files(file.path(path, "code")), '"))\n'))
## ## source(file.path( path, "code", "figure0.R"))
## source(file.path( path, "code", "figure1.R"))
## source(file.path( path, "code", "figure2.R"))
