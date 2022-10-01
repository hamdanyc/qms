# qrdr_bat.R
# change ~/R/qms/ver/preamb.tex to match doc date

load("qms.RData") # from qinit.R
for (i in 1:nrow(doc_files)) {
  rmarkdown::render(paste0("~/qms/ver/",doc_files$file_title[i]),
                    output_dir = "~/qms/pdf",
                    output_format = "pdf_document",
                    params = list(
                      doc_id = doc_files$doc_id[i],
                      doc_title = doc_files$doc_title[i],
                      doc_date = "2 Mei 2022"
                    ))
}
