## cou <- "DEU"
## unique(data_plot$var)
data_plot <-
    data_shares %>%
        filter(cou3 == cou)

ge_share <- round(100 * data_plot$value[data_plot$var=="gross.exports"])
va_share <- round(100 * data_plot$value[data_plot$var=="value.added.exports"])
emp_share <- round(100* data_plot$value[data_plot$var=="employment"])

## data_plot_bar <-
##     data_plot %>%
##         filter(var %in% c("restriction_on_foreign_entry", "restrictions_movement_people", "other_discriminatory_measures", "barriers_to_competition", "regulatory_transparency"))

p <-ggplot(data = data_plot) +
    geom_bar(aes(x = var, y = value, fill = factor(1)), color = "black",
             stat = "identity", width = .7) +
                 coord_flip() +
                     ## http://docs.ggplot2.org/0.9.3.1/scale_manual.html
                     scale_fill_manual(values = rgb(red = 79, green = 129, blue = 189, alpha = 255, maxColorValue = 255)) +
                         scale_y_continuous(labels = percent, limits = c(0, 1)) +
                         ## http://docs.ggplot2.org/current/theme.html
                         theme(
                             axis.title.x = element_blank(),
                             axis.title.y = element_blank(),
                             ## legend.title = element_blank(),
                             legend.position="none"
                         )

print(p)

## replace y-axis labels
