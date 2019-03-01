## NCMMIA = Needlessly complex multi module interfaced application

library(shiny)
library(dplyr)
library(ggplot2)

source("xModule.R")
source("yModule.R")
source("plotModule.R")

ui = shinyUI(
  fluidPage(
    fluidRow(
      h3("The Needlessly Complex Multi Module Interfaced Application (NCMMIA)")
    ),
    fluidRow(
      column(6,
             xModuleUI("xMod")
             ),
      column(6,
             yModuleUI("yMod")
             )
    ),
    fluidRow(
      plotModuleUI("plotMod")
    )
))

server = function(input, output, session) {

  ## ################################################################################
  ##                      Reactive Values
  ################################################################################
  values <- reactiveValues(
    x = NULL,
    y = NULL)

  ################################################################################
  ## Module Calls
  ################################################################################
  x <- callModule(xModule, "xMod")
  y <- callModule(yModule, "yMod")
  callModule(plotModule, "plotMod",
             x = reactive(values$x),
             y = reactive(values$y))

  observe({
    # Track reactives back from modules and store in values
    values$x <- x()
    values$y <- y()
  })
}

shinyApp(ui = ui, server = server)
