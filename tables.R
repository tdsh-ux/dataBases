dishUrl <- "https://query.data.world/s/ze7m6xe47eoteyhlzuvgrft6tfz3fa" 
menuUrl <- "https://query.data.world/s/dvak3nru6f63rowpcruc3dqweent2e"  
menuItemUrl <- "https://query.data.world/s/7hj6xqte4ftuisvigor4yjkffn52mc" 
menuPageUrl <- "https://query.data.world/s/2onbfmxc5d3c6s7pqxv5ucgh4bzrdd" 

dir <- getwd() 

if(!dir.exists(paste0(dir, "/data"))) dir.create(paste0(dir, "/data")) 


download.file(menuPageUrl, destfile = paste0(dir, "/data/menuPage.csv"))  
download.file(menuItemUrl, destfile = paste0(dir, "/data/menuItem.csv")) 
download.file(menuUrl, destfile = paste0(dir, "/data/menu.csv")) 
download.file(dishUrl, destfile = paste0(dir, "/data/dish.csv")) 


