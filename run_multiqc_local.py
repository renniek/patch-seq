#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 31 21:16:35 2024

@author: caper
"""
import sys
import multiqc

#multiqc.parse_logs(module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
 #  			path_filters=["*.trimmed_fastqc.zip"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
#	    	path_filters=["*1_fastqc.zip"]))],run_modules=['fastqc']) 
if len(sys.argv) > 1: 
	arg=sys.argv
	if len(sys.argv) == 2:
		multiqc.parse_logs(arg[1]+"*fastqc.zip",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_fastqc.zip"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_fastqc.zip"]))],run_modules=['fastqc'])
	if len(sys.argv) == 3:
		multiqc.parse_logs(arg[1]+"*fastqc.zip",arg[2]+"*fastqc.zip",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_fastqc.zip"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_fastqc.zip"]))],run_modules=['fastqc'])
	if len(sys.argv) == 4:
		multiqc.parse_logs(arg[1]+"*fastqc.zip",arg[2]+"*fastqc.zip",arg[3]+"*fastqc.zip",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_fastqc.zip"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_fastqc.zip"]))],run_modules=['fastqc'])

multiqc.write_report(force=True,output_dir="/Volumes/sfowen/Data/PatchSeqAlignment/fastqc_report",title="FastQC on Untrimmed and Trimmed Data",
   filename="fastqc_report.html")

multiqc.reset()


if len(sys.argv) > 1: 
	arg=sys.argv
	if len(sys.argv) == 2:
		multiqc.parse_logs(arg[1]+"*Log.final.out",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_Log.final.out"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_Log.final.out"]))],run_modules=['star'])
	if len(sys.argv) == 3:
		multiqc.parse_logs(arg[1]+"*Log.final.out",arg[2]+"*Log.final.out",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_Log.final.out"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_Log.final.out"]))],run_modules=['star'])
	if len(sys.argv) == 4:
		multiqc.parse_logs(arg[1]+"*Log.final.out",arg[2]+"*Log.final.out",arg[3]+"*Log.final.out",module_order=[dict(fastqc=dict(name="FastQC (trimmed)",anchor="fastqc_trimmed",
   			path_filters=["*.trimmed_Log.final.out"])),dict(fastqc=dict(name="FastQC (raw)",anchor="fastqc_raw",
	    	path_filters=["*1_Log.final.out"]))],run_modules=['star'])


multiqc.parse_logs(module_order=[dict(star=dict(name="STAR (trimmed)",anchor="star_trimmed",
path_filters=["*trimmed_Log.final.out"])),dict(star=dict(name="STAR (raw)",anchor="star_raw",
path_filters=["*1_Log.final.out"]))],run_modules=['star'])
                                                         
multiqc.write_report(force=True,output_dir="/Volumes/sfowen/Data/PatchSeqAlignment/STAR_alignment_report",title="STAR on Untrimmed and Trimmed Data",
   filename="star_report.html")

