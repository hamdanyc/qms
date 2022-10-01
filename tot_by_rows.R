library(dplyr)

# Add Total Mean for numeric variables
iris %>%
  add_row(
    summarise(.,
              Species = "Total mean",
              across(where(is.numeric), mean))
  ) %>%
  tail() # for printing

df_item %>% 
  inner_join(df_kos, by="jenis") %>% 
  add_row(
    summarise(.,
              jenis = "Total sum",
              across(where(is.numeric), sum))
  )

tb <- df_item %>% 
  inner_join(df_kos, by="jenis") %>%
  select(jenis,nama,unit,kos_unit) %>%
  # arrange(jenis) %>% 
  group_by(jenis) %>%
  mutate(jlh = unit*kos_unit) %>% 
  group_map(.keep = TRUE,
            ~ add_row(.x,
                      summarise(.x,
                                jenis = paste0("Jumlah (",unlist(.y),")"),
                                across(where(is.numeric), sum),
                      )
            )) %>%
  bind_rows()

write.table(tb,"tb.csv",sep = ",")

df <- read.csv("tb.csv",col.names = c("Jenis","Nama","Kti","Kos per kti","Jlh"))
