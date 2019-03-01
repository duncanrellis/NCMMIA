yModuleUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      uiOutput(ns("y"))
    )
  )
}

yModule <- function(input, output, session) {

  values <- reactiveValues()

  output$y <- renderUI({
    choices <- names(mtcars)
    selectInput(session$ns("y"), "Choose Y-Axis", choices = choices)
  })

  observeEvent(input$y, {
    values$y <- input$y
  })

  return (reactive(values$y))
}



