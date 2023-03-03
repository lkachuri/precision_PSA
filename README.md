# precision_PSA
This repository provides code for performing genetic adjustment of PSA levels and investigating the impact of PSA-related index event bias on genetic associations with prostate cancer, as described in:<br>
<br><b>Leveraging Genetic Determinants of Prostate-Specific Antigen Levels Towards Improving Prostate Cancer Screening</b> 
<br>Kachuri L, Hoffmann TJ, Jiang Y, Berndt SI, Shelley JP, Schaffer K, Machiela MJ, Freedman N, Huang WI, Li S, Easterlin R, Goodman PJ, Till C, Thompson I, Lilja H, Van Den Eeden SK, Chanock SJ, Haiman CA, Conti DV, Klein R, Mosley JD, Graff RE, Witte JS. (https://www.medrxiv.org/content/10.1101/2022.04.18.22273850v2) <br>
<br>
<b>Genetic Adjustment</b><br>
In order to perform genetic adjustment of PSA values, a polygenic score (PGS) for PSA must be fit in the target population. Once PGS values are available for each participant, genetic adjustment can be performed based on the mean PGS value in the target population, or based on the mean PGS value in an appropriate extermal reference population, as described in `psa_adjustment.R` 
<br>Scoring files for fitting PSA polygenic scores are available from the PGS Catalog: www.pgscatalog.org/score/PGS003378/ and www.pgscatalog.org/score/PGS003379/. Weights for the genome-wide PGS for PSA were estimated using PRS-CSx (https://github.com/getian107/PRScsx) using parameters specified in `prscsx_final.sh` GWAS summary statistics for estimating posterior SNP effect sizes are available from: https://doi.org/10.5281/zenodo.7460134
<br>
<br><b>Index Event Bias</b><br>
Analyses of index event bias, including estimation of the bias correction factor (b) and adjustment of genetic effects on prostate cancer are described in `index_event_bias.R`. Genetic associations with prostate cancer were obtained from the GWAS meta-analysis by Conti DV, Darst et al. <i>Nat Genet</i> 53, 65-75 (2021). Full GWAS summary statistics for prostate cancer are available via dbGaP. To illustrate the impact of bias correction, here we provide associations for 209 indepenent prostate cancer risk variants (merged_index_prca_209.txt) and a 269-variant PGS for prostate cancer (merged_pgs269_psa.txt).
