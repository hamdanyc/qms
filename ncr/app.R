# app.R

library(shiny)
library(shinyFiles)
library(jsonlite)
library(dplyr)
library(mongolite)

# Connect to the database
# mongodb://[username:password@]host1[:port1]/?authSource=user-data
connection_string = 'mongodb://abi:80907299@139.162.17.142:27017/?authSource=user-data'
db <- mongolite::mongo(collection="ncr", db="oa", url=connection_string)

saveData <- function(data) {
  # Insert the data into the mongo collection as a data.frame
  db$insert(data)
}

loadData <- function() {
  # Read all the entries
  data <- db$find()
  data
}

ui <- fluidPage(
    titlePanel("Dashboard Audit Dalaman"),
    sidebarLayout(
        sidebarPanel(titlePanel("Penyediaan Borang NCR"),
                     fileInput("file1", "Data NCR", accept = ".json"),
                     titlePanel("Simpan/Muat-naik Data"),
                     actionButton('save', 'Simpan'),
                     actionButton('load', 'Muat-naik data'),
                     titlePanel("Penyediaan Laporan NCR"),
                     actionButton("button", "Sedia Laporan!", class = "btn-success"),
                     br(),
                     shinyFilesButton('files', label='Pilih Laporan', title='Sila pilih fail', multiple=F),
                     br(),
                     downloadButton("downloadFiles", "Muat Turun NCR"),
                     titlePanel("Senarai Semak"),
                     br(),
                     sliderInput("n", "Bil: Senarai",
                                 min = 3, max = 30,
                                 value = 5),
                     br(),
                     actionButton("btssr","Papar Senarai"),
                     br(),
                     downloadButton("report", "Muat Turun Senarai")),
        
        mainPanel(
            tableOutput("contents"),
            tableOutput("ssr"),
            textOutput("msg")
        )
    )
)

server <- function(input, output) {
  
  output$contents <- renderTable({
      file <- input$file1
      ext <- tools::file_ext(file$datapath)

      req(file)
      #shiny::validate(need(ext == ".json", "Muat naik data"))
      #validate(file$datapath)

      # as.data.frame(read_json(file$datapath))
      fromJSON(file$datapath)[1:7]
  })
  
  # shinyFileSave(input$file1, 'save', roots=c(wd='.'))
  
  ssr_out <- eventReactive(input$btssr,{
    ss <- read.csv("ss.csv")
    ss %>%
      rename(`Perkara-perkara untuk diperiksa dan klausa berkaitan`=Keterangan) %>% 
      sample_n(input$n)
  })
  
  output$ssr <- renderTable({
    ssr_out()
  })
  
  df <- eventReactive(input$button, {
    file <- input$file1
    fromJSON(file$datapath)
  })
  
  # save ncr df
  observeEvent(input$save, {
  saveData(df())
  })
  
  # load ncr df & display
  observeEvent(input$load, {
    output$contents <- renderTable({
      loadData()
    })
    
  })
  
  output$msg <- eventReactive(input$button, {
    
    if(!is.null(input$file1)) ncr <- tibble(df())
    else if(!is.null(input$load))  ncr <- loadData()
    n <- nrow(ncr)
    
    withProgress(message = 'Laporan sedang disediakan', value = 0, {
      for (i in 1:n) {
        rmarkdown::render(
          'ncr_form.Rmd', output_file = paste0('pdf/','B03-',i, '.pdf')
        )
        
        incProgress(1/n, detail = paste("bil", i))
        
        # Pause for 0.1 seconds to simulate a long computation.
        Sys.sleep(0.1)
      }
    })
    "Selesai"
  })
  
  roots =  c(wd = 'pdf/')
  
  shinyFileChoose(input, 'files',
                  roots =  roots,
                  filetypes='pdf')
  
  output$filepaths <- renderPrint({parseFilePaths(roots, input$files)})
  
  output$downloadFiles <- downloadHandler(
    filename = function() {
      as.character(parseFilePaths(roots, input$files)$name)
    },
    content = function(file) {
      fullName <- as.character(parseFilePaths(roots, input$files)$datapath)
      file.copy(fullName, file)
    }
  )
  
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "report.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(df = ssr_out())
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
}

shinyApp(ui, server)