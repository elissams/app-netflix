
## app ui

library(tidyverse)
library(shiny)
library(rvest)

#Scraping data from web ----

#"New on Netflix" data ----
html_newonnetflix <-  'https://www.flixwatch.co/newonnetflix/estonia/'

newonnetflix <- read_html(html_newonnetflix)

headlines <- newonnetflix %>% 
    html_nodes('.amp-wp-bc0486a') %>% 
    html_text()

ratings <- newonnetflix %>% 
    html_nodes('#imdb') %>% 
    html_text()

genres <- newonnetflix %>% 
    html_nodes('.amp-wp-28d1f7b') %>% 
    html_text() #%>% 

#Creating table
newonnetflix_table <- cbind(data.frame(headlines), data.frame(ratings), data.frame(genres))
newonnetflix_table <- newonnetflix_table %>% 
    mutate(ratings = str_replace(ratings, " ", "")) %>% #clean string
    mutate(ratings = str_replace(ratings, "\\(", "")) %>% #clean string
    mutate(ratings = str_replace(ratings, "\\)", "")) %>% #clean string
    separate(ratings, into = c("rating", "maxRating"), sep = "/") %>% 
    separate(headlines, into = c("title", "year"), sep = -7) %>% #get year from headline
    mutate(year = str_replace(year, "\\(", "")) %>% #clean string
    mutate(year = str_replace(year, "\\)", "")) %>% #clean string
    separate(title, into = c("title", "toBeDeleted"), sep = -1) %>%  #using this to remove last char that was not whitespace
    select(-toBeDeleted) %>% 
    separate(year, into = c("year", "toBeDeleted"), sep = -1) %>%  #using this to remove last char that was not whitespace
    select(-toBeDeleted) %>% 
    mutate(genres = trimws(genres, which = c("both", "left", "right"), whitespace = "[ \t\r\n]")) %>% #clean string
    mutate(genres = gsub("[\r\n\t]", "", genres)) %>% #clean string
    mutate_at("year", as.numeric) %>% 
    mutate_at("rating", as.numeric) 


#100 Best IMDB Rated Netflix Originals in Estonia ----
html_bestnetflixoriginals <-  'https://www.flixwatch.co/lists/100-best-imdb-rated-netflix-originals-estonia/'

bestnetflixoriginals <- read_html(html_bestnetflixoriginals)

headlines <- bestnetflixoriginals %>% 
    html_nodes('.amp-wp-67fc16d') %>% 
    html_text()

#Creating table
bestnetflixoriginals_table <- cbind(data.frame(headlines))
bestnetflixoriginals_table <- bestnetflixoriginals_table %>% 
    mutate(ranking = rownames(.)) %>% #make index as column
    separate(headlines, into = c("title", "year"), sep = -6) %>% #get year from headline
    mutate(year = str_replace(year, "\\(", "")) %>% #clean string
    mutate(year = str_replace(year, "\\)", "")) %>% #clean string
    separate(title, into = c("title", "toBeDeleted"), sep = -1) %>%  #using this to remove last char that was not whitespace
    select(-toBeDeleted) %>% 
    mutate_at("year", as.numeric) %>% 
    mutate_at("ranking", as.numeric)

#100 Best IMDB Rated Movies in Estonia ----
html_bestmovies <-  'https://www.flixwatch.co/lists/100-best-imdb-rated-movies-on-netflix-estonia/'

bestmovies <- read_html(html_bestmovies)

headlines <- bestmovies %>% 
    html_nodes('.amp-wp-67fc16d') %>% 
    html_text()

#Creating table
bestmovies_table <- cbind(data.frame(headlines))
bestmovies_table <- bestmovies_table %>% 
    mutate(ranking = rownames(.)) %>% #make index as column
    separate(headlines, into = c("title", "year"), sep = -6) %>% #get year from headline
    mutate(year = str_replace(year, "\\(", "")) %>% #clean string
    mutate(year = str_replace(year, "\\)", "")) %>% #clean string
    separate(title, into = c("title", "toBeDeleted"), sep = -1) %>%  #using this to remove last char that was not whitespace
    select(-toBeDeleted) %>% 
    mutate_at("year", as.numeric) %>% 
    mutate_at("ranking", as.numeric)



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

