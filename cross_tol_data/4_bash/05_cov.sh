#!/bin/bash

## measures the depth of the coverage

gatk=/Linux/GATK4/./gatk
root=/ottolab/2022_YeastMetals

while read name; do
	$gatk DepthOfCoverage \
	-R ${root}/ref_genomes/reference1.fasta \
	-O ${root}/05_cov/${name}.cov \
	-I ${root}/04_mark/${name}.sort.dedup.bam \
	-L ${root}/yeast_interval.list
done < ${root}/samplelist.txt
