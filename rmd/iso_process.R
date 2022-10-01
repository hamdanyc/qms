# iso_process.R

# Init ----
# sql_connect.R

library(RMariaDB)
library(dplyr)

con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), username="rs", password="080460",
                          dbname="qms")
# con <- RMariaDB::dbConnect(RMariaDB::MariaDB(), groups = "my-db",
#                            dbname="qms")
on.exit(RMariaDB::dbDisconnect(con))

# Run query to get results as dataframe
# RMariaDB::dbGetQuery(con, "SHOW TABLES")
df_item <- RMariaDB::dbGetQuery(con, "SELECT * FROM item")
df_kos <- RMariaDB::dbGetQuery(con, "SELECT * FROM kos_unit")

df_item %>% 
  # inner_join(df_kos, by="jenis") %>% 
  group_by(jenis) %>% 
  tally()

df_kos 
