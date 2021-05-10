# web-scraping

library(dplyr)
library(rvest)


html_source = 'https://www.flixwatch.co/?s&id=45310/'
leht =  read_html(html_source)



pealkirjad = leht %>% html_nodes('li') %>% html_text()

pealkirjad[1:10]
