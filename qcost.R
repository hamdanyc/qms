# qcost.R

# Init ----
# sql_connect.R

# library(RMariaDB)
library(dplyr)
library(janitor)

# con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), username="abi", password="80907299",
#                            dbname="qms", host="abi-linode.name.my", port="3306")
# con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), groups = "my-db",
#                            dbname="qms")
# on.exit(RMariaDB::dbDisconnect(con))

# Run query to get results as dataframe
# RMariaDB::dbGetQuery(con, "SHOW TABLES")
# df_item <- RMariaDB::dbGetQuery(con, "SELECT * FROM item")
# df_kos <- RMariaDB::dbGetQuery(con, "SELECT * FROM kos_unit")
# RMariaDB::dbExecute(con, "UPDATE kos_unit SET jumlah=1300 WHERE id='1'")

# df_kos$jumlah[1] <- 1300
# names(df_kos)[3] <- "kos_unit"

df_kos <- readr::read_csv("kos_unit.csv")
df_item <- readr::read_csv("item.csv")
doc_files <- readr::read_csv("doc_files.csv")

df_item %>% 
  inner_join(df_kos, by="jenis") %>% 
  group_by(jenis) %>% 
  tally()

by_item <- df_kos %>% 
  inner_join(df_item,by="jenis") %>%
  group_by(jenis) %>% 
  summarise(nama,"kti"=unit,kos_unit,"jumlah"=kos_unit*unit)

tb_item <- inner_join(df_kos,by_item)
sum(tb_item$jumlah)

tb <- df_item %>% 
  inner_join(df_kos, by="jenis") %>%
  select(jenis,nama,unit,kos_unit) %>%
  # arrange(jenis) %>% 
  group_by(jenis) %>%
  mutate(jlh = unit*kos_unit) %>% 
  # group_map(.keep = TRUE,
  #           ~ add_row(.x,
  #                     summarise(.x,
  #                               jenis = paste0("Jumlah (",unlist(.y),")")
  #                               across(where(is.numeric), sum),
  #                     )
  #           )) %>%
  bind_rows()

write.csv(tb,"tb.csv")

df <- read.csv("tb.csv",stringsAsFactors = FALSE)

# df_item %>% 
#   inner_join(doc_file) %>%
#   select(doc_id,doc_title,jenis)

save.image("cost.RData")

# sub == latihan
# library(janitor)
# mtcars %>%
#   tabyl(cyl, gear) %>%
#   adorn_Jumlahs("row") 
# 
# cyl  3  4 5
# 4  1  8 2
# 6  2  4 1
# 8 12  0 2
# Jumlah 15 12 5

by_item %>% 
  filter(jenis == "latihan") %>% 
  group_by(jenis) %>% 
  group_modify(~ bind_rows(., summarize(., across(where(is.numeric), sum)))) %>%
  ungroup %>%
  mutate(nama = coalesce(nama, paste("Jumlah (", jenis,")")),
         jenis = if_else(startsWith(nama, "Jumlah"), "", jenis),
         kos_unit = if_else(jenis == "","",as.character(kos_unit))) %>%
  select(nama,jenis,kti,kos_unit,jumlah) %>% 
  data.frame
 
  
  
