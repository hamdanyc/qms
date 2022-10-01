# iso_process.R

# Init ----
# sql_connect.R

library(RMariaDB)
library(dplyr)

con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), username="rs", password="80907299",
                          dbname="qms")
# con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), groups = "my-db",
#                            dbname="qms")
on.exit(RMariaDB::dbDisconnect(con))

# Run query to get results as dataframe
# RMariaDB::dbGetQuery(con, "SHOW TABLES")
df_item <- RMariaDB::dbGetQuery(con, "SELECT * FROM item")
df_kos <- RMariaDB::dbGetQuery(con, "SELECT * FROM kos_unit")
df_kos$jumlah[1] <- 1300
names(df_kos)[3] <- "Kos_unit"
df_item <- readr::read_csv("item.csv")

RMariaDB::dbExecute(con, "UPDATE kos_unit SET jumlah=1300 WHERE id='1'")
RMariaDB::dbExecute(con, "UPDATE item SET doc='app-01' WHERE id='24'")
RMariaDB::dbExecute(con, "UPDATE item SET doc='app-02' WHERE id='25'")
RMariaDB::dbExecute(con, "UPDATE item SET doc='app-03' WHERE id='26'")

df_item %>% 
  # inner_join(df_kos, by="jenis") %>% 
  group_by(jenis) %>% 
  tally()

by_item <- df_kos %>% 
  inner_join(df_item,by="jenis") %>% 
  group_by(jenis) %>% 
  summarise("Kti"=n(),"Jumlah"=sum(jumlah))

tb_item <- inner_join(df_kos,by_item)
sum(tb_item$Jumlah)
