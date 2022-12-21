#!/usr/bin/env bash

#SBATCH --account=wittelab
#SBATCH --partition=wittelab
#SBATCH --job-name=prscs
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=linda.kachuri@gmail.com
#SBATCH --ntasks=5
#SBATCH --array=22
#SBATCH --mem=14gb
#SBATCH --time=280:00:00
#SBATCH --output=/wittelab/data3/lkachuri/PRScsx/logfiles/PRScsx_%A_%a.log

pwd; hostname; date

path="/wittelab/data3/lkachuri/PRScsx"
ANC1="EUR"
ANC2="AFR"
ANC3="EAS"
ANC4="AMR"

chr=$SLURM_ARRAY_TASK_ID

# load packages
module load WitteLab metaxcan
# metaxcan virtual environment also works for PRS-CSx
source $ENV

python $path/PRScsx.py \
--ref_dir=$path/ref_data/ukbb \
--bim_prefix=$path/test_data/SELECT/select_1kg_hm3_${chr} \
--sst_file=$path/sumstats/PSA_PRScsx_${ANC1}.txt,$path/sumstats/PSA_PRScsx_${ANC2}.txt,$path/sumstats/PSA_PRScsx_${ANC3}.txt,$path/sumstats/PSA_PRScsx_${ANC4}.txt \
--n_gwas=85824,3509,3337,3098 \
--pop=${ANC1},${ANC2},${ANC3},${ANC4} \
--phi=0.0001 \
--out_dir=$path/out/SELECT \
--out_name=PSA.ukb \
--chrom=${chr} \
--meta=TRUE \
--seed=666 

# IMPORTANT: when you are done running
 deactivate
