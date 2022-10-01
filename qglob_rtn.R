# qglob_rtn.R

# Init ----
library(stringr)
library(dplyr)
library(readr)
library(rmarkdown)

# Read file list ----
# filenames <- list.files(path = "rmd", pattern="*.Rmd", full.names=FALSE)
# file_ver <- list.files(path = "ver", pattern="*.Rmd", full.names=FALSE)
# doc_ver <- paste0(substr(filenames,1,nchar(filenames)-4),"_v1.Rmd")

rep_var <- readr::read_csv("rep_data.csv")
doc_files <- readr::read_csv("doc_file.csv")

# doc_lst <- read_delim("doc_list.csv", delim = "|")
# files_lst <- read_csv("files.csv")
# 
# doc_files <- doc_lst %>% 
#   inner_join(files_lst) %>% 
#   write_csv("doc_file.csv")
  
# a_list <- read_csv("a_list.csv")

# Replace rtn ----
# cli: for file in *.md ; do mv $file ${file//.docx.md/Rmd} ; done
# read var to replace

glob_chg <- function(file_in){
  tmp <- readr::read_lines(paste0("rmd/",file_in))
  # copy source to a new version
  # doc_ver <- paste0(substr(file_in,1,nchar(file_in)-4),"_v1.Rmd")
  
  # grep common phrase
  for (i in 1:nrow(rep_var)){
    tmp <- stringr::str_replace_all(tmp,rep_var$var_from[i],rep_var$var_with[i])
  }
  readr::write_lines(tmp,paste0("ver/",file_in))    
}

ver_chg <- function(file_in){
  tmp <- readr::read_lines(paste0("ver/",file_in))
  # copy source to a new version
  # doc_ver <- paste0(substr(file_in,1,nchar(file_in)-4),"_v1.Rmd")
  
  # grep common phrase
  for (i in 1:nrow(rep_var)){
    tmp <- stringr::str_replace_all(tmp,rep_var$var_from[i],rep_var$var_with[i])
  }
  readr::write_lines(tmp,paste0("ver/",file_in))    
}

# Apply to all ----
# lapply(filenames, glob_chg)

# glob_chg(doc_files$file_title[15])
# lapply(doc_files$file_title, ver_chg)
# ver_chg(doc_files$file_title[15])

# for (i in 1:3) {
#   rmarkdown::render(paste0("~/R/qms/ver/",doc_files$file_title[i]),
#                     output_dir = "~/R/qms/ver/pdf",
#                     output_format = "pdf_document",
#                     params = list(
#                       doc_id = doc_files$doc_id[i],
#                       doc_title = doc_files$doc_title[i]
#                     ))
# }

rmarkdown::render(paste0("~/R/qms/ver/",doc_files$file_title[1]),
                  output_dir = "~/R/qms/ver/pdf",
                  output_format = "pdf_document",
                  params = list(
                    doc_id = doc_files$doc_id[1],
                    doc_title = doc_files$doc_title[1]
                  ))

# pandoc --pdf-engine=xelatex --toc test.md -V toc-title:"Custom text" -o doc.pdf
