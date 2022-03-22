library(data.table)
library(dplyr)

################################################
##### Main Analysis Using Dudbridge Method #####
################################################

library(indexevent)

# harmonized statistics for PSA (index trait) and prostate cancer (outcome trait)
# 127,909 SNPs with LD pruned at r2=0.10 MAF=0.05
bias.dat<-fread("merged_index_psa_prca.txt") # EUR
bias.dat<-fread()

# remove large effect sizes that could be overlyinfluential 
bias.dat<-bias.dat %>% filter(abs(beta.exposure)<0.20) # for PSA
bias.dat<-bias.dat %>% filter(abs(beta.outcome)<0.20)  # for prostate cancer

# Estimate bias correction factor using SIMEX
res.simex<-indexevent(xbeta=bias.dat$beta.exposure, xse=bias.dat$se.exposure,
                      ybeta=bias.dat$beta.outcome, yse=bias.dat$se.outcome,
                      weighted = T, prune = NULL, method = c("Simex"), B = 1500, seed = 123)
res.simex$b 
res.simex$b.se
res.simex$b.ci

# Estimate bias correction factor using Hedges-Olkin
res.ho<-indexevent(xbeta=bias.dat$beta.exposure, xse=bias.dat$se.exposure,
                   ybeta=bias.dat$beta.outcome, yse=bias.dat$se.outcome,
                   weighted = T, method = c("Hedges-Olkin"))
res.ho$b
res.ho$b.raw

##############################################
##### Apply Bias Correction to PRACTICAL #####
############################################## 

b=res.simex$b
b.se=res.simex$b.se

# harmonized summary statistics for 209 independent prostate cancer risk variants
prost.dat<-fread("merged_index_prca_209.txt")

prost.dat<-prost.dat %>% mutate(beta.outcome.adj = (beta.outcome - b*beta.exposure), 
                          se.outcome.adj=sqrt(se.outcome^2 + b^2*se.exposure^2 + b.se^2*beta.exposure^2 + b.se^2*se.exposure^2),
                          chisq.adj = (beta.outcome.adj/se.outcome.adj)^2,
                          pval.outcome.adj = pchisq(chisq.adj,1,lower=F))


# correct weights for prostate cancer risk score (PGS.269)

pgs.269<-fread("merged_pgs269_psa.txt")
b=res.simex$b
prs.269<-prs.269 %>% mutate(effect_weight.adj = (effect_weight - b*psa.effect))


##################################################
##### Sensitivity Analysis Using SlopeHunter #####
##################################################

library(SlopeHunter)

bias.dat<-as.data.frame(bias.dat)

# default: xp_thresh = 0.001
sh.model<-hunt(bias.dat, snp_col="MarkerName", xbeta_col="beta.exposure", xse_col="se.exposure",  xp_col = "pval.exposure",
               ybeta_col="beta.outcome", yse_col="se.outcome", yp_col="pval.outcome",
               xp_thresh=0.001, init_pi = 0.6, init_sigmaIP = 1e-5, Bootstrapping = TRUE, M = 1500, seed = 777,
               Plot=FALSE, show_adjustments = FALSE)

sh.model$b
sh.model$bse
sh.model$b_CI





