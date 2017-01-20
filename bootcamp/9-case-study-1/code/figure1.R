## cou <- "AUT"
## unique(data_plot$var)
## moved to figure0.R
## data_cou <-
##     data_figures %>%
##         filter(cou3 == cou)

## n_total <- length(unique(data_cou$sector_id))

data_cou_spread <-
    data_cou %>%
        spread(key = var, value = value) %>%
            select(sector_name, stri_score, all_average)
n_sector <-
    data_cou_spread %>%
        filter(stri_score > all_average) %>%
            nrow()
min_sector <- as.character(data_cou_spread$sector_name[order(data_cou_spread$stri_score)][1:3])
max_sector <- as.character(data_cou_spread$sector_name[order(-data_cou_spread$stri_score)][1:3])

data_plot <-
    data_cou %>%
        filter(sector_id < 20)

data_plot_bar <-
    data_plot %>%
        filter(var %in% c("restriction_on_foreign_entry", "restrictions_movement_people", "other_discriminatory_measures", "barriers_to_competition", "regulatory_transparency"))

data_plot_point <-
    data_plot %>%
        filter(var %in% c("all_average", "minimum"))

p <- ggplot() +
    geom_bar(data = data_plot_bar,
             aes(x = sector_name, y = value, fill = var), color = "black",
             position = "stack", stat = "identity", width = .7) +
                 ## http://docs.ggplot2.org/0.9.3.1/scale_manual.html
                 scale_fill_manual(values = plot_fill) +
                     geom_point(data = data_plot_point,
                                aes(x = sector_name, y = value, color = var)) +
                                    scale_colour_manual(values = plot_colour) +
                                        scale_y_continuous(limits = c(0, 1)) +
                                        ## http://docs.ggplot2.org/current/theme.html
                                        theme(axis.text.x = element_text(angle = 45, hjust = 1),
                                              axis.title.x = element_blank(),
                                              axis.title.y = element_blank(),
                                              legend.title = element_blank(),
                                              legend.position="top"
                                              )

print(p)
# rotate x-axis labels
# create color vector
# add point series
# order x-axis factors (sector_name)
# order stack series factors (var)
# add legend labels
# set y-axis max = 1
