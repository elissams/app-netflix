
## server


library(shiny)
library(tidyverse)
library(devtools)
install_github("nsgrantham/ggdark")
library(ggdark)
library(DT)

## parimad netflixi originaalid ----

bestnetflixoriginals_table = bestnetflixoriginals_table %>% group_by(year) %>% mutate(mean = mean(rating), n = n()) %>% ungroup()

origline <- ggplot(bestnetflixoriginals_table, aes(reorder(title, -rating), rating)) + 
    geom_segment(aes(x = reorder(title, -rating), xend =reorder(title, -rating), y=0, yend=rating), color = '#147ae0') + 
    geom_hline(yintercept = mean(ratings), color = "#9214e0") +
    labs(x = "", y = "IMDB hinne") +
    dark_theme_gray() + theme(axis.text.x = element_blank(), axis.ticks.x=element_blank())
origline

bestnetflixoriginals_table2 = bestnetflixoriginals_table
bestnetflixoriginals_table2$year = as.Date(as.character(bestnetflixoriginals_table2$year), "%Y")
origtime <- ggplot(bestnetflixoriginals_table2, aes(year, mean )) + geom_line(color = "#e01469") + 
    geom_point(aes(size = n ), color = "#e01469") +
    labs (size= "filmide/seriaalide\n arv", x="", y="IMDB keskmine hinne") +
    dark_theme_gray()
origtime

## parimad tv-sarjad ----

tvline <- ggplot(bestTVshows_table, aes(reorder(title, -rating), rating)) + 
    geom_segment(aes(x = reorder(title, -rating), xend =reorder(title, -rating), y=0, yend=rating), color = '#147ae0') + 
    labs(x = "", y = "IMDB hinne") +
    dark_theme_gray()


# funktsioonid


linepl <- function(andmed, minAasta, maxAasta, maxKirjed){
    andmed <- andmed %>% filter(year %in% seq(minAasta, maxAasta, by=1))%>% top_n(maxKirjed)
    
    origline <- ggplot(andmed, aes(reorder(title, rating), rating)) + 
        geom_segment(aes(x = reorder(title, -rating), xend =reorder(title, -rating), y=0, yend=rating), color = '#147ae0') + 
        geom_hline(yintercept = mean(ratings), color = "#9214e0") +
        labs(x = "", y = "IMDB hinne") + coord_flip() +
        dark_theme_gray()
   return(origline)
    
}

zanrid <- function(andmed, minAasta, maxAasta) {
    andmed = andmed %>% filter(year %in% seq(minAasta, maxAasta, by=1))
    t <- paste(andmed$genre, collapse = ', ')
    split <- strsplit(t, ", ")
    table <- table(split)
    tabeldf <- as.data.frame(table)
    tabeldf <- tabeldf %>% filter()  %>% arrange(desc(Freq))
    return(tabeldf)
}


t <- paste(bestnetflixoriginals_table$genre, collapse = ', ')
split <- strsplit(t, ", ")
table <- table(split)
tabeldf <- as.data.frame(table)
tabeldf <- tabeldf %>% arrange(desc(Freq))

# Define server logic
shinyServer(function(input, output, session) {
  
  output$NewonNetflix_table = renderDataTable({
    datatable(newonnetflix_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genres"), filter = "top") 
  })


    output$movies_table = renderDataTable({
        datatable(bestmovies_table, colnames = c("Title" = "title", "Year" = "year"), filter = "top")}, height = 800) 
    
    output$TV_table = renderDataTable({
    datatable(bestTVshows_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top") 
    })
    
    output$original_table = renderDataTable({
    datatable(bestnetflixoriginals_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top")

    })

# graafikud

output$origline <- renderPlot({linepl(bestnetflixoriginals_table,input$aastad1[1], input$aastad1[2] ,maxKirjed=input$kirjed1)}, height = 800)

output$origtime <- renderPlot({origtime})

output$tvline <- renderPlot({linepl(bestTVshows_table, input$aastad2[1], input$aastad2[2] ,maxKirjed=input$kirjed2)}, height = 800)







# value boxes
output$zanr1 <- renderValueBox({
    valueBox(
        zanrid(bestnetflixoriginals_table, input$aastad1[1], input$aastad1[2])[1,1], "žanr #1", icon = icon("film"),
        color = "lime"
    )
})

output$zanr2 <- renderValueBox({
    valueBox(
        zanrid(bestnetflixoriginals_table, input$aastad1[1], input$aastad1[2])[2,1], "žanr #2", icon = icon("film"),
        color = "purple"
    )
})

output$zanr3 <- renderValueBox({
    valueBox(
        zanrid(bestnetflixoriginals_table, input$aastad1[1], input$aastad1[2])[3,1], "žanr #3", icon = icon("film"),
        color = "fuchsia"
    )
})


# value boxes best TV shows
output$zanr4 <- renderValueBox({
    valueBox(
        zanrid(bestTVshows_table, input$aastad2[1], input$aastad2[2])[1,1], "žanr #1", icon = icon("film"),
        color = "lime"
    )
})

output$zanr5 <- renderValueBox({
    valueBox(
        zanrid(bestTVshows_table, input$aastad2[1], input$aastad2[2])[2,1], "žanr #2", icon = icon("film"),
        color = "purple"
    )
})

output$zanr6 <- renderValueBox({
    valueBox(
        zanrid(bestTVshows_table, input$aastad2[1], input$aastad2[2])[3,1], "žanr #3", icon = icon("film"),
        color = "fuchsia"
    )
})
})
