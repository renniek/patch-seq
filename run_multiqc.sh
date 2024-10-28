#!/usr/bin/bash

inputs=("$@")
# activate virtual environment to compile fastqc files into a report using multiqc
#export LD_LIBRARY_PATH=/share/software/user/open/python/3.9.0/lib
#source /Volumes/sfowen/Data/PatchSeqAlignment/RNA_seq/bin/activate 
python /Volumes/sfowen/Data/PatchSeqAlignment/run_multiqc_local.py "${inputs[@]}"

