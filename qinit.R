# qinit.R

# init ----

# set variables ----
a_list <- readr::read_csv("a_list.csv")
doc_files <- readr::read_csv("doc_files.csv")
oa_risk <- readr::read_csv("oa_risk.csv")
oa_risk_mit <- readr::read_csv("oa_risk_cons.csv")
man_std_topics <- readr::read_csv("diff.csv")
save.image("qms.RData")
