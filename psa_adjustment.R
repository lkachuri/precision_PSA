library(data.table)
library(dplyr)

#######################################
####### PSA Genetic Correction ########
#######################################

data<-fread("psa_example.txt")

data<-data %>% mutate(PGS.exp=exp(PGS), # back-transform if PGS was calculated using weights for increase in log(PSA)
                      PGS.ref=exp(mean(PGS)), # obtain population mean of PSA PGS 
                      #PGS.ref=300, # or substitute value calculated in a different population
                      adj=(PGS.exp/PGS.ref), # calculate adjustment factor for each individual
                      psa.adj=(psa/adj)) # obtain adjusted PSA value in ng/mL
