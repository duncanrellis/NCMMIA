xModuleUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      uiOutput(ns("x"))
    )
  )
}

xModule <- function(input, output, session) {
  values <- reactiveValues()

  output$x <- renderUI({
    choiceV <- names(mtcars)
    selectInput(session$ns("x"), "Choose X-Axis", choices = choiceV)
  })

  observeEvent(input$x,{
    values$x <- input$x
  })

  return (reactive(values$x))
}



