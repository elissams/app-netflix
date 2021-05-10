
## app ui



library(shiny)
library(shinydashboard)

# Define UI for application
shinyUI(dashboardPage(
    dashboardHeader(
        title = img(src = "logo.png")
    ),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
            menuItem("Reitingud", tabName = "Reitingud", icon = icon("chart-line"))
        )
    ),
    dashboardBody()
))

