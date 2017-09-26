library(readr)
library(dplyr)
library(ggplot2)

## download data from http://stats.oecd.org/Index.aspx?DataSetCode=TEC7_REV4
## as CSV and copy to ../data directory

TEC7_REV4_22092017155021034 <- 
  read_csv("data/TEC7_REV4_26092017092200473.csv")


temp_data <- 
  TEC7_REV4_22092017155021034 %>% 
  filter(REPORTER%in%c("FRA","ITA","DEU","USA","CAN","JPN") & 
           TOWNERSHIP=="F" &
         SECTOR %in% c("TOTAL") & 
           PARTNER=="TOTAL" &
           Year==2011) %>%
    select(REPORTER, Indicator, FLOW, TOWNERSHIP, SECTOR, Year, Value)

import_label <- data.frame(FLOW = c(1,2),
                           flow_label = c("import3", "export3"))
temp_data2 <- 
temp_data %>%
  left_join(import_label)


ggplot(data = temp_data2, 
       aes(x = REPORTER, y = Value, fill = factor(flow_label))) +
  geom_bar(stat="identity", position="dodge") +
  facet_grid(Indicator ~ ., scales = "free_y") +
  scale_fill_discrete(#labels = c("import2", "export2"),
                        guide = guide_legend(
                          direction = "horizontal",
                          title.position = "top",
                          label.position = "bottom",
                          label.hjust = 0.5,
                          label.vjust = 1
                          #,
                          #label.theme = element_text(angle = 90)
                        ))
