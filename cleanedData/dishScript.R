dish <- read.csv(paste0(getwd(), "/data/dish.csv")) 

dishClean <- dish %>% 
	mutate(last_appeared = ifelse( 
		last_appeared %in% c(2928, 0, 1), 
		NA, 
		last_appeared 
	), 
	first_appeared = ifelse(
		first_appeared %in% c(2928, 0, 1), 
		NA, 
		first_appeared 
	), 
	times_appeared = ifelse( 
		times_appeared <= 0, 
		NA, 
		times_appeared 
	)) %>% 
	select(!description) %>% 
	mutate(name = gsub(x = name, pattern = "\\[|\\]|^\\(\\)$|\\?", 
			   replacement = "")) %>% 
	mutate(name = gsub(x = name, pattern = "\"|\"", 
			   replacement = "")) %>% 
	mutate(name = gsub(x = name, pattern = "^' +|^ +",  
			   replacement = "")) 

cleanDish <- dishClean %>% 
	group_by(name) %>% 
	summarise(id = min(id), 
		  menus_appeared = sum(menus_appeared, na.rm = TRUE), 
		  times_appeared = sum(times_appeared, na.rm = TRUE), 
		  first_appeared = min(first_appeared, na.rm = TRUE), 
		  last_appeared = max(last_appeared, na.rm = TRUE), 
		  lowest_price = min(lowest_price, na.rm = TRUE), 
		  highest_price = max(highest_price, na.rm = TRUE)) %>%  
	mutate(name = gsub(x = name, pattern = "^$", 
			   replacement = "NULL")) 



write.table(cleanDish, file = paste0(getwd(), "/cleanedData/dishClean.csv"), row.names = FALSE) 
