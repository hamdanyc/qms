# qglob_rtn.R

# Init ----
library(stringr)
library(dplyr)
library(readr)

# Read file list ----
filenames <- list.files(path = "rmd", pattern="*.Rmd", full.names=FALSE)
doc_ver <- paste0(substr(filenames,1,nchar(filenames)-4),"_v1.Rmd")
rep_var <- read_csv("rep_data.csv")

# Replace rtn ----
# cli: for file in *.md ; do mv $file ${file//.docx.md/Rmd} ; done
# read var to replace

glob_chg <- function(file_in){
  tmp <- read_lines(paste0("rmd/",file_in))
  doc_ver <- paste0(substr(file_in,1,nchar(file_in)-4),"_v1.Rmd")

  for (i in 1:nrow(rep_var)){
    tmp <- str_replace_all(tmp,rep_var$var_from[i],rep_var$var_with[i])
  }
  write_lines(tmp,paste0("ver/",doc_ver))    
}

lapply(filenames, glob_chg)

# doc_title <- "PKS_03_Perolehan"
# tmp <- readr::read_lines(paste0("rmd/",doc_title,".Rmd"))
# rep_var <- read_csv("rep_data.csv")
# 
# for (i in 1:nrow(rep_var)){
#   # tmp <- str_replace_all(tmp, rep_var$var_from[i], 
#   #                        rep_var$var_with[i])
#   tmp <- str_replace_all(tmp,rep_var$var_from[i],rep_var$var_with[i])
# 
# }
# 
# write_lines(tmp,paste0("ver/",doc_title,"_v1.Rmd"))

# examples
# tmp <- str_replace_all(tmp,"9001:2008","9001:2015")
# tmp <- str_replace_all(tmp,regex("dan ms iso/iec 27001:2005",ignore_case = TRUE),"")





