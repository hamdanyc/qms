# ss_proc.R

# init ----
library(dplyr)
ss <- read.csv("ss.csv")

# select random ----
ss %>% sample_n(25) %>% View()
