**Welcome to the README for the PatchSeq preprocessing directory!**


In order to run any of the functions, you will need to be able to use Sherlock. See "Using Sherlock" on the Google drive for further details, but it is fairly simple. First, you will need Scott to email the Sherlock staff on your behalf to set up an account, after which you can login with your normal password using ssh <sunetid>@login.sherlock.stanford.edu. To run the scripts in this repository, you will use the command sbatch <script_name>.sbatch

Basic overview of steps:
1. Download genomes for alignment
2. Generate genome with annotations using **STAR**
3. FastQC and MultiQC for preliminary quality control (run_fastqc.sbatch)
4. Adapter trimming with **fastp**. 
5. Align sequencing data to reference genome using **STAR** 
6. Rerun multiQC to check STAR alignment

You should have everything you need to start at Step 4, as I have already generated genomes and done those preliminary steps which are agnostic to the particular dataset.

If you would like to start with Steps 1-3 (e.g., you want to add or update a reference genome from what is already on the server) see details below.

**Step 3**: To QC your particular dataset, in terminal after logging into Sherlock type the following commands followed by ENTER: 

```
cd /oak/stanford/groups/sfowen/Data/scRNA_Data/<your_particular_directory> 
sbatch /oak/stanford/groups/sfowen/Data/PatchSeqAlignment/run_fastqc.sbatch
```

This script will look into the current directory and check if FastQC has already been run for a given sequencing file. If not, it runs FastQC. At the end, it runs multiQC to compile a readable report with all samples. 

**Step 4**
One quality control step after running FastQC/MultiQC is adapter trimming. This detects if sequencing adapters have been mistakenly incorporated into a read. If you see in a report that a given sample is contaminated by adapters, e.g., sample_X then do the following (not on the Oak server, but on your local computer - unfortunately I have not found a way to run this package on Oak): 

```
cd /Volumes/sfowen/Data/scRNA_Data/<your_particular_directory>
bash /Volumes/sfowen/Data/PatchSeqAlignment/run_fastp.sh <sample_X_R1>.fastq.gz
```
This script will automatically trim both R1 and R2 reads, and then save them as <sample_X_R1>.trimmed.fastq.gz and <sample_X_R2>.trimmed.fastq.gz

Note that you will want to rerun fastqc.sbatch for the trimmed sample to make sure that the trimming removed the adapter contamination, for example. To do this, run: 

**Step 5**: To align your sequencing data to the reference genome, run:

```
cd /oak/stanford/groups/sfowen/Data/scRNA_Data/<your_particular_directory>
sbatch /oak/stanford/groups/sfowen/Data/PatchSeqAlignment/alignment.sbatch <SPECIES> <sample_1_R1>.fastq.gz <sample_2_R1>.fastq.gz <sample_3_R1>.fastq.gz ... <sample_N_R1>.fastq.gz
```

Note, enter which species you are aligning the sequencing data to (e.g., mouse or human) as the first argument after the script, and then copy and past **R1** .fastq file names for the remaining arguments separated by a space. It is important that you put the R1 file name, as the script will automatically find the paired R2 read. You can do as many as you want, but generally you can't run more than 10-20 in the timelimit of the script (24h). 

_Be sure to check the species of your sequencing data to ensure that you are aligning to the correct reference genome._ If you align incorrectly, your percent of mapped reads in QC reports will be very low (<10%).

If you used fastp to trim reads based on some issue (e.g., adaptor contamination), make sure to input the correct fastq file name, or **.trimmed**.fastq.gz. 

https://multiqc.info/docs/usage/scripts/#writing-report

