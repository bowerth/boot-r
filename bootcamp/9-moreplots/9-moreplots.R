## ---- echo=FALSE, message=FALSE, results='as.is'-------------------------
library(dplyr)
library(datasauRus)
datasaurus_dozen %>%
  filter(!dataset=="away") %>%
  group_by(dataset) %>%
  summarize(`X Mean` = mean(x),
            `Y Mean` = mean(y),
            `X SD` = sd(x),
            `Y SD` = sd(y),
            Corr. = cor(x, y)
            ) %>%
  knitr::kable()

## ---- echo=FALSE, fig.align='center', fig.height=5, fig.width=10---------
library(ggplot2)
ggplot(datasaurus_dozen[!datasaurus_dozen$dataset=="away", ], aes(x=x, y=y, colour=dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol=4)

## ---- echo=FALSE, fig.align='center', message=FALSE, fig.height=6, fig.width=10----
library(RColorBrewer)
source("../R/moreplots_perceptions.R")

## ---- echo=TRUE, fig.align='center', message=FALSE, fig.height=6, fig.width=6, eval=FALSE----
## library(readr)
## library(tidyr)
## read_csv('../data/moreplots_GEOSTAT_grid_POP_1K_2011_V2_0_1.csv') %>%
##   rbind(read_csv('../data/moreplots_JRC-GHSL_AIT-grid-POP_1K_2011.csv') %>%
##           mutate(TOT_P_CON_DT='')) %>%
##   mutate(lat = as.numeric(gsub('.*N([0-9]+)[EW].*', '\\1', GRD_ID))/100,
##          lng = as.numeric(gsub('.*[EW]([0-9]+)', '\\1', GRD_ID)) *
##            ifelse(gsub('.*([EW]).*', '\\1', GRD_ID) == 'W', -1, 1) / 100) %>%
##   filter(lng > 25, lng < 60) %>%
##   group_by(lat=round(lat, 1), lng=round(lng, 1)) %>%
##   summarize(value = sum(TOT_P, na.rm=TRUE))  %>%
##   ungroup() %>%
##   complete(lat, lng) %>%
##   ggplot(aes(lng, lat + 5*(value/max(value, na.rm=TRUE)))) +
##     geom_line(size=0.4, alpha=0.8, color='#5A3E37', aes(group=lat), na.rm=TRUE) +
##     ggthemes::theme_map() +
##     coord_equal(0.9)
## ggsave('../images/moreplots_europe.png', width=10, height=10)

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.height=5.5, fig.width=10----
library(plotly)
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(aes(text = paste("Clarity:", clarity))) +
  geom_smooth(aes(colour = cut, fill = cut)) + facet_wrap(~ cut)

ggplotly(p)

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.height=5.5, fig.width=10----
g <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon") + 
  xlim(1, 6) + ylim(40, 100)
ggplotly(g)

## ----estate_table, echo=FALSE, results='as.is'---------------------------
estatedf <- read.table("../data/moreplots_2017-05-03-estate-location.tsv", header = TRUE, sep = "\t")
knitr::kable(estatedf[1:5, !colnames(estatedf)%in%c("photo", "description", "link")])

## ----estate_str, echo=FALSE----------------------------------------------
str(estatedf)

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.height=5.5, fig.width=10----
library(ggiraph)

# create an 'onclick' column
estatedf$onclick <- sprintf("window.open(\"%s\")", estatedf$link)
estatedf$tooltip <- sprintf("<img src=\"%s\"/>", estatedf$photo)

gg_base <-
  ggplot(estatedf[estatedf$price < 2000,], aes( x = price, y = size, color = factor(location)) ) +
  ## scale_colour_hue(h = c(0, 90)) +
  theme_minimal()

gg_interactive <-
  gg_base +
  geom_point_interactive(aes(tooltip = tooltip, onclick = onclick), size = 2)

ggiraph(code = print(gg_interactive), width = 0.8, width_svg = 9) # , zoom_max = 2)

## ----pirate_movie, eval=TRUE, echo=TRUE, message=FALSE, warning=FALSE, fig.height=5.5, fig.width=10----
library(yarrr)
png(filename = "../images/moreplots_pirateplot_movie.png", width = 800, height = 450)
pirateplot(formula = time ~ genre + sequel,
           data = subset(movies, 
                         genre %in% c("Action", "Adventure", "Comedy") &
                         time > 0),
           main = "Movie running times",
           theme = 2,
           gl.col = gray(.7),
           inf.f.col = piratepal("basel")[1:3],
           bean.f.o = .1,
           point.o = .05,
           avg.line.o = 0
           )
dev.off()

