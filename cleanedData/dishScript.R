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
	)) 



write.table(dishClean, file = paste0(getwd(), "/cleanedData/dishClean.csv"), row.names = FALSE)  
