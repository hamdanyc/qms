# bsc_dash.R

# init ----
library(dplyr)
library(ggplot2)

load("bsc.RData")

# calc summary ----
ds <- bsc_skor %>% 
   group_by(Objektif) %>% 
   summarise(jumlah=sum(Jlh), maks=sum(Maks), min=sum(Min), kpi=(jumlah-min)/(maks-min)*100)

item_skor <- bsc_skor %>% 
  group_by(Item) %>% 
  summarise(Skor) %>% 
  distinct()
# mutate skor, jlh, maks & min ----
# skor = item_skor[item_skor$Item=="awal","Skor"]
# jlh = skor * Unit
# maks = skor * max(item_skor[,"Skor"])
# min = skor * min(item_skor[,"Skor"])

bsc_skor %>% 
  max(item_skor["Item","Skor"])

save.image("bsc/bsc.RData")

# gauge ----
library(plotly)

fig <- plot_ly(
  domain = list(x = c(0, 1), y = c(0, 1)),
  value = ds$kpi[4],
  title = list(text = "Speed"),
  type = "indicator",
  mode = "gauge+number") 
fig <- fig %>%
  layout()

fig

# flash ----
library(flexdashboard)

gauge(round(ds$kpi[3]), min = 0, max = 100, symbol = '%', gaugeSectors(
  success = c(80, 100), warning = c(40, 79), danger = c(0, 39)
))

