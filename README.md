# DATA BASE - Visualization and categorization of ecological acoustic events based on discriminant features

## soundscape_CCM1_exp01

This repository presents all data base used in Hilasaca et al. (2021), published on [Ecological Indicators](https://www.sciencedirect.com/science/article/pii/S1470160X20312589?dgcid=rss_sd_all)  DOI 10.1016/j.ecolind.2020.107316. 

# Data collect

The region under study hosts the Long-Term Ecological Research project in the Ecological Corridor of Cantareira-Mantiqueira (LTER-CCM or Pesquisa Ecológica de Longa Duração-PELD CCM in Portuguese), localized in the transition between northeastern São Paulo state and south Minas Gerais state - Brazil.

<p align="center"> 
<img width="550" src="/soundscape_CCM1_exp01/images/ajust_map_Liz_2021_01_d05_500dpi.png">
</p> 

# Experimental design and sound recordings

We have collected sound data in 22 landscapes, which varied in forest cover (16% to 86%) and spatial heterogeneity levels. In each landscape, we set up autonomous audio recorders Song Meter Digital Field Recorders (SM3) (Wildlife Acoustics, Inc., Massachusetts), which were fixed on trees at 1.5 m above ground. Three sites with different environment types were sampled within each landscape: forest, pasture and swamps. The equipment used two omni-directional microphones (frequency between 20 Hz and 20 kHz), and sounds were recorded at 44.1 kHz with 16 bits, in ”mono” mode.

# Audio set and species labeling 

The dataset comprised 2,277 sound files of one-minute each, divided into three classes: 615 for frogs, 822 for birds and 840 for insects. However, for the experiments, a total of four new data partitions were created: (a) DS1 (frogs, birds and insect), with 2,277 instances (minutes-files); (b) DS2 (frogs and birds), with 1,437 instances (minutes-files); (c) DS3 (frogs and insects), with 1,455 instances (minutes-files); and (d) DS4 (birds and insects), with 1,662 instances.

We also included a spreadsheet with extracted tags and characteristics and R.script used analysis. The minutes were labeled considering only the presence of acoustic signals of these three groups of species. For birds and anurans, every minute with presence of acoustic signal has been labeled as ”bird occurrence” or ”frog occurrence”. However, for insects, only minutes with predominance of insect vocalizations were labeled as “insect occurrence”. The management of the audio recordings was performed in the free programming environment R (R Core Team, 2018); labeling was done using the acoustic analysis software Raven Pro 1.5.

# Citation

Hilasaca, L. H., Gaspar, L. P., Ribeiro, M. C. & Minghim, R. (2021). Soundscape_CCM1_exp01 a acosutic data set with features and labels to visualization and categorization of ecological acoustic events. DOI zenodo CRIAR

# Contact

+ Liz Maribel Huancapaza Hilasa <lizhh@usp.br>
+ Lucas Pacciullio Gaspar <lucas.pacciullio@unesp.br>
+ Milton Cezar Ribeiro <mcr@rc.unesp.br>
+ Rosane Minghim <rosane.minghim@ucc.ie>  
