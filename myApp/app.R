# qms/doc
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(titlePanel("Sistem Pengurusan Kualiti (MS ISO 9001:2015)"),
  selectInput("kate", "Dokumen:",width = "60%",
              list(`Operasi` = list("Manual_Kualiti.pdf", "PKO_01_Sebut_harga_tender_kontrak.pdf", 
                                    "PKO_02_Pemantauan_Penyerahan_Perkhidmatan_Integrasi_Sistem.pdf","iso9001.pdf"),
                   `Wajib` = list("PKW_01_Kawalan_Dokumen.pdf", "PKW_02_Rekod_Kualiti.pdf", "PKW_03_Audit_Dalam.pdf",
                                  "PKW_04_Tindakan_Pembetulan.pdf", "PKW_05_Tindakan_Pencegahan.pdf", 
                                  "PKW_06_Kawalan_Output_Tak_Akur.pdf"),
                   `Sokongan` = list("PKS_01_Pengendalian_Aduan_Pelanggan.pdf", "PKS_02_Kajian_Semula_Pengurusan.pdf",
                                     "PKS_03_Perolehan.pdf", "PKS_04_Pengendalian_Latihan.pdf", "PKS_05_Bajet.pdf",
                                     "PKS_06_Teknologi_Maklumat.pdf", "PKS_07_Utiliti.pdf", "PKS_08_Pelaksanaan_Integriti_Akauntabiliti_AntiRasuah.pdf",
                                     "Balanced_Scorecard.pdf", "Pengurusan_Penaksiran_Risiko.pdf", "Piagam_Pelanggan.pdf"))
  ),
  mainPanel(fluidRow(
    htmlOutput("frame")
  ))
)
  
# Define server logic required to display frame
server <- function(input, output,session){
  output$frame <- renderUI({
    tags$iframe(src=input$kate, style="height:900px; width:130%; scrolling=yes")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
