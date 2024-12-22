#Булычева В.С. для района Нагатинский Затон 
#докажите что высота родов Туя и Боярышник значимо отличаются.
rm(list=ls())
setwd ("D:/Mod2")
greendb=read.csv("greendb.csv", sep=",",dec="."); greendb
library(dplyr)
library(stringr)
# Туи в Нагатинском Затоне нету, взяла Клен
spec=greendb$species_ru;spec
genus=stringr::str_split(spec, pattern=" ",simplify=T)[,1];genus
data=greendb%>%mutate(Genus=genus);data
data=data%>%filter(Genus%in% c("Клен","Боярышник")) %>%
  filter(adm_region=="район Нагатинский Затон")
greendb$Genus%>%unique()
greendb$adm_region%>%unique()
#Если отвергаем Но, то значимо отличаются
data.aov = aov(d_trunk_m ~ Genus, data=data)
summary(data.aov)
# высота деревьев значимо отличается
