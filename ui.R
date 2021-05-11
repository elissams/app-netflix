
## app ui

library(shiny)
library(shinydashboard)
library(DT)

# tutvustav tekst


tekst <- div(class = "tutv-text", 
             h1("Netflixi andmete kraapimine ja visualiseerimine"),
             p("Projekti eesmärk oli õppida andmete kraapimist veebist ja teha saadud andmetest Shiny rakendus."),
             p("Rakenduse loomiseks on andmed kraabitud rvest paketi abil kahelt erinevalt veebileheküljelt: FlixWatch ja IMDb (Internet Movie Database).
                    FlixWatch on mitteametlik Netflixi sisu otsida võimaldav veebileht, kus on võimalik leida infot erinevate riikide Netfllixis näidatava sisu kohta.
                    Andmetena on kasutatud Eestis näidatavat sisu ehk 100 värskemat Netflixi ilmunud filmi/sarja, 100 kõrgeimalt hinnatud Netflixi originaal sisu ja 100 kõrgeimalt hinnatud telesarja Eestis.
                    Need sarjade/filmide nimed on kokku viidud IMDb veebilehelt saadud IMDb hinnangute ja filmižanri märksõnadega, et oleks võimalik sisu filtreerida."),
             p("Tabelites on enamasti 5 veegu: sisu nimi, žanrid, ilmumisaasta, IMDb kasutajate hinnang ja populaarsuse positsioon Eestis. Positsioon puudub ainult värkeima sisu tabelist."),
             p("Kasutatud veebilehed:"),
             p("FlixWatch lehekülg: https://www.flixwatch.co/country/estonia"),
             p("IMDB lehekülg: https://www.imdb.com/search/title/?companies=co0144901&ref_=adv_prv"),
p("Tegu on aine Statistiline andmeteadus ja visualiseerimine raames tehtud Shiny projektiga"),
p("Autorid: Elis Käär ja Kadri Onemar"))



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
                    box( width = NULL,
                         background ="black",
                            div(img(src="diivan.jpg", width = 600)),
                        tekst
                        )
                    ),
                    column(width = 6,
                        box(width = NULL,solidHeader = T, background ="black",
                            title = "Eesti Netflixi filmide pingerida IMDB järgi",
                            dataTableOutput("movies_table")
                        )
                    )
                )),
            
        # netflix originaalid
            tabItem(
                tabName = 'originals',
                fluidRow(
                    column(width = 6,
                           box( width = NULL, background ="black",
                               h1("Parimad Netflixi originaalsed filmid ja TV-seriaalid")
                               
                           ),
                           box(width = NULL, height = 840, background ="black",
                               plotOutput('origline')
                           )
                        
                    ),
                    column(width = 6,
                           box(width = NULL, background ="black", title = "Sarjade ja filmide keskmised aastate lõikes",
                               plotOutput('origtime')
                           ),
                           box(width = NULL, background ="black",title = "Populaarseimad žanrid valitud aastate lõikes",
                               valueBoxOutput("zanr1"),
                               valueBoxOutput("zanr2"),
                               valueBoxOutput("zanr3")
                           ),
                           box(width = NULL, background ="black",
                               sliderInput("aastad1", "Vali aastate vahemik", min=2013, max=2021, value=c(2013,2021), dragRange = TRUE),
                               sliderInput("kirjed1", "Vali kirjete arv", min=5, max=100, value=20)
                           )
                    )
                )
            ),
            
        
        # parimad tv-seriaalid
            tabItem(
                tabName = 'tv',
                fluidRow(
                    column(width = 6,
                           box( width = NULL, background ="black",
                                h1("Parimad TV-seriaalid")
                                
                           ),
                           box( width = NULL, height = 840, background ="black",
                                plotOutput('tvline')    
                           )
                    ),
                    column(width = 6,
                           box(width = NULL, background ="black",title = "Populaarseimad žanrid valitud aastate lõikes",
                               valueBoxOutput("zanr4"),
                               valueBoxOutput("zanr5"),
                               valueBoxOutput("zanr6")
                           ),
                           box(width = NULL, background ="black",
                               sliderInput("aastad2", "Vali aastate vahemik", min=2013, max=2021, value=c(2013,2021), dragRange = TRUE),
                               sliderInput("kirjed2", "Vali kirjete arv", min=5, max=100, value=20)
                           )
                    )
                )
            )
        )
    )
)
)

