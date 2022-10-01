# ncr

# init ----
load("ncr.RData")

for (i in 1:nrow(ncr)) {
  rmarkdown::render(
    'ncr_form.Rmd', output_file = paste0('audit/','B03-',i, '.pdf')
  )
}
