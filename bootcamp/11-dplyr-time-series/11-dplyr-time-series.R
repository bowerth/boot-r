## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)
## Generation of requested POCs shared at http://dki.rdata.work/visualisation/
## Training session to explain concepts employed in POCs (June 2017)

## https://stackoverflow.com/questions/30678606/quarterly-year-over-year-growth-rate
## https://blog.exploratory.io/introducing-time-series-analysis-with-dplyr-60683587cf8a


## ----xaringan_startup, echo=FALSE, message=FALSE, warning=FALSE----------
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

library(knitr)
opts_chunk$set(digits = 3, tidy = FALSE,
               fig.path = '11-dplyr-time-series/fig-html/',
               fig.height = 3.5, fig.width = 10,
               dev = "svg")


## ----load_sna_table, results='as.is'-------------------------------------
sna_dat <- read.csv("../data/sna_table6a.csv")
var_table <- c("LOCATION", "TRANSACT", "ACTIVITY", "MEASURE", "TIME", "Value")
sna_dat %>% select_(.dots = var_table) %>% head(10) %>% knitr::kable("html")


## ----sna_total_table, results='as.is'------------------------------------
sna_dat_tot <-
  sna_dat %>% filter(ACTIVITY == "VTOT") %>%
  mutate(value_total = Value) %>%
  select(LOCATION, TRANSACT, MEASURE, TIME, value_total)

sna_dat_tot %>% head(10) %>% knitr::kable("html")


## ----sna_share_table, results='as.is'------------------------------------
sna_dat_share <- sna_dat %>%
  left_join(sna_dat_tot, by = c("LOCATION", "TRANSACT", "MEASURE", "TIME")) %>%
  mutate(share = Value / value_total)

sna_dat_share %>% select_(.dots = c(var_table, "value_total", "share")) %>%
  filter(ACTIVITY!="VTOT") %>% head(10) %>% knitr::kable("html")


## ----data_plot_sna, tidy=FALSE, warning=FALSE, message=FALSE, echo=TRUE, eval=TRUE, fig.height=4.5, fig.width = 12----
sna_dat_share %>%
  filter(LOCATION%in%c("AUT","BEL") & ACTIVITY!="VTOT" & MEASURE=="C") %>%
  ggplot(aes(x = TIME, y = share, color = ACTIVITY)) + geom_line() +
  facet_grid(Country ~ Transaction) + scale_color_discrete(guide = guide_legend(ncol = 2))


## ----data_table_sna, tidy=FALSE, warning=FALSE, message=FALSE, eval=TRUE----
sna_dat_share_b1ga_2016_top3 <- sna_dat_share %>%
  filter(ACTIVITY != "VTOT", TRANSACT == "B1GA", MEASURE == "C", TIME == "2016") %>%
  group_by(LOCATION) %>% top_n(3, wt = share)


## ----show_table, echo=FALSE, results='as.is'-----------------------------
sna_dat_share_b1ga_2016_top3 %>%
  mutate(share = round(share, 2)) %>%
  select("LOCATION", "TRANSACT", "MEASURE", "TIME",
         "ACTIVITY", "Value", "value_total", "share") %>%
  arrange(LOCATION, desc(share)) %>%
  head(n = 10) %>%
  knitr::kable('html')


## ----plot_top_sna, fig.width=12, fig.height=4.5--------------------------
sna_dat_share_b1ga_2016_top3 %>%
  ggplot(aes(x = LOCATION, y = share, fill = Activity)) +
  geom_bar(stat = "identity", position = "stack", width = 0.6) +
  scale_fill_discrete(guide = guide_legend(nrow = 3)) +
  theme(legend.position = "top", legend.direction = "horizontal")


## ----sna_covert_date-----------------------------------------------------
sna_dat2 <- sna_dat %>% mutate(date = as.Date(paste0(TIME, "-01-01")))
head(sna_dat2$date, 5); class(sna_dat2$date)
dplyr::lag(head(sna_dat2$date, 5))
stats::lag(head(sna_dat2$date, 5))
## ?lag


## ----sna_growth_data, results="as.is"------------------------------------
sna_growth <- sna_dat2 %>%
  group_by(LOCATION, TRANSACT, ACTIVITY, MEASURE) %>%
  mutate(value_lag = lag(Value), growth = Value / value_lag - 1)

sna_growth %>% select_(.dots = c(var_table, "Value", "value_lag", "growth")) %>%
  head(10) %>% knitr::kable("html")


## ----sna_growth_sort, echo=TRUE------------------------------------------
sna_growth_top <- sna_growth %>% filter(ACTIVITY == "VTOT" & TRANSACT == "B1GA") %>%
  group_by(LOCATION) %>% top_n(n = 1, wt = abs(growth)) %>% arrange(desc(growth))

sna_growth$LOCATION <-
  factor(sna_growth$LOCATION, levels = as.character(sna_growth_top$LOCATION))

sna_growth_top %>% select_(.dots = c(var_table, "Value", "value_lag", "growth")) %>%
  head(10) %>% knitr::kable("html")


## ----sna_growth_plot, warning=FALSE, eval=TRUE, fig.width=12, fig.height=4.5----
sna_growth %>% filter(LOCATION%in%sna_growth_top$LOCATION[1:8] &
                      ACTIVITY == "VTOT" & TRANSACT == "B1GA") %>%
  ggplot(aes(x = date, y = growth, color = Measure)) +
  geom_line(size = 1) + facet_wrap( ~ LOCATION, ncol = 4) +
  theme(legend.position = "top", legend.direction = "horizontal")


## ----create-data, echo=TRUE----------------------------------------------
date <- c("2000-01-01","2000-04-01", "2000-07-01",
          "2000-10-01","2001-01-01","2001-04-01",
          "2001-07-01","2001-10-01","2002-01-01",
          "2002-04-01","2002-07-01","2002-10-01")
value <- c(1592,1825,1769,1909,2022,2287,2169,2366,2001,2087,2099,2258)
df <- data.frame(date,value)

## Convert date column to date format
df$date = as.POSIXct(df$date)


## ----quarter-growth-rate, echo=TRUE--------------------------------------
df_q <- df %>% group_by(month=month(date)) %>%
  arrange(date) %>%
  mutate(yearOverYear=value/lag(value,1))


## ----quarter-growth-rate-show, echo=FALSE--------------------------------
head(df_q)


## ----quarter-growth-rate-test--------------------------------------------
## value[2001-01-01] / value[2000-01-01]
2022 / 1592


## ----airpassenger_data---------------------------------------------------
data(AirPassengers)
AP <- AirPassengers
head(AP)
class(AP)


## ----airpassenger_method-------------------------------------------------
start(AP); end(AP); frequency(AP); summary(AP)


## ----airpassenger_plot---------------------------------------------------
par(mfrow = c(1, 2)); plot(AP, ylab = "Passengers (1000's)"); plot(aggregate(AP))


## ----airpassenger_dualplot, echo=TRUE------------------------------------
par(mfrow = c(1, 2)); plot(aggregate(AP)); boxplot(AP ~ cycle(AP))


## ------------------------------------------------------------------------
## www <- "http://www.massey.ac.nz/~pscowper/ts/USunemp.dat"
www <- "https://raw.githubusercontent.com/AtefOuni/ts/master/Data/USunemp.dat"
US.month <- read.table(www, header = T)
attach(US.month)
US.month.ts <- ts(USun, start=c(1996,1), end=c(2006,10), freq = 12)
plot(US.month.ts, ylab = "unemployed (%)")


## ------------------------------------------------------------------------
## Australian chocolate, beer, and electricity production
## January 1958 – December 1990.
## www <- "http://www.massey.ac.nz/~pscowper/ts/cbe.dat"
www <- "https://raw.githubusercontent.com/kaybenleroll/dublin_r_workshops/master/ws_timeseries_201309/cbe.dat"
CBE <- read.table(www, header = T)
CBE[1:4, ]
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
Beer.ts <- ts(CBE[, 2], start = 1958, freq = 12)
Choc.ts <- ts(CBE[, 1], start = 1958, freq = 12)
plot(cbind(Elec.ts, Beer.ts, Choc.ts))


## ------------------------------------------------------------------------
AP.elec <- ts.intersect(AP, Elec.ts)



## ----sys-info, echo=FALSE, eval=FALSE------------------------------------
## sessionInfo()

