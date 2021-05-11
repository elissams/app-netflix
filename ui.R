
## app ui

library(shiny)
library(shinydashboard)
library(DT)
<<<<<<< HEAD

=======
>>>>>>> 8e289d6420bfc2d485888f89eb3441461d2219ed


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
            menuItem("NETFLIX", tabName = "netflix", icon = icon("tv")),
            menuItem('Parimad Netflixi originaalid', tabName = "originals", icon = icon("chart-line")),
            menuItem("Parimad TV-seriaalid", tabName = "tv", icon = icon("star"))

        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),

        # tabs
        
        #netflix general
        tabItems(
            tabItem(tabName = 'netflix',
                fluidRow(
                    column( width = 6,
                    box(
                        solidHeader = T, width = 600, background ="black",
                            div(img(src="diivan.jpg", width = 600)),
                        div(class = "tutv-text", 
                            p("Andmed on saadud veebikraapimise teel kahelt erinevalt veebilehelt: FlixWatch ja IMDB."),
                            p("FlixWatch lehekülg: https://www.flixwatch.co/"),
                            p("IMDB lehekülg: https://www.imdb.com/search/title/?companies=co0144901&ref_=adv_prv"))
                            p("Netflix"), 
                            p("Tegu on aine Statistiline andmeteadus ja visualiseerimine raames tehtud Shiny projektiga"),
                            p("Autorid: Elis Käär ja Kadri Onemar"))
                        )
                    ),
                    box(solidHeader = T, background ="black",
                        title = "Eesti Netflixi filmide pingerida IMDB järgi",
                        dataTableOutput("movies_table")
                    )
                )
            ),
            
        # netflix originaalid
            tabItem(
                tabName = 'originals',
                fluidRow(
                    column(width = 5,
                           box( width = NULL, background ="black",
                               h1("Parimad Netflixi originaalsed filmid ja TV-seriaalid")
                               
                           ),
                           box(width = NULL, background ="black",
                               verbatimTextOutput("hover_info")
                           )
                        
                    ),
                    column(width = 7,
                           box(width = NULL, background ="black",
                               plotOutput('origtime', hover = hoverOpts(id = "plot_hover"))
                           ),
                            box(width = NULL, background ="black",
                                plotOutput('origline')
                            )
                    )
                )
            ),
            
        
        # parimad tv-seriaalid
            tabItem(
                tabName = 'tv',
                fluidRow(
                    column(width = 6,
                           box( width = NULL, background ="black"
                                
                           ),
                           box(width = NULL, background ="black"
                               
                           )
                           
                    ),
                    column(width = 6,
                           box(width = NULL, background ="black",
                               plotOutput('tvline')
                           ),
                           box(width = NULL, background ="black"
                               
                           )
                    )
                )
            )
        )
    )
))
# 
#         tabItems(
#             tabItem(
#                 "New",
#                 box(width = 12,
#                     solidHeader = T,
#                     color = "maroon",
#                     title = "New on Netflix in Estonia",
#                     dataTableOutput("NewonNetflix_table")),
#                 ),
#             tabItem(
#                 "TV",
#                 box(width = 12,
#                     solidHeader = T,
#                     color = "maroon",
#                     title = "100 Best TV Shows in Estonia",
#                     dataTableOutput("TV_table")),
#                 ),
#             tabItem(
#                 "Originaalid",
#                 box(width = 12,
#                     solidHeader = T,
#                     color = "maroon",
#                     title = "100 Best Netflix Originals in Estonia",
#                     dataTableOutput("original_table")),
#                 ),
#             tabItem(
#                 "About",
#                 box(width = 12,
#                     solidHeader = T,
#                     status = "danger",
#                     title = "About data",
#                     p("Andmed on saadud veebikraapimise teel kahelt erinevalt veebilehelt: FlixWatch ja IMDB."),
#                     p("FlixWatch lehekülg: https://www.flixwatch.co/"),
#                     p("IMDB lehekülg: https://www.imdb.com/search/title/?companies=co0144901&ref_=adv_prv")),
#                 )
#                 
#             )
#         )
#     )
# )
# 
