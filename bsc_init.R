# bsc_init.R

# init ----
library(dplyr)

load("bsc/bsc.RData")

Item  <-  c("71% ke 100%","41% ke 70%","Bawah 40%","7 hari atau kurang","8 ke 14 hari","lebih 14 hari",
         "30 hari atau kurang","31 ke 39 hari","lebih 39 hari","awal","tepat","lewat","ada","tiada")
Skor <- c(5,3,1,5,3,1,5,3,1,5,3,1,1,0)
Maks <- c(replicate(12,5),1,1)
Min <- c(replicate(12,1),0,0)
skor_min_maks <- tibble(Item,Skor,Maks,Min)

# read score card
library(readr)
bsc_skor <- read_delim("bsc_skor.csv", delim = "|", 
                       escape_double = FALSE, col_types = cols(Skor = col_skip(), 
                                                               Jlh = col_skip(), Maks = col_skip(), 
                                                               Min = col_skip()), trim_ws = TRUE)

# mutate ----
# skor = obs["Objektif",Skor"] , jlh = Maks*Unit, maks = sko_maksr*jlh, min = skor_min*jlh
bsc_skor %>% 
  inner_join(skor_min_maks, by = c("Item"="item"))
  grouped_df("Objektif") %>% 
  select(Skor) %>% 
  distinct()

  bsc_skor %>%
    inner_join(skor_min_maks) %>% 
    select(Objektif,Item,Unit,Skor,Maks,Min) %>% 
    mutate(Jlh = Unit*Skor, `Jlh(Maks)` = Unit*Maks, `Jlh(Min)` = Unit*Min) %>% 
    group_by(Objektif) %>% 
    summarise(Val = sum(Jlh),Maks = sum(`Jlh(Maks)`), Min = sum(`Jlh(Min)`),`Val-Min` = Val-Min,`Maks-Min` = Maks-Min,
              `(Val-Min)/(Maks-Min)` = `Val-Min`/`Maks-Min`, `KPI(%)` = 100*(Val-Min)/(Maks-Min)) 

write.csv(skor_min_maks,"bsc/skor_min_maks.csv")

# save data ----
save.image("bsc/bsc.RData")
