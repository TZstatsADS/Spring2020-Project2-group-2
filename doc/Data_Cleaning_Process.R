library(tidyverse)

arrest.clean %>% 
  group_by(OFNS_DESC) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) -> a


arrest <- read_csv("../data/NYPD_Arrests_Data__Historic_.csv")

arrest.cleaned <-
  arrest %>% 
  select(-c("ARREST_KEY", "PD_CD", "PD_DESC", "KY_CD", "LAW_CODE" )) %>% 
  na.omit() %>% 
  filter(OFNS_DESC != "") %>% 
  filter(ARREST_BORO != "") %>% 
  filter(AGE_GROUP != "") %>% 
  filter(PERP_RACE != "UNKNOWN") %>% 
  filter(LAW_CAT_CD != "") %>% 
  select(-c("X_COORD_CD","Y_COORD_CD")) %>% 
  mutate(ARREST_BORO = fct_recode(ARREST_BORO, 
                                  "Bronx" = "B",
                                  "StatenIsland" = "S",
                                  "Manhattan" = "M",
                                  "Queens" = "Q",
                                  "Brooklyn" = "K")) %>% 
  mutate(ARREST_BORO = as.character(ARREST_BORO)) %>% 
  mutate(LAW_CAT_CD = fct_recode(LAW_CAT_CD,
                                 "Felony" = "F",
                                 "Misdemeanor" = "M",
                                 "Violation" = "V",
                                 "Infraction" = "I")) %>% 
  mutate(LAW_CAT_CD = as.character(LAW_CAT_CD)) %>% 
  mutate(JURISDICTION_CODE = factor(JURISDICTION_CODE,
                                    levels = c(0,1,2),
                                    labels = c("Patrol", "Transit", "Housing"))) %>% 
  mutate(JURISDICTION_CODE = as.character(JURISDICTION_CODE)) %>% 
  replace_na(list(JURISDICTION_CODE = "Others")) %>% 
  mutate(PERP_SEX = fct_recode(PERP_SEX,
                               "Male" = "M",
                               "Female" = "F"))

save()  




