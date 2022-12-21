#!/usr/bin/env bash

#SBATCH --account=wittelab
#SBATCH --partition=wittelab
#SBATCH --job-name=psa_prs
#SBATCH --mail-type=END,FAIL		
#SBATCH --mail-user=linda.kachuri@gmail.com	
#SBATCH --ntasks=4 
#SBATCH --mem=15gb	
#SBATCH --array=1-22
#SBATCH --time=250:00:00
#SBATCH --output=/wittelab/data3/lkachuri/PRScsx/logfiles/prsfit_%A_%a.log		

pwd; hostname; date

module load CBI WitteLab
module load plink2

genpath="/wittelab/data6/PSA_R01/PCPT_SELECT/imputed/SELECT"
path="/wittelab/data3/lkachuri/psa_meta"
outpath="$path/prs"
prs="/wittelab/data3/lkachuri/PRScsx/out/SELECT"

chr=$SLURM_ARRAY_TASK_ID
#chr=X

plink2 \
--vcf $genpath/chr$chr.merged.vcf.gz \
--score $prs/PSA.ukb_META_pst_eff_a1_b0.5_phi1e-04_allchr.txt 19 25 26 header-read list-variants ignore-dup-ids cols=+scoresums \
--hard-call-threshold 0.49999999 \
--memory 14500 \
--threads 4 \
--out $outpath/PRScsx/select.ukb.phi1e04.$chr

exit 0

[[ -n "$SLURM_JOB_ID" ]] && sstat -j "$SLURM_JOB_ID" --format="JobID,Elapsed,MaxRSS"
