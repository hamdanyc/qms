# qrdr_one.R

a_list <- readr::read_csv("a_list.csv")
doc_files <- readr::read_csv("doc_file.csv")
rmarkdown::render(
  paste0("~/R/qms/ver/", doc_files$file_title[1]),
  output_dir = "~/R/qms/pdf",
  output_format = "pdf_document",
  params = list(doc_id = doc_files$doc_id[1],
                doc_title = doc_files$doc_title[1])
)
