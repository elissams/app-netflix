
## server

# Setting up workspace, install 'rstudioapi' if using for first time
#install.packages('rstudioapi')
setwd(dirname(rstudioapi::getActiveDocumentContext()[[2]]))



library(shiny)
library(DT)





# Define server logic
shinyServer(function(input, output, session) {
  
  output$NewonNetflix_table = renderDataTable({
    datatable(newonnetflix_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genres"), filter = "top") 
  })

  output$TV_table = renderDataTable({
    datatable(bestTVshows_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top") 
    })
  
  output$original_table = renderDataTable({
    datatable(bestnetflixoriginals_table, colnames = c("Title" = "title", "Year" = "year", "IMDB rating" = "rating", "Genre" = "genre"), filter = "top")
    })

})
