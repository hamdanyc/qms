# qrdr_single.R

doc_files <- read.csv("doc_files.csv") # from qinit.R
for (i in 1:nrow(doc_files)) {
  rmarkdown::render(
    paste0("~/qms/ver/", "oa_front.Rmd"),
    output_file = paste0("~/qms/pdf/front/",doc_files$pdf_title[i]),
    output_dir = "~/qms/pdf/front",
    output_format = "pdf_document",
    params = list(doc_id = doc_files$doc_id[i],
                  doc_title = doc_files$doc_title[i],
                  doc_date = "2 Mei 2022")
  )}
