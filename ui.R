
## app ui

library(shiny)
library(shinydashboard)


#title logo

logo <- tags$img(src = "logo.png", height = '80', width = '80')

# Define UI for application
shinyUI(
    dashboardPage(skin = "red",
    dashboardHeader(
        title = logo
    ),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
            menuItem("Reitingud", tabName = "Reitingud", icon = icon("chart-line"))
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        )
    )
))

