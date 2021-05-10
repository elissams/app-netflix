# web-scraping

library(tidyverse)
library(rvest)

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


#100 Best IMDB Rated TV shows in Estonia ----
html_bestTVshows <-  'https://www.flixwatch.co/lists/100-best-imdb-rated-tv-shows-on-netflix-estonia/'

bestTVshows <- read_html(html_bestTVshows)

headlines <- bestTVshows %>% 
  html_nodes('.amp-wp-67fc16d') %>% 
  html_text()

#Creating table
bestTVshows_table <- cbind(data.frame(headlines))
bestTVshows_table <- bestTVshows_table %>% 
  mutate(ranking = rownames(.)) %>% #make index as column
  separate(headlines, into = c("title", "year"), sep = -6) %>% #get year from headline
  mutate(year = str_replace(year, "\\(", "")) %>% #clean string
  mutate(year = str_replace(year, "\\)", "")) %>% #clean string
  separate(title, into = c("title", "toBeDeleted"), sep = -1) %>%  #using this to remove last char that was not whitespace
  select(-toBeDeleted) %>% 
  mutate_at("year", as.numeric) %>% 
  mutate_at("ranking", as.numeric)
#Get IMDB ratings and genres ----
html_start <- 'https://www.imdb.com/search/title/?companies=co0144901&'
html_end1 <- 'ref_=adv_prv'
html_middle <- 'start='
html_end2 <- '&ref_=adv_nxt'

all_titles <- c()
all_genres <- c()
all_ratings <- c()

for(i in 1:10){ #taking only 500 first titles
  
  html_number <- ((i-1)*50)+1
  print(html_number)
  if(i == 1){
    html_imdb <- paste(html_start, html_end1, sep = "")
  }else{
    html_imdb <- paste(html_start, html_middle, html_number, html_end2, sep = "")
  }
  
  imdb_data <- read_html(html_imdb)
  
  titles <- imdb_data %>% 
    html_nodes('.lister-item-content h3 a') %>% 
    html_text()
  
  all_titles <- append(all_titles, titles)
  
  genres <- imdb_data %>% 
    html_nodes('.lister-item-content p .genre') %>% 
    html_text()
  
  all_genres <- append(all_genres, genres)
  
  ratings <- imdb_data %>% 
    html_nodes('.ratings-bar .ratings-imdb-rating') %>% 
    html_attr("data-value")
  
  all_ratings <- append(all_ratings, ratings)
  
}

#Adding titles that do not have rating to be deleted
titlestoDelete <- c('Army of the Dead', 'Sweet Tooth', 'The Last Letter from Your Lover', 'Halston', '1899',
                    'Oxygène', 'The Woman in the Window', 'Awake', "Don't Look Up", 'Naine aknal',
                    "He's All That", 'Gunpowder Milkshake', 'Red Notice',
                    'Hotel Transylvania: Transformania') 
getIndices <- match(titlestoDelete,all_titles) %>% na.omit(.) #get indices for movies that do not have imdb score
all_titles <- all_titles[!all_titles %in% titlestoDelete] #remove titles that do not have imdb score
all_genres <- all_genres[-getIndices] #remove indices from genres

translations_est <- c('Grey anatoomia', 'Elavad surnud', 'Must nimekiri', 'Halvale teele', 'Viikingid', 'NCIS: Kriminalistid', 
                      'Välk', 'Sõbrad', 'Moodne perekond', 'Aeg kutsuda Saul', 'Ameerika õudukas', 'Vampiiripäevikud', 'Kuidas ma kohtasin teie ema', 
                      'Pintsaklipslased', 'Kodumaa', 'Politsei verd', 'Uus tüdruk', 'S.H.I.E.L.D.i agendid', "Gilmore'i tüdrukud", 'Perepea', 
                      'Star Trek: Uus põlvkond', 'Põgenemine', 'Elas kord...', 'Vibukütt', 'Sõrmuste isand: Sõrmuse vennaskond', 'Spartacus: veri ja liiv',
                      'Kuidas mõrvast puhtalt pääseda', 'CSI: Kriminalistid', 'Tapmine', 'Kaardimaja', 'Kahe tule vahel', 'Mõrv sai teoks', 
                      'Ameeriklased', 'Kapten Ameerika: Kodusõda', 'Saabumine', 'Sõrmuste isand: Kuninga tagasitulek', 'Põgenemise rütm', 'Ämblikmees',
                      'Valelikud võrgutajad', 'Kättemaks', 'Kõmutüdruk', 'Ameerika psühho', 'Edu valem', 'Batesi motell', 'Kääbik: Ootamatu teekond', 
                      'Taksojuht', 'Batman vs Superman: Õigluse koidik', 'Troopiline kõu', 'Arukas blondiin', 'Tudorid', 'Vaimudest viidud', 'Sõrmuste isand: Kaks kantsi',
                      'Narcos: México', "The Queen's Gambit", "Love, Death & Robots", "IT-osakond")

translations_eng <- c("Grey's Anatomy", "The Walking Dead", "The Blacklist", "Breaking Bad", "Vikings", "NCIS: Naval Criminal Investigative Service",
                      "The Flash", "Friends", "Modern Family", "Better Call Saul", "American Horror Story", "The Vampire Diaries",
                      "How I Met Your Mother", "Suits", "Homeland", "Blue Bloods", "New Girl", "Agents of S.H.I.E.L.D.", "Gilmore Girls", "Family Guy",
                      "Star Trek: The Next Generation", "Prison Break", "Once Upon a Time", "Arrow", "The Lord of the Rings: The Fellowship of the Ring",
                      "Spartacus", "How to Get Away with Murder", "CSI: Crime Scene Investigation", "The Killing", "House of Cards", "The Departed",
                      "Murder, She Wrote", "The Americans", "Captain America: Civil War", "Arrival","The Lord of the Rings: The Return of the King", 
                      "Baby Drivers", "Spider-Man", "Pretty Little Liars", "Revenge", "Gossip Girl", "American Psycho", "Moneyball", "Bates Motel", 
                      "The Hobbit: An Unexpected Journey", "Taxi Driver", "Batman v Superman: Dawn of Justice", "Tropic Thunder", "Legally Blonde", 
                      "The Tudors", "Spirited Away", "The Lord of the Rings: The Two Towers", "Narcos: Mexico", "The Queen’s Gambit", 
                      "Love, Death and Robots", "The IT Crowd")

getIndices <- match(translations_est,all_titles) #get indices for titles to translate

for (index in 1:length(getIndices)) {
  all_titles <- replace(all_titles, getIndices[index], translations_eng[index])
}

imdb_table2 <- cbind(data.frame(all_titles), data.frame(all_genres), data.frame(all_ratings))

#Combining data

imdb_table2 <- imdb_table2 %>% 
  rename(
    title = all_titles,
    genre = all_genres,
    rating = all_ratings
  )

bestnetflixoriginals_table <- bestnetflixoriginals_table %>% 
  left_join(imdb_table2)

bestmovies_table <- bestmovies_table %>% 
  left_join(imdb_table2)

bestTVshows_table <- bestTVshows_table %>% 
  left_join(imdb_table2)
