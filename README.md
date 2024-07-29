**Welcome to the README for the PatchSeq preprocessing directory!**


In order to run any of the functions, you will need to be able to use Sherlock. See "Using Sherlock" on the Google drive for further details, but it is fairly simple. First, you will need Scott to email the Sherlock staff on your behalf to set up an account, after which you can login with your normal password using ssh <sunetid>@login.sherlock.stanford.edu. To run the scripts in this repository, you will use the command sbatch <script_name>.sbatch

Basic overview of steps:
1. Download genomes for alignment
2. Generate genome with annotations using **STAR**
3. FastQC and MultiQC for preliminary quality control (run_fastqc.sbatch)
4. Align sequencing data to reference genome using **STAR** 
5. Rerun multiQC to check STAR alignment

You should have everything you need to start at Step 4, as I have already generated genomes and done those preliminary steps which are agnostic to the particular dataset.

If you would like to start with Steps 1-3 (e.g., you want to add or update a reference genome from what is already on the server) see details below.

**Step 3**: To QC your particular dataset, in terminal after logging into Sherlock type the following commands followed by ENTER: 

```
cd /oak/stanford/groups/sfowen/Data/PatchSeqAlignment
nano run_fastqc.sbatch
```

This will allow you to view and edit run_fastqc.sbatch. Change the **dir** variable to the directory where your raw sequencing data is stored. Press CTRL+O ENTER to save and CTRL+X to exit. Then run:

`sbatch run_fastq.sbatch`

This script will look into the current directory and check if FastQC has already been run for a given sequencing file. If not, it runs FastQC. At the end, it runs multiQC to compile a readable report with all samples. 

**Step 4**: To align your sequencing data to the reference genome, run:
```
sbatch alignment.sbatch <SPECIES> <fastq_file1> <fastq_file2> <fastq_file3> ... <fastq_fileN>
```

Note, enter which species you are aligning the sequencing data to (e.g., mouse or human) as the first argument after the script, and then copy and past .fastq file names for the remaining arguments separated by a space. You can do as many as you want, but generally you can't run more than 10-20 in the timelimit of the script (24h). 

_Be sure to check the species of your sequencing data to ensure that you are aligning to the correct reference genome._ If you align incorrectly, your percent of mapped reads in QC reports will be very low (>10%).


