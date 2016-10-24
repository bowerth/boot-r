data_cou <-
    data_figures %>%
        filter(cou3 == cou)

n_total <- length(unique(data_cou$sector_id))
