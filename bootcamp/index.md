---
id: 1834
title: Course&#58; Intro to R Bootcamp
date: 2017-02-01
author: Bo Werth
layout: page
permalink: /r_bootcamp
---


### Class Information

* R Programming I - Overview
* Date: 26 April 2017

* R Programming II - Graphics
* Date: 4 May 2017

<!-- * Location: OECD, Paris, France -->
<!-- * Webpage: [boot.rdata.work/r_bootcamp](http://boot.rdata.work/r_bootcamp) -->
<!-- * Additional Resources: [http://github.com/bowerth/boot-r](http://github.com/bowerth/boot-r) -->

### Course Description 

This short course provides an intensive, hands-on introduction to the R programming language to provide students with the fundamental programming skills required to start their journey to becoming a modern day data analyst.

### Course Objectives
Upon successfully completing this course, students will:

- Be up and running with R
- Understand the different types of data R can work with
- Understand the different structures in which R holds data
- Be able Import data into R
- Perform basic data wrangling activities with R
- Compute basic descriptive statistics with R
- Visualize their data with base R and ggplot graphics


### Structure of Class Time 

The two in-class sessions will consist of both lectures, live coding by the instructor and hands on programming by the students. The hands on practice will be sequential in which students will practice applying code as it is learned. 


### Material
You can download the required classroom material here: &nbsp; <a href="https://dl.dropboxusercontent.com/u/1807228/bootcamp.zip?dl=1" style="color:black;"><i class="fa fa-folder-open" style="font-size:1em"></i></a>.  In this file you will find the slides, data, and initial code scripts that we will go through in class.


### Schedule


| Session | Description | Resources | 
|:---:|---|:---:|
| 1 | Introduction & Getting started with R | <a href="bootcamp/1-intro" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/1-intro/1-intro.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 2 | Importing text and Excel data into R | <a href="bootcamp/2-get-data" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/2-get-data/2-get-data.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 3 | Understanding the primary data structures that R uses to hold your data | <a href="bootcamp/3-data-structures" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/3-data-structures/3-data-structures.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 4 | Understanding the basics of working with different types of data | <a href="bootcamp/4-data-types" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/4-data-types/4-data-types.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 5 | Creating tidy data sets | <a href="bootcamp/5-tidy-data" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/5-tidy-data/5-tidy-data.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  |
| 6 | Transforming & manipulating data made easy | <a href="bootcamp/6-dplyr-data" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/6-dplyr-data/6-dplyr-data.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 7 | Quick plots for early exploratory data analysis | <a href="bootcamp/7-quickplots" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/7-quickplots/7-quickplots.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| 8 | Advanced plotting with ggplot | <a href="bootcamp/8-ggplot" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="bootcamp/8-ggplot/8-ggplot.R" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |

<!-- | 9 | Case study 1: TiVA Country Notes | <a href="http://sti.rdata.work/report_icio_tiva_AUT.html" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="http://countrynote.rdata.work/articles/countrynote.html" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp; <a href="https://github.com/bowerth/countrynote" style="color:black;"><i class="fa fa-database" aria-hidden="true"></i></a> | -->
<!-- | 10 | Case study 2: scraping pap.fr | <a href="http://estate.rdata.work/articles/estate.html" style="color:black;"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></a> &nbsp; <a href="https://raw.githubusercontent.com/bowerth/estate/master/vignettes/estate.Rmd" style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a> &nbsp; <a href="https://github.com/bowerth/estate" style="color:black;"><i class="fa fa-database" aria-hidden="true"></i></a> | -->


### Hands-on Practice

#### Starting R

Portable version
:   Start RStudio from `\\asap1\em_apps$\R`

OECD R Server
:   Log on to server `AS-GEN-1`, start RStudio and set R installation:  
	`\\\\asap1\\em_apps\$\\R\\R-3.3.1`

~~~
setwd("T:/DKI/rtrainings/bootcamp/code-scripts")
~~~

<!-- Cloud Server -->
<!-- : Open &nbsp; <a href="http://rstudio.rdata.work:8787/" style="color:black;"><i -->
  <!-- class="fa fa-cloud" aria-hidden="true"></i></a> &nbsp; in Google Chrome -->

Private device 
: Participants can follow the exercises using their personal devices. When using
  a local R installation, not all examples can be executed without installation
  of additional packages. The package install R script is available at &nbsp; <a
  href="https://dl.dropboxusercontent.com/u/1807228/install-packages.R?dl=1"
  style="color:black;"><i class="fa fa-file-code-o" aria-hidden="true"></i></a>
  &nbsp; The package installation can take up to 10 minutes.

