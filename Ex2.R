# Булычева В.С. постройте картосхему средних диаметров стволов деревьев родов Туя и Боярышник
rm(list=ls())
library(sf)
library(ggplot2)
library(dplyr)
library(tidyr)
setwd ("D:/Mod2")
install.packages("sf")
greendb= read.csv("greendb.csv"); greendb
map=sf :: read_sf("moscow.geojson")
ggplot(map)+geom_sf(aes(fill=NAME))+theme(legend.position="none")
spec=greendb$species_ru
genus=stringr::str_split(spec, pattern=" ",simplify=T)[,1]
data=greendb%>%mutate(Genus=genus)
# средний объем стволов
sr=data %>% group_by(adm_region,Genus)%>% 
  summarise(s_r=mean(d_trunk_m), na.rm = T)%>% 
  filter(Genus %in% c("Туя","Боярышник"))
sr
sr=pivot_wider(sr,names_from = Genus, values_from = s_r)
map=map %>% mutate(adm_region=NAME)
map=left_join(map, sr, by="adm_region")
ggplot(map)+
  geom_sf(aes(fill=`Туя`))+theme()
ggplot(map)+
  geom_sf(aes(fill=`Боярышник`))+theme()

