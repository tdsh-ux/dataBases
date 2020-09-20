library(tidyverse) 
menu <- read.csv(paste0(getwd(), "/data/menu.csv")) 

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
			    replacement = "NULL")) %>% 
	mutate(venue = gsub(x = venue, pattern = "^$", replacement = "NULL")) 

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
			       replacement = "NULL")) %>% 
	mutate(event = gsub(x = event, pattern = "\\?", 
			    replacement = "")) %>% 
	mutate(event = gsub(x = event, pattern = "^\\[?\\?\\]?$", 
			       replacement = "NULL")) %>% 
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
	mutate(occasion = gsub(x = occasion, pattern = ".{0,4}[O0]T?HE?R?.*", 
			       replacement = "OTHER")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "(.*AM?[NV]?[NV]I.*)|(BIRTHDAY)", 
			       replacement = "ANNIVERSARY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*GRADUTATION.*", 
			       replacement = "GRADUATION")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "(.*AM?NNU?A?L?.*)", 
			       replacement = "ANNUAL MEETING")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*WEDDING.*", 
			       replacement = "WEDDING")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "(.*REL.*)|(ST..*)", 
			       replacement = "RELIGIOUS HOLIDAY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*HOLI.*", 
			       replacement = "ANOTHER HOLIDAY")) %>%  
	mutate(occasion = gsub(x = occasion, pattern = ".*SOC.*", 
			       replacement = "SOCIAL")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*DINNER.*", 
			       replacement = "DAILY DINNER")) %>%  
	mutate(occasion = gsub(x = occasion, pattern = ".*LUNCH.*", 
			       replacement = "DAILY LUNCH")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*DAILY.*", 
			       replacement = "DAILY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*BANQUET.*", 
			       replacement = "BANQUET")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*C[O0I]*MP?.*", 
			       replacement = "CMPLUMENTARY")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "(.*BREAKF.*)|(.*CAFE.*)", 
			       replacement = "BREAKFAST")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*FUNERAL.*", 
			       replacement = "FUNERAL")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = ".*REUNION.*", 
			       replacement = "REUNION")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "^$", 
			       replacement = "NULL")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "^\\[?\\?\\]?$", 
			       replacement = "NULL")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "\\[|\\]|\\(|\\)", 
			       replacement = "")) %>% 
	mutate(occasion = gsub(x = occasion, pattern = "\\?", 
			       replacement = "")) 

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
	mutate(place = map(place, ~cleanData(.x, ".*EN ROUTE.*", "NULL"))) 


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
	mutate(sponsor = map(sponsor, ~cleanData(.x, "^$", "NULL"))) 
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
			   replacement = "NULL")) %>% 
	mutate(name = gsub(x = name, pattern = "\\[|\\]", 
			   replacement = "")) %>% 
	mutate(name = gsub(x = name, pattern = "RESTAURANT NAME AND/OR LOCATION NOT GIVEN", 
			   replacement = "NULL")) %>% 
	mutate(name = gsub(x = name, pattern = "\"|\"", 
			   replacement = "")) 


# D 
menuD <- menuN 
menuD <- menuD %>% 
	mutate(date = as.Date(date)) 

menuD %>% 
	group_by(date) %>% 
	count %>% 
	arrange(desc(n)) 

menuClean <- menuD %>% 
	select(id, name, event, sponsor, currency, venue, dish_count, page_count) 
write.table(x = menuClean, file = paste0(getwd(), "/cleanedData/menuClean.csv"), row.names = FALSE)  

