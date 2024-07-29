#!/usr/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --output=fastqc.%j.out
#SBATCH --error=fastqc.%j.err
#SBATCH --time=01:00:00
#SBATCH -p normal
#SBATCH -c 1
#SBATCH --mem=16GB

dir='/oak/stanford/groups/sfowen/Data/scRNA_Data/E200013499-SGSC-Owen-JC-22666/'
module load biology
module load fastqc 

for entry in $dir/*".fastq.gz"; do 
	if [ -f "${entry%%.*}_fastqc.html" ]
	then 
		echo "FastQC already run for "$entry". Skipping and moving on to next entry."
	else ##
		echo "Running FastQC for "$entry
		fastqc $entry -d . -o .
	fi
done

# activate virtual environment to compile fastqc files into a report using multiqc
source RNA_seq/bin/activate 

multiqc .



