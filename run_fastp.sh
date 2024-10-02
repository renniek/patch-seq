#!/bin/bash
R1_read=$1
R1_read=$1
R2_read=`echo $R1_read | sed 's/R1/R2/'`


#export LD_LIBRARY_PATH=/share/software/user/open/python/3.9.0/lib
source /Volumes/sfowen/Data/PatchSeqAlignment/RNA_seq/bin/activate 

# check if there is an existing trimmed sample and clear, so that 
# multiqc will run on the new trimmed 


idx=$((${#R1_read}-9)) 
samp_name=${R1_read:0:$idx} #extract sample name 
if [ -f "${samp_name}.trimmed_fastqc.html" ]; then
	rm "${samp_name}.trimmed_fastqc.html"
	echo "Removing existing FASTQC trimmed results."
fi

if [[ $R1_read =~ (.*)R1 ]]; then samp_name="${BASH_REMATCH[1]}";       fi

# NOTE: right now I am trimming the first 10 reads, based on what I saw in FastQC
fastp -i $R1_read -I  $R2_read -o ${samp_name}R1_001.trimmed.fastq.gz -O ${samp_name}R2_001.trimmed.fastq.gz --detect_adapter_for_pe -l 25 -j ${samp_name}trimmed.fastp.json -h ${samp_name}trimmed.fastp.html --trim_front1 20 --trim_front2 20
