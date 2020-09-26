library(tidyverse) 
menu <- read.csv(paste0(getwd(), "/data/menu.csv")) 
menuItem <- read.csv(paste0(getwd(), "/data/menuItem.csv")) 
menuPage <- read.csv(paste0(getwd(), "/data/menuPage.csv")) 
# venue 
menuTable <- menu %>% select(!notes) 
menuTable <- menuTable %>% 
	mutate(venue = toupper(venue)) %>% 
	mutate(venue = gsub(x = venue, pattern = ";", replacement = "")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*(SOC).*", 
			    replacement = "SOCIAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*[OP]THER.*", 
			    replacement = "OTHER")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*(EDU[CS]).*", 
			    replacement = "EDUCATIONAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*GOVT.*", 
			    replacement = "GOVERNMENTAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*GOV.*", 
			    replacement = "GOVERNMENTAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*POL.*", 
			    replacement = "POLITICAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*REL.*", 
			    replacement = "RELIGIOUS")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*NAV.*", 
			    replacement = "NAVAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*MIL.*", 
			    replacement = "MILITARY")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*PAT.*", 
			    replacement = "PATRIOTIC")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*[CDS][OA]*[MN].*", 
			    replacement = "COMMERCIAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*PRO.*", 
			    replacement = "PROF")) %>% 
	mutate(venue = gsub(x = venue, pattern = "FOREIGN.*", 
			    replacement = "FOREIGN")) %>% 
	mutate(venue = gsub(venue, pattern = ".*PRI[VC]ATE.*", 
			    replacement = "PRIVATE")) %>% 
	mutate(venue = gsub(venue, pattern = "HOTEL.*", 
			    replacement = "HOTEL")) %>% 
	mutate(venue = gsub(x = venue, pattern = "\\[?\\?\\]?", 
			    replacement = NA)) %>% 
	mutate(venue = gsub(x = venue, pattern = "^$", replacement = NA)) 

unique(menuTable[["venue"]]) 

menuTable %>% 
	group_by(venue) %>% 
	count %>% 
	arrange(desc(n)) 
# e 

# event é mais específico; por exemplo, reunião anula do grupo tal; 
# banquete do aniversário de alguém. 
menuEvent <- menuTable 
menuEvent <- menuEvent %>% 
	mutate(event = toupper(event)) %>% 
	mutate(event = gsub(x = event, pattern = "(.*MEETING.*)|(.*SYMPOSIUM.*)|(.*CELEBRATION.*)|(*.RECEPTION.*)", 
			    replacement = "MEETING")) %>% 
	mutate(event = gsub(x = event, pattern = "^$", 
			       replacement = NA)) %>% 
	mutate(event = gsub(x = event, pattern = "\\?", 
			    replacement = "")) %>% 
	mutate(event = gsub(x = event, pattern = "^\\[?\\?\\]?$", 
			       replacement = NA)) %>% 
	mutate(event = gsub(x = event, pattern = "\\[|\\]|\\(|\\)|([\\])|;", 
			       replacement = "")) %>% 
	mutate(event = gsub(x = event, pattern = "\"|\""  , 
			    replacement = "")) 

unique(menuEvent[["event"]])

menuEvent %>% 
	group_by(event) %>% 
	count %>% 
	arrange(desc(n)) 
# o 
# occasion é mais amplo; por exemplo, aniversários, encontros, jantares em geral. 
menuO <- menuEvent 
menuO <- menuO %>% 
	mutate(occasion = toupper(occasion)) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ";", 
			       replacement = "")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*ANN.*|ANIV.*", 
			       replacement = "ANNIVERSARY")) %>% 
	mutate(occasion = gsub(x = occasion, ".*RELIG.*", 
			       replacement = "RELIGIOUS HOLIDAY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*PATRIOTIC.*", 
			       replacement = "PATRIOTIC HOLIDAY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*SECULAR.*", 
			       replacement = "SECULAR HOLIDAY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*ETHNIC.*", 
			       replacement = "ETHNIC HOLIDAY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*DAILY.*|^DINNER$", 
			       replacement = "DAILY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "\\(?[O0]T?HE.*", 
			       replacement = "OTHER")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "^$|.*\\?.*", 
			       replacement = NA)) 


unique(menuO[["occasion"]]) 

menuO %>% 
	group_by(occasion) %>% 
	count %>% 
	arrange(desc(n)) 

cleanData <- function(dataVector, regularExpression, replacementString) {
	gsub(x = dataVector, pattern = regularExpression, replacement = replacementString) 
} 



# place 

menuP <- menuO 
menuP <- menuP %>% 
	mutate(place = map(place, ~cleanData(.x, "\\(|\\)|\\[|\\]", ""))) %>% 
	mutate(place = map(place, ~cleanData(.x, ";", ""))) %>% 
	mutate(place = map(place, ~cleanData(.x, "-", ","))) %>% 
	mutate(place = map(place, ~cleanData(.x, "NEW YORK, ", ""))) %>% 
	mutate(place = map(place, ~cleanData(.x, "\\?", ""))) %>% 
	mutate(place = map(place, ~cleanData(.x, "N\\.Y\\.", "NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "\"|\"", ""))) %>% 
	mutate(place = map(place, ~cleanData(.x, "NEW YORK[ ]$", "NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "R\\.I\\.", "RI"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "NEW YORK CITY", "NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "\\.NY", ", NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, ",NY", "NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "NYC", "NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "COLO\\.", "CO"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "[^,] NY", ", NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "P\\.I\\.", "PI"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "D\\.C\\.", "DC"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "N\\.C\\.", "NC"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "[^,] OH", ", OH"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "^NY$", "NULL, NY"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "[^,] VA", ", VA"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "[^,] IL", ", IL"))) %>% 
	mutate(place = map(place, ~cleanData(.x, "[^,] PA", ", PA"))) %>% 
	mutate(place = map(place, ~cleanData(.x, ".*EN ROUTE.*", NA))) 


unique(menuP[["place"]]) 


# s 

menuS <- menuP 

menuS <- menuS %>% 
	mutate(sponsor = toupper(sponsor)) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "RED ST[AE]R LINE.*", 
						 "RED STAR LINE - ANTWERPEN"))) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "AMERICA[LN]", "AMERICAN"))) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "^\\(|\\)$|\\(\\?\\)|\\?|;|\\[|\\]", ""))) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "RESTAURANT NAME AND/OR LOCATION NOT GIVEN", ""))) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "^$", NA))) %>% 
	mutate(sponsor = map(sponsor, ~cleanData(.x, "\"|\"", ""))) 
menuS[["sponsor"]] <- unlist(menuS[["sponsor"]]) 


menuS %>% 
	group_by(name) %>% 
	count %>% 
	arrange(desc(n)) 




# N 
menuN <- menuS 
menuN <- menuN %>% 
	mutate(name = toupper(name)) %>% 
	mutate(name = gsub(x = name, pattern = "^$", 
			   replacement = NA)) %>% 
	mutate(name = gsub(x = name, pattern = "\\[|\\]", 
			   replacement = "")) %>% 
	mutate(name = gsub(x = name, pattern = "RESTAURANT NAME AND/OR LOCATION NOT GIVEN", 
			   replacement = NA)) %>% 
	mutate(name = gsub(x = name, pattern = "\"|\"", 
			   replacement = "")) 


# D 
menuD <- menuN 

menuD %>% 
	group_by(date) %>% 
	count %>% 
	arrange(desc(n)) 

menuClean <- menuD %>% 
	select(id, name, date, event, sponsor, currency, venue, dish_count, page_count, currency_symbol)  



normalizeTable <- function(dataframe, field) { 
	
	library(rlang) 
	
	x <- unique(dataframe[[field]]) 
	idKeys <- list() 
	id <- 1 
	for(index in seq(1, length(x))) { 
		if(!x[index] %in% idKeys) {
			idKeys[[id]] <- x[index] 
			id <- id + 1 
		} 
	} 
	
	fieldTable <- data.frame(id = seq(1, length(x)), 
				 field = unlist(map(seq(1, length(x)), ~idKeys[[.x]]))) 
	
	
	
	return(fieldTable)    
	
} 

menuItemG <- menuItem %>% 
	filter(dish_id %in% dishG[["id"]], 
	       menu_page_id %in% menuPageG[["id"]]) %>% 
	select(menu_page_id, dish_id, price) 

write.csv(menuItemG, file = paste0(getwd(), "/modelData/menuItemG.csv"), row.names = FALSE) 


menuPageG <- menuPage %>% 
	filter(menu_id %in% menuG[["id"]], 
	       id %in% menuItemG[["menu_page_id"]]) %>% 
	select(id, menu_id, page_number, full_height, full_width) 


write.csv(menuPageG, file = paste0(getwd(), "/modelData/menuPageG.csv"), row.names = FALSE) 

menuG <- menuClean %>% 
	filter(id %in% menuPageG[["menu_id"]]) 

venueId <- normalizeTable(menuG, "venue") %>% rename(venue_id = id) %>% rename(type = field) 
eventId <- normalizeTable(menuG, "event") %>% rename(event_id = id) %>% rename(venue = field)   
sponsorId <- normalizeTable(menuG, "sponsor") %>% rename(sponsor_id = id) %>% rename(name = field)
currencyId <- normalizeTable(menuG, "currency") %>% rename(currency_id = id) %>% rename(name = field) 
	


menuG <- menuG %>% 
	inner_join(venueId, by = c("venue" = "type")) %>% 
	inner_join(eventId, by = c("event" = "venue")) %>% 
	inner_join(sponsorId, by = c("sponsor" = "name")) %>% 
	inner_join(currencyId, by = c("currency" = "name")) %>% 
	rename(event_date = date) %>% 
	select(!c(venue, event, sponsor, currency, currency_symbol, dish_count, page_count))    

venueId <- venueId %>% rename(id = venue_id) 
eventId <- eventId %>% rename(id= event_id) 
sponsorId <- sponsorId %>% rename(id = sponsor_id) 
currencyId <- currencyId %>% rename(id = currency_id)  


write.csv(x = menuG, file = paste0(getwd(), "/modelData/menuG.csv"), row.names = FALSE) 
write.csv(x = venueId, file = paste0(getwd(), "/modelData/venueId.csv"), row.names = FALSE) 
write.csv(x = eventId, file = paste0(getwd(), "/modelData/eventId.csv"), row.names = FALSE) 
write.csv(x = sponsorId, file = paste0(getwd(), "/modelData/sponsorId.csv"), row.names = FALSE) 
write.csv(x = currencyId, file = paste0(getwd(), "/modelData/currencyId.csv"), row.names = FALSE) 











