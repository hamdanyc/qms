# qrdr_bat.R

a_list <- readr::read_csv("a_list.csv")
doc_files <- readr::read_csv("doc_file.csv")
for (i in 1:nrow(doc_files)) {
  rmarkdown::render(paste0("~/qms/ver/",doc_files$file_title[i]),
                    output_dir = "~/qms/pdf",
                    output_format = "pdf_document",
                    params = list(
                      doc_id = doc_files$doc_id[i],
                      doc_title = doc_files$doc_title[i]
                    ))
}