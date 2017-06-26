## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)
## Generation of requested POCs shared at http://dki.rdata.work/visualisation/
## Training session to explain concepts employed in POCs (June 2017)

## ----xaringan_startup,echo=FALSE,message=FALSE,warning=FALSE-------------
library(ggplot2)
library(dplyr)
library(tidyr)

library(grid)
library(gtable)
## install.packages("cowplot")

library(ggradar)
suppressPackageStartupMessages(library(dplyr))
library(scales)

library(ggiraph)
library(ggiraphExtra)

library(knitr)
opts_chunk$set(digits = 3, tidy = FALSE,
               fig.path = '10-ggplot-detailed-features/fig-html/',
               fig.height = 3.5, fig.width = 10, dev = "svg")

## ----legend-width-code, tidy=FALSE, echo=TRUE, eval=FALSE----------------
## gp <- ggplot2::ggplotGrob(p)
## leg <- gtable::gtable_filter(gp, "guide-box")
## panel <- gtable::gtable_filter(gp, "panel")
## leg[[1]][[1]]$widths[[elem]] =
##   panel$grobs[[1]]$children[[1]]$children[[1]]$width -
##   sum(leg[[1]][[1]]$widths) + leg[[1]][[1]]$widths[[elem]]
## gp.new = gtable::gtable_add_grob(gp, leg, t = 4, l = 4)

## ----legend-width-eval, echo=FALSE, message=FALSE, warning=FALSE, cache=TRUE----
source("../R/ggplot_detailed_features_absLegend.R")
source("../R/ggplot_detailed_features_preparePlot.R")
gp1 <- absLegend(p1)
grid.newpage()
grid.draw(gp1)

## ----key-size, tidy=FALSE, echo=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
p1 + guides(fill = guide_legend(keywidth = unit(10, "mm"),
                                keyheight = unit(10, "mm"), title = "",
                                override.aes = list(color = "black")),
            linetype = guide_legend(keywidth = unit(20, "mm"), title = ""))

## ----axis-title-position, tidy=FALSE, echo=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
p1 + scale_y_continuous(name = "This is the y-axis title") +
  theme(axis.title.y = element_text(vjust = 1.08, angle = 0,
                                    margin = margin(r = -75, unit = "pt")))

## ----sec-axis, echo=TRUE, cache=TRUE-------------------------------------
ggplot(mtcars, aes(cyl, mpg)) + geom_point()

## ----mtcars-datatable, eval=require('DT'), echo=FALSE, cache=TRUE--------
DT::datatable(
  head(mtcars, 10),
  fillContainer = FALSE,
  options = list(pageLength = 5)
)

## ----mtcars-summary, echo=TRUE-------------------------------------------
mtcars %>% select(mpg, hp) %>% mutate(hp_scaled = hp / 10) %>% summary()

## ----rescale-mtcars, cache=TRUE------------------------------------------
scalefactor <- 10^1
mtcars %>%
  mutate(hp_scaled = hp / scalefactor) %>%
  select(cyl, mpg, hp_scaled) %>%
  gather(key = variable, value = value, -cyl) %>%
  ggplot(aes(x=cyl, y = value, color = variable)) +
  geom_point() +
  scale_y_continuous(name = "mpg",
                     sec.axis = sec_axis(name="hp", ~.*scalefactor)) +
  scale_color_discrete(labels = c("hp", "mpg"))

## ----pie-table, echo=FALSE, message=FALSE, cache=TRUE--------------------
df <- data.frame(categ = c(1, 2, 3, 4),
                 pct = c(27.82, 28.70, 22.44, 21.04))
df_lab <- df %>% mutate(labelpos = 100 - (cumsum(pct) - pct / 2))

p <- ggplot(df_lab, aes(x = factor(0), y = pct, fill = factor(categ))) +
  geom_bar(width = 1, stat = "identity", color = "black", size = 0.25) +
  theme(legend.position = "none") +
  scale_x_discrete(NULL, expand = c(0, 0)) +
  scale_y_continuous(NULL, expand = c(0, 0)) +
  scale_fill_manual(
    values = c("#929292", # dark grey
               "#a6b8e2", # light blue
               "#cbcbcb", # light grey
               "#4e80bc"  # dark blue
               ))

## ----pie-label, tidy=FALSE, echo=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
## labelpos = 100 - (cumsum(pct) - pct / 2)
p + geom_text(aes(y = labelpos,
                  label = paste0(as.character(pct), "%")),
              family = "serif", size = 6, color = "red") +
  coord_polar(theta = "y")

## ----high-low-data, echo=FALSE, message=FALSE, cache=TRUE----------------
labels_hl <- data.frame(variable = c("h", "m", "l"),
                        label = c("High Price", "Middle Price", "Low Price"),
                        stringsAsFactors = FALSE)
n <- 14
sd <- 0.6
df_hl <-
  data.frame(
    date = as.Date(paste0("2011-01-", as.character(seq(1:n)))),
    m = rnorm(n, mean = 0.8, sd = 0.2)
  ) %>%
  mutate(h = m + abs(rnorm(n, sd = sd)),
         l = m - abs(rnorm(n, sd = sd))) %>%
  gather(key = variable, value = value, -date) %>%
  left_join(labels_hl, by = "variable")
df_hl$label <- factor(df_hl$label, levels = labels_hl$label)

themeHighLow <- function(p, col=c("black", "#4f81bd", "black")) {
  p1 <-
    p +
    scale_color_manual(values = col) +
    scale_fill_manual(values = col) +
    theme(
      legend.position = "top",
      legend.title = element_blank(),
      axis.line.x = element_line(color = 'black')
    ) +
    xlab(NULL) + ylab(NULL)
  return(p1)
}


## ----high-low-plot-base, echo=TRUE, message=FALSE, cache=TRUE------------
p_hl <- ggplot(data = df_hl, aes(x = date, y = value,
                                 color = label, fill = label)) +
  geom_point(aes(shape = label), size = 2) +
  scale_shape_manual(values = c(17, 23, 15))
themeHighLow(p = p_hl, col = c("black", "#4f81bd", "black"))

## ----high-low-plot-line, echo=TRUE, message=FALSE, cache=TRUE------------
df_hl2 <- df_hl %>% group_by(date) %>% mutate(min=min(value), max=(max(value))) %>% ungroup()
p_hl2 <- ggplot(data = df_hl2, aes( x = date, y = value, color = label, fill = label )) +
  geom_point( aes( shape = label ), size = 2) +
  geom_segment( aes( xend = date, y = min, yend = max ), size = 0.05) +
  scale_shape_manual(values = c(17, 23, 15)); themeHighLow(p = p_hl2)

## ----radar-data, message=FALSE, echo=FALSE, cache=TRUE-------------------
bli_radar <-
  "../data/BLI_2016.csv" %>%
  read.csv() %>%
  filter(INEQUALITY == "WMN") %>%
  select(LOCATION, Indicator, Value) %>%
  spread(key = Indicator, value = Value) %>%
  mutate_at(vars(-LOCATION), funs(scales::rescale)) %>%
  filter(LOCATION %in% c("FRA", "ITA")) %>%
  rename(group = LOCATION)


## ----radar-table, echo=FALSE, results='as.is'----------------------------
## names(bli_radar)
## knitr::kable(bli_radar[, c(1,5:6)])
str(bli_radar)

## ----radar-chart, fig.width=9.5, fig.height=4.5, message=FALSE, warning=FALSE, echo=FALSE, cache=TRUE----
p_radar <-
  ggradar(bli_radar,
        font.radar = "sans",
        grid.label.size = 4,
        axis.label.size = 3,
        group.point.size = 1,
        group.line.width = 1,
        plot.extent.x.sf = 1.8) +
  scale_color_manual(values = c("#8cc841", "#da2128")) +
  theme(
    legend.position = c(0.05, 0.95),
    legend.justification = "left",
    legend.direction = "horizontal",
    legend.text = element_text(size = 8),
    legend.background = element_rect(fill = NULL)
  )
p_radar
## plotly::ggplotly(p_radar)


