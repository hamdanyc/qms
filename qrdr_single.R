# qrdr_single.R

load("qms.RData") # from qinit.R
rmarkdown::render(
  paste0("~/qms/ver/", doc_files$file_title[1]),
  output_dir = "~/qms/pdf",
  output_format = "pdf_document",
  params = list(doc_id = doc_files$doc_id[1],
                doc_title = doc_files$doc_title[1],
                doc_date = "2 Mei 2022")
)
