#!/usr/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --output=fastqc.%j.out
#SBATCH --error=fastqc.%j.err
#SBATCH --time=01:00:00
#SBATCH -p normal
#SBATCH -c 1
#SBATCH --mem=16GB

module load biology
module load fastqc 
module load py-numpy/1.24.2_py39

for entry in *".fastq.gz"; do 
	if [ -f "${entry%%.*}_fastqc.html" ]
	then 
		echo "FastQC already run for "$entry". Skipping and moving on to next entry."
	else ##
		echo "Running FastQC for "$entry
		fastqc $entry -d . -o .
	fi
done

# activate virtual environment to compile fastqc files into a report using multiqc
export LD_LIBRARY_PATH=/share/software/user/open/python/3.9.0/lib
source /oak/stanford/groups/sfowen/Data/PatchSeqAlignment/RNA_seq/bin/activate 
#cd $dir
python /oak/stanford/groups/sfowen/Data/PatchSeqAlignment/run_multiqc.py



