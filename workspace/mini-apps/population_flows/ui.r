
xap.require(
  "shiny",
  "ggvis",
  "dplyr"
)

ui <- fluidPage(
  titlePanel("The Global Flow of People"),
  sidebarLayout(
    sidebarPanel(width = 3,
      tags$p("Explore new estimates of migration flows between and within regions for five-year periods,
             1990 to 2010."),
      selectInput("year", label = "Select Year:", choices = c(1990, 1995, 2000, 2005), selected = 1990),
      tags$p("Hover over elements in the plot for quantitative information."),
      tags$p("Hover over on a region to focus on flows from and to that region."),
      HTML(
        '<p>
          This visualisation uses the R package ggvis.
          It is a recreation of the interactive visualisation found 
          <a href="http://www.global-migration.info/" target="_blank">here</a>
        </p>
        
        The original uses the d3 javascript library and currently has more interactivity.
        This extra interactivity will be implemented in this version over time.
        '
      )
    ),
    mainPanel(width = 9,
      ggvisOutput("population_flows")
    )
  )
)


