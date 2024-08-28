#!/usr/bin/bash
#SBATCH --job-name=alignment
#SBATCH --output=alignment.%j.out
#SBATCH --error=alignment.%j.err
#SBATCH --time=24:00:00
#SBATCH -p normal
#SBATCH -c 20
#SBATCH --mem=64GB
species=$1
GENOMEDIR='/oak/stanford/groups/sfowen/Data/PatchSeqAlignment/'$species'_genome_processing/'

module load biology
module load star 
module load py-numpy

arr="${@:2}" # input fastq files (exclude first keyword entry, which is the species)
for R1_read in "${arr[@]}"
do
	idx=$((${#R1_read}-15)) 
	samp_name=${R1_read:0:$idx} #extract sample name 
	R2_read=$samp_name"R2_001.fastq.gz"
	echo Fitting for $samp_name. Aligning $R1_read and $R2_read
	STAR --runThreadN 16 --genomeDir $GENOMEDIR --readFilesIn $R1_read $R2_read --outFileNamePrefix $samp_name --readFilesCommand zcat --outSAMtype BAM Unsorted --quantTranscriptomeBan Singleend --outFilterType BySJout --alignSJoverhangMin 8 --outFilterMultimapNmax 20 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --quantMode TranscriptomeSAM --outSAMattributes NH HI AS NM MD #& 
done
