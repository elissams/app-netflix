
## app ui

library(shiny)
library(shinydashboard)
library(DT)


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
            menuItem("Reitingud", tabName = "Reitingud", icon = icon("chart-line")),
            menuItem("New on Netflix", tabName = "New", icon = icon("exclamation")),
            menuItem("Netflix originals", tabName = "Originaalid", icon = icon("video")),
            menuItem("TV Shows", tabName = "TV", icon = icon("tv"))
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(
                "New",
                box(width = 12,
                    solidHeader = T,
                    color = "maroon",
                    title = "New on Netflix in Estonia",
                    dataTableOutput("NewonNetflix_table")),
                ),
            tabItem(
                "TV",
                box(width = 12,
                    solidHeader = T,
                    color = "maroon",
                    title = "100 Best TV Shows in Estonia",
                    dataTableOutput("TV_table")),
                ),
            tabItem(
                "Originaalid",
                box(width = 12,
                    solidHeader = T,
                    color = "maroon",
                    title = "100 Best Netflix Originals in Estonia",
                    dataTableOutput("original_table")),
                )
                
            )
        )
    )
)

