# app.R

# Init ----
library(shiny)
library(knitr)
library(dplyr)
library(flexdashboard)
library(shinydashboard)
digits = 3

# Source Files ----

# ui ----
ui <- dashboardPage(
  dashboardHeader(title = "Dashboard Pengurusan Kualiti", titleWidth = 300),
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Muat Naik", tabName = "muatnaik", icon = icon("folder-open", lib = "glyphicon")),
      menuItem("Matriks", tabName = "matriks", icon = icon("th-list", lib = "glyphicon")),
      menuItem("Prestasi", tabName = "dashboard", icon = icon("signal", lib = "glyphicon"))
    )
  ),
  
  body <- dashboardBody(
    
    tabItems(
      tabItem(tabName = "muatnaik",
              # Input: Select a file
              h2("Muat Naik Data"),
              fileInput("file", "Get File")
      ),
      
      tabItem(tabName = "matriks",
              h2("Tabdir Urus Objektif Kualiti"),
              # Output: Tabset w/plot, summary, and table
              tabsetPanel(type = "tabs",
                          tabPanel("Kad Skor", tableOutput("cs")),
                          tabPanel("KPI", tableOutput("ds")),
                          tabPanel("Kriteria", tableOutput("cr"))
              )
      ),
      
      tabItem(tabName = "dashboard",
              h2("Tabdir Urus Objektif Kualiti"),
              box("Inovasi/Kreativiti",gaugeOutput("ino")),
              box("Proses",gaugeOutput("proc")),
              box("Projek",gaugeOutput("proj")),
              box("Pelanggan",gaugeOutput("cust")),
              box("Keseluruhan",gaugeOutput("all"))
      )
    )
  )
)

# server ----
server <- function(input, output, clientData, session) {
  
  # read file ----
  output$cr <- renderTable({
    read.csv("skor_min_maks.csv", sep = ",")
  })
  
  df_skor_min_maks <- reactive({
    read.csv("skor_min_maks.csv", sep = ",")
  })
  
  data <- reactive({
    file <- input$file
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload csv file"))
    
    read.csv(file$datapath, sep = "|")
  })
  
  # calc summary ----
  skor <- reactive({
    skor_min_maks <- df_skor_min_maks()
    data() %>%
      inner_join(skor_min_maks) %>% 
      select(Objektif,Item,Ukuran,Unit,Skor,Maks,Min) %>% 
      mutate(Jlh = Unit*Skor, `Jlh(Maks)` = Unit*Maks, `Jlh(Min)` = Unit*Min)
  })
  
  # kad skor ----
  output$cs <- renderTable(digits = 0,{
    skor()
  })

  # kpi ----
  output$ds <- renderTable(digits = 1,{
  # calc summary ----
  score()
  })
  
  score <- reactive({
    # calc summary ----
    skor() %>% 
      group_by(Objektif) %>% 
      summarise(Val = sum(Jlh),Maks = sum(`Jlh(Maks)`), Min = sum(`Jlh(Min)`),`Val-Min` = Val-Min,`Maks-Min` = Maks-Min,
                `(Val-Min)/(Maks-Min)` = `Val-Min`/`Maks-Min`, `KPI(%)` = 100*(Val-Min)/(Maks-Min))
  })
  
  # dashboard ----
  output$ino = renderGauge({
    df <- score()
    gauge(round(df$`KPI(%)`[1],1), 
          min = 0, 
          max = 100, 
          sectors = gaugeSectors(success = c(70, 100), 
                                 warning = c(30, 69),
                                 danger = c(0, 29)))
  })
 
  output$proc = renderGauge({
    df <- score()
    gauge(round(df$`KPI(%)`[2],1), 
          min = 0, 
          max = 100, 
          sectors = gaugeSectors(success = c(70, 100), 
                                 warning = c(30, 69),
                                 danger = c(0, 29)))
  })
  
  output$cust = renderGauge({
    df <- score()
    gauge(round(df$`KPI(%)`[3],1), 
          min = 0, 
          max = 100, 
          sectors = gaugeSectors(success = c(70, 100), 
                                 warning = c(30, 69),
                                 danger = c(0, 29)))
  })
  
  output$proj = renderGauge({
    df <- score()
    gauge(round(df$`KPI(%)`[4],1), 
          min = 0, 
          max = 100, 
          sectors = gaugeSectors(success = c(70, 100), 
                                 warning = c(30, 69),
                                 danger = c(0, 29)))
  })
  
  output$all = renderGauge({
    df <- score()
    rs <- 0.1*df$`KPI(%)`[1] + 0.3*df$`KPI(%)`[2] + 0.3*df$`KPI(%)`[3] + 0.3*df$`KPI(%)`[4]
    gauge(round(rs,1), 
          min = 0, 
          max = 100, 
          sectors = gaugeSectors(success = c(70, 100), 
                                 warning = c(30, 69),
                                 danger = c(0, 29)))
  })
  
  # Download Handler -----
    output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    file = "report.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      src <- normalizePath('eb_mark.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src,'report.Rmd' , overwrite = TRUE)
      # file.copy("eb_form.R", tempReport, overwrite = TRUE)

      # Set grade from re-grade module
      grade <- df_gd()

      # Set up parameters to pass to Rmd document
      # params <- list(marks = grade)

      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      out <- rmarkdown::render('report.Rmd', params = list(marks = grade))
      file.rename(out,file)
    }
  )

}

# Create Shiny app ----
shinyApp(ui, server)