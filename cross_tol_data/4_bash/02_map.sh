#!/bin/bash

## reference genome indexing

/Linux/bin/./bwa-0.7.15 index \
/ottolab/2022_YeastMetals/ref_genomes/reference1.fasta

## paired end read sequence alignment to the reference genome
## note that the “-t 4” flag just indicates the number of threads
## to use, in order to not take up a large portion of the
## cluster’s computing power

bwa=/Linux/bin/bwa-0.7.15
clean=/ottolab/2022_YeastMetals/01_cleaned
while read name; do
	$bwa mem -R "@RG\tID:${name}\tSM:${name}\tPL:illumina\tLB:yeast_mel" \
	/ottolab/2022_YeastMetals/ref_genomes/reference1.fasta \
	$clean/${name}_R1_001.fastq.gz \
	$clean/${name}_R2_001.fastq.gz \
	-t 4 > /ottolab/2022_YeastMetals/02_map/${name}.map.sam;
done < /ottolab/2022_YeastMetals/samplelist.txt

