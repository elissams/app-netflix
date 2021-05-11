
## server


library(shiny)
library(tidyverse)
library(devtools)
install_github("nsgrantham/ggdark")
library(ggdark)
library(DT)

## parimad netflixi originaalid ----

bestnetflixoriginals_table = bestnetflixoriginals_table %>% group_by(year) %>% mutate(mean = mean(rating), n = n())
bestnetflixoriginals_table$year = as.Date(as.character(bestnetflixoriginals_table$year), "%Y")

origline <- ggplot(bestnetflixoriginals_table, aes(reorder(title, -rating), rating)) + 
    geom_segment(aes(x = reorder(title, -rating), xend =reorder(title, -rating), y=0, yend=rating), color = '#147ae0') + 
    geom_hline(yintercept = mean(ratings), color = "#9214e0") +
    labs(x = "", y = "IMDB hinne") +
    dark_theme_gray() + theme(axis.text.x = element_blank(), axis.ticks.x=element_blank())
origline

origtime <- ggplot(bestnetflixoriginals_table, aes(year, mean )) + geom_line(color = "#e01469") + geom_point(aes(size = n ), color = "#e01469", show.legend = F) + scale_x_date(date_labels = "%Y") +
    labs (x="", y="IMDB keskmine hinne")+ 
    dark_theme_gray()


## parimad tv-sarjad ----

tvline <- ggplot(bestTVshows_table, aes(reorder(title, -rating), rating)) + 
    geom_segment(aes(x = reorder(title, -rating), xend =reorder(title, -rating), y=0, yend=rating), color = '#147ae0') + 
    labs(x = "", y = "IMDB hinne") +
    dark_theme_gray()




# Define server logic
shinyServer(function(input, output, session) {
  
  output$NewonNetflix_table = renderDataTable({
    datatable(newonnetflix_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genres"), filter = "top") 
  })


output$movies_table = renderDataTable({
    datatable(bestmovies_table, colnames = c("Title" = "title", "Year" = "year"), filter = "top")}) 

output$TV_table = renderDataTable({
datatable(bestTVshows_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top") 
})

output$original_table = renderDataTable({
datatable(bestnetflixoriginals_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top")

    })
    
output$hover_info <- renderPrint({
    if(!is.null(input$plot_hover)){
        hover=input$plot_hover
        dist=sqrt((hover$x-mtcars$mpg)^2+(hover$y-mtcars$disp)^2)
        if(min(dist) < 3)
            mtcars$wt[which.min(dist)]
    }})
    

output$origline <- renderPlot({origline})

output$origtime <- renderPlot({origtime})

output$tvline <- renderPlot({tvline})
})
