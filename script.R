library(tidyverse) 
menu <- read.csv(paste0(getwd(), "/data/menu.csv")) 

# venue 
menuTable <- menu %>% select(!notes) 
menuTable <- menuTable %>% 
	mutate(venue = gsub(x = venue, pattern = ";", replacement = "")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*(SOC).*", 
			    replacement = "SOCIAL")) %>% 
	mutate(venue = gsub(x = venue, pattern = ".*OTHER.*", 
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
			    replacement = "HOTEL")) 

unique(menuTable[["venue"]]) 



# e 
menuEvent <- menuTable 
menuEvent <- menuEvent %>% 
	mutate(event = toupper(event)) %>% 
	mutate(event = gsub(x = event, pattern = "(.*MEETING.*)|(.*SYMPOSIUM.*)|(.*CELEBRATION.*)|(*.RECEPTION.*)", 
			    replacement = "MEETING")) %>%  
	mutate(event = gsub(x = event, pattern = ".*DIN{0,2}E{0,1}R?.*", 
			    replacement = "DINNER")) %>% 
	mutate(event = gsub(x = event, pattern = ".*LUNCH.*", 
			    replacement = "LUNCH")) %>% 
	mutate(event = gsub(x = event, pattern = "(.*ANNIVERSARY.*)|(.*BIRTHDAY.*)", 
			    replacement = "ANNIVERSARY")) %>% 
	mutate(event = gsub(x = event, pattern = ".*BREAKFAST.*", 
			    replacement = "BREAKFAST")) %>% 
	mutate(event = gsub(x = event, pattern = ".*BANQUET.*", 
			    replacement = "BANQUET")) %>% 
	mutate(event = gsub(x = event, pattern = ".*DESSERT.*", 
			    replacement = "DESSERT")) %>% 
	mutate(event = gsub(x = event, pattern = "(.*BEVERAGE.*)|(.*CHAMPAGNE.*)|(.*TEA.*)", 
			    replacement = "DRINKS")) %>% 
	mutate(event = gsub(x = event, pattern = "^$", 
			       replacement = "NULL")) %>% 
	mutate(event = gsub(x = event, pattern = "^\\[?\\?\\]?$", 
			       replacement = "NULL")) %>% 
	mutate(event = gsub(x = event, pattern = "\\[|\\]|\\(|\\)|([\\])|;", 
			       replacement = "")) %>% 
	mutate(event = gsub(x = event, pattern = "\"|\""  , 
			    replacement = "")) 

unique(menuEvent[["event"]]) 


# o 
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
			       replacement = "")) 

unique(menuO[["occasion"]]) 
