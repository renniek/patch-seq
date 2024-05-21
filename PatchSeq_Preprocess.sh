#!/bin/bash
dir='/Volumes/sfowen/Data/scRNA_Data/E200013499-SGSC-Owen-JC-22666/'

#conda activate RNA-seq

source /Users/caper/Desktop/Owen_PatchSeqAnalysis/venv.sh

for entry in $dir/*".fastq.gz"; do 
	if [ -f "${entry%%.*}_fastqc.html" ]
	then 
		echo "FastQC already run for "$entry". Skipping and moving on to next entry."
	else ##
		echo "Running FastQC for "$entry
		fastqc $entry -d . -o .
	fi
done