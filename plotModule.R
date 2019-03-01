plotModuleUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      plotOutput(ns("plot"))
    )
  )
}

plotModule <- function(input, output, session, x, y) {

  values <- reactiveValues()

  observe({
    values$x <- select(mtcars, x())
    values$y <- select(mtcars, y())
  })

  output$plot <- renderPlot({
    dat <- bind_cols(values$x, values$y)

    if (ncol(dat) == 2) {
      x1 <- names(dat)[1]
      y1 <- names(dat)[2]
      ggplot(dat, aes_string(x = x1, y = y1)) +
        geom_point() +
        xlab(names(values$x)[1]) +
        ylab(names(values$y)[1]) +
        ggtitle(sprintf("Scatter Plot of %s vs %s",
                        names(values$x)[1],
                        names(values$y)[1]))
      }
  })
}



