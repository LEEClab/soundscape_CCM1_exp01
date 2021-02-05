#' ---
#' title: labels standardization from Raven
#' author: lucas gaspar
#' date: 2020-03-20
#' Contact: lucas.pacciullio@unesp.br (Spatial Ecology and Conservation Lab - LEEC - UNESP Rio Claro-SP, Brazil)
#' ---

#install.packages("stringr")
library(stringr)
library(dplyr)
#directory
setwd("/home/gasparzinho/Documents/backpup/ANALISYS_2020_06_d01/00_scripts_gaspar_master/after_meet/aves/etiquetas/2020_09_d03_ETIQUETAS_aves/etiquetas_aves_final_2020_09_d11")

#list files for pattern
dir.txts.all<-dir(".", pattern=".txt$")
n.rec = length(dir.txts.all)
n.rec

head(dir.txts.all)

# Firstly, do a backup of all  .txt files!

# standardization of tags
for (i in dir.txts.all){
  xx = read.table(i, head=T, sep="\t", fill = TRUE, na.strings = c("NULL","NA"))           # read table
  colnames(xx) <- c("Selection","View","Channel","Begin.Time..s.","End.Time..s.","Low.Freq..Hz.",
                    "High.Freq..Hz.","species")                                            # colnames pattern
  xx$species <- tolower(xx$species)
  aux2<-xx[!duplicated(xx$Selection), ]                                                   # remove duplicate
  aux2[,2]<-"Spectrogram 1"                                                               #  change names of "view" columnn
  xx[,8] <- tolower(xx[,8])                                                                # lower case
  write.table(xx, file = file(basename(i)), sep="\t", na="NA", quote=FALSE, row.names = F, col.names= T) # save. Take care beacause this do modification in the original filesy  
} 

dir.txts.all<-dir(".", pattern=".txt$")
n.rec = length(dir.txts.all)
n.rec

head(dir.txts.all)


#found erros
TAB<-NULL
files.with.troubles<-NULL
files.with.diff.colnames<-NULL
cont<-0

dir.txts.all<-dir(".", pattern=".txt$")
n.rec = length(dir.txts.all)
n.rec

# found error
for (i in dir.txts.all){
  cont<- cont+1
  
  try(xx.tab<-read.table(i, head=T, sep="\t"))
  if (ncol(xx.tab)!=8 |  nrow(xx.tab)==0) {files.with.troubles<-c(files.with.troubles, i)} 
  
  if (ncol(xx.tab)==8)
  {
    if (nrow(xx.tab)>0)
    {
      xx.tab$filename<-i
      if (length(unique(colnames(xx.tab)!=colnames(TAB)))==2)
      {
        files.with.diff.colnames<-data.frame(rbind(cbind(colnames_errados=i),files.with.diff.colnames))
        colnames(xx.tab)<-colnames(TAB)
      }
      TAB<-data.frame(rbind(TAB, xx.tab))
    }
  }
}

#save   
write.csv2(TAB, "..//00_complete_info_TAB_all_tags_compilation.csv", sep="\t", na="NA", quote=FALSE, row.names = F, col.names= T)

# create table of tags compilation
lista.completa <- NULL
aux<-subset(TAB, select=c(filename, species)) 
TABB<-data.frame(rbind(lista.completa, aux))

TAB <- TABB
dim(TAB)
head(TAB)

write.csv2(TAB, "..//00_TAB_all_tags_compilation.csv", sep="\t", na="NA", quote=FALSE, row.names = F, col.names= T)

# creat troubles control
#TAB$species<-toupper(TAB[,2])
print(paste("Tinha", length(dir.txts.all), "Arquivos"))
print(paste("Foram lidos", cont, "Arquivos"))
print(paste("Desses", length(files.with.troubles), "ou n?o tinham dados, ou n?o tinham 8 colunas"))
print(paste("E foram observados", length(files.with.diff.colnames), "com nomes diferentes de colunas"))

#unlist(strsplit(TAB$filename, "_"))

# separate files names  # adpt here to your data
paisagem<-substr(TAB$filename,1,6) 
channel<-substr(TAB$filename,7,11)  
year<-substr(TAB$filename,12,15)  
month<-substr(TAB$filename,16,17)
day<-substr(TAB$filename,18,19)
hour<-substr(TAB$filename,21,22)
minutes<-substr(TAB$filename,23,24)
seconds<-substr(TAB$filename,25,26)
date<-substr(TAB$filename,12,19) 
time <- substr(TAB$filename, 21,26)
ambiente <- substr(TAB$filename, 28,29)

#create new coluns wich info
TAB$paisagem <- paisagem
TAB$horario <- time
TAB$data <- date
TAB$ambiente <- ambiente

# atualiza a tabela completa com as novas tags e salva em cima
TAB.juncao <- TAB %>% 
  dplyr::select(filename, species) %>% 
  dplyr::arrange(filename)

TAB.2 <- TAB %>% 
  dplyr::arrange(filename)
TAB.2$species <- TAB.juncao$species

write.csv2(TAB.2, "..//00_complete_info_TAB_all_tags_compilation.csv", sep="\t", na="NA", quote=FALSE, row.names = F, col.names= T)

#save
write.csv2(TAB.2, "..//001_tabela_etiquetas_2020_09_d03_FULL.csv", col.names=T, row.names=F, append=F, sep="\t", quote=F)
write.csv2(as.data.frame(files.with.troubles), "..//02_tabela_etiquetas_2020_09_d03_problemas.csv", col.names=T, row.names=F, append=F, sep="\t", quote=F)
write.csv2(as.data.frame(files.with.diff.colnames), "..//03_tabela_etiquetas_2020_09_d03_ColunasChecars.csv", col.names=T, row.names=F, append=F, sep="\t", quote=F)

colnames(TAB.juncao)
TAB.juncao <- TAB.2

TAB.juncao

#
complete.list <- subset(TAB.juncao, select=c(filename, species))
head(complete.list)

complete.list$presaus<-1

complete.list$species <- tolower(complete.list$species)

# matrix shape
complete.list.wide<-reshape(complete.list, v.names ="presaus", idvar = "filename",
                             timevar = "species", direction = "wide")

#remove presaus of name
colnames(complete.list.wide)<-gsub("presaus\\.", "", colnames(complete.list.wide))

#colnames(complete.list.wide)<-tolower(colnames(complete.list.wide))
complete.list.wide[is.na(complete.list.wide)]<-0

#prepar table for export
landscape.str<-substr(complete.list.wide$filename,1,6)
env.str<-substr(complete.list.wide$filename,28,29)
name.str<-substr(complete.list.wide$filename,1,29)

complete.list.wide$landscape <- landscape.str
complete.list.wide$env <- env.str
complete.list.wide$filename <-  name.str              
 
complete.list.wide[is.na(complete.list.wide)] <- 0

complete.list.wide$se <- rep(1:1, nrow(complete.list.wide))

colnames(complete.list.wide) 
complete.list.wide.sort <- complete.list.wide %>% 
  dplyr::select(filename, landscape, env, se, ni, ni1, ni2, ni3, everything()) 

sort(colnames(complete.list.wide.sort))
# save
write.csv2(complete.list.wide.sort, "..//00_matriz_wide_all_sounds_biodiversity.csv")

setwd("/home/gasparzinho/Documents/backpup/ANALISYS_2020_06_d01/00_scripts_gaspar_master/after_meet/aves/etiquetas/2020_09_d03_ETIQUETAS_aves")
dir()
# create matrix with only noises and other only species
ta <- read.csv2("00_matriz_wide_all_sounds_biodiversity.csv")
ta
colnames(ta)

# sort by names
ta_sort <- ta[,order(names(ta))]

colnames(ta_sort)

ta_sort_noises <- ta_sort %>% 
  dplyr::select(filename, antro_assobio_humano:antro_voz, biof_anuro_dendropsophus:biof_primata_callicebus_nigrifrons,geof_chuva:geof_vento_forte,
                ruido_ni, ruido_defundo )

# save noises table
write.csv2(ta_sort_noises, "00_matriz_wide_NOISES_biodiversity_morning.csv")

ta_sort_species <- ta_sort %>% 
  dplyr::select(filename, landscape, env, se, na, NA., ni, ni1, ni2, ni3, agel_cyan:anab_fusc, aram_caja:bata_cine, brot_chir:empi_vari, eupe_macr:eups_aure, flor_fusc:galb_rufi,
                gnor_chop:myrm_squa, pach_vali:scle_scan, serp_subc:vola_jaca,  xeno_ruti:zono_cape ) %>% 
  dplyr::select(-c(ruido_ni, ruido_defundo))
colnames(ta_sort_species)

# sum the NI
ta_sort_species_sum <- ta_sort_species %>% 
  dplyr::mutate(NI = rowSums(.[7:10])) %>% 
  dplyr::mutate(NAs = rowSums(.[5:6])) %>% 
  dplyr::select(filename, landscape, env, se, NAs, NI, agel_cyan:zono_cape)

colnames(ta_sort_species_sum )

# save species table
write.csv2(ta_sort_species_sum, "..//00_matriz_wide_SPECIES_biodiversity_morning.csv")

setwd("/home/gasparzinho/Documents/backpup/ANALISYS_2020_06_d01/00_scripts_gaspar_master/after_meet/aves/analises")
write.csv2(ta_sort_species_sum, "./00_matriz_wide_SPECIES_biodiversity_morning.csv")

# end ------------------------------------------------------------------------------------------------------------------

