# qinit.R

# init ----
library(dplyr)

# set variables ----
doc <- read.csv("var_doc.csv",stringsAsFactors = FALSE)
prep <- data.frame(c("Ahmad","Pengurus"),c("Azlan","VP Operasi"),stringsAsFactors = FALSE)
names(prep) <- c("Disediakan","Diluluskan")
pinda <- list(c("01/01/2021"),c("ms 1","ms 3"),c("ms 5","ms 13","ms 15"))
edaran <- data.frame(1:3,c("Jawatan 1","jawatan 2","jawatan 3"),stringsAsFactors = FALSE)
names(edaran) <- c("siri","jawatan")
kembaran <- list(c("kembaran A","kembaran B"),c("kembaran a","kembaran B","kembaran D"))

qms_var <- list(doc,prep,pinda,edaran,kembaran)
names(qms_var) <- c("doc","sedia","pinda","edaran","kembaran")
