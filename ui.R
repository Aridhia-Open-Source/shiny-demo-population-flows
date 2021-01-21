#################
####### UI ######
#################

ui <- fluidPage(
  # Title
  titlePanel("The Global Flow of People"),
  tabsetPanel(
    # App Tab
    tabPanel("App",
             sidebarLayout(
               # Side bar
               sidebarPanel(width = 3,
                            # Slider input to select the year ot graph
                            selectInput("year", label = "Select Year:", choices = c(1990, 1995, 2000, 2005), selected = 1990),
               ),
               # Main panel with the graph
               mainPanel(width = 9,
                         ggvisOutput("population_flows")
               )
             )),
    # Help tab
    tabPanel("Help",
             documentation_tab()
             )
  )

)


