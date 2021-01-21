documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Population Flows"), 
                       p("This mini-app shows a circular visualisation of world population movement.
                         You can explore the estimates of migration flows between and within regions for five-year periods, from 1990 to 2010."),
                       p("This visualisation uses the R package ggvis. This app is a recreation of the interactive visualisation found in http://www.global-migration.info/.
                       The original visualisation uses d3 javascript library, thus offering more interactivity."),
                       
                       h3("How use the mini-app"),
                       p("On the right side-bar you can choose the year you want to display in the graph shown in the main panel." ),
                       p("To get quantitivative information about the flows, hover over elements in the plot. If you hover over on a region, 
                         you will get information on flows from and to that specific region.")
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       tags$video(src="survival.mp4", type = "video/mp4", width="100%", height = "350", frameborder = "0", controls = NA),
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                       risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                       comfortable with the calculations made before proceeding. ")
                       
                     ))
                     
                     
                     
                     
           ))
}