#!/usr/bin/bash
#SBATCH --job-name=test_job
#SBATCH --output=test_job.%j.out
#SBATCH --error=test_job.%j.err
#SBATCH --time=04:00:00
#SBATCH -p normal
#SBATCH -c 1
#SBATCH --mem=64GB
GENOMEDIR='/oak/stanford/groups/sfowen/Data/PatchSeqAlignment/'
module load biology
module load star 

fname='genome.fna'
read_length=150 
overhang=$((read_length-1))
echo Running STAR with $overhang overhang

STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $GENOMEDIR --genomeFastaFiles $GENOMEDIR$fname --sjdbGTFfile ${GENOMEDIR}gencode.v36.annotation.gtf --sjdbOverhang $overhang

