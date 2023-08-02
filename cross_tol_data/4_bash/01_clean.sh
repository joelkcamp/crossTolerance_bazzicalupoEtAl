#!/bin/bash

## trimming low quality bases and illumina adapters
## LEADING:20 trims leading bases with a quality score below 20, and 
## any N bases
## TRAILING:20 trims trailing bases with a quality score below 20, and
## any N bases
## MINLEN:36 drops reads below 36 bases long
## note that these settings are the default recommendation of 
## Trimmomatic and may need to be adjusted

root=/ottolab/2022_YeastMetals
cutadapt=/Linux/bin/cutadapt

while read name; do
	$cutadapt -a CTGTCTCTTATACACATCT -A AGATGTGTATAAGAGACAG \
	-o ${root}/01_clean/${name}_R1_001.fastq.gz \
       	-p ${root}/01_clean/${name}_R2_001.fastq.gz \
  	${root}/mel_fastq/${name}_R1_001.fastq.gz \
	${root}/mel_fastq/${name}_R2_001.fastq.gz
done < /ottolab/2022_YeastMetals/samplelist.txt
