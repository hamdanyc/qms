library(shiny)
library(DT)

# dept <- c("Admin","Finance","Technical")
# doc_proc <- c("MK.OA.01","MK.OA.01","MK.OA.01")
# auditee <- c("azm","hs","hy")
# auditor <- c("nzr","nzr","nzr")
# ncr <- c("s-4.0","s-5.6","s8.2")
# ncr_obs <- c("ofi","ofi","ofi")
# ncr_src <- c("man","man","trg")
# 
# od <- data.frame(dept,doc_proc,auditor,auditee,ncr,ncr_obs,ncr_src)

load("~/qms/audit/od.RData")
ui <- sidebarLayout(
  sidebarPanel(
    textInput('cap', 'Table Caption'),
    actionButton('save', 'Save')
  ),
  mainPanel(
    DT::dataTableOutput('tb')
  )
)

server <- function(input, output, session) {
  # output$tb <- DT::renderdatatable(od, editable = TRUE)
  output$tb <- DT::renderDataTable(
    od, editable = TRUE,
    caption = 'Using a proxy object to manipulate the table'
  )
  proxy <- dataTableProxy('tb')
  
  observeEvent(input$save,{
    proxy %>% save.image(file = "~/qms/audit/od.RData")
  })
}

shinyApp(ui, server)