#!/bin/bash

## make text files with pileup command that will be used for coverage analysis

samtools=/Linux/bin/./samtools
root=/ottolab/2022_YeastMetals

while read name; do
	${samtools} mpileup -f \
	/ottolab/2022_YeastMetals/ref_genomes/reference1.fasta \
	${root}/03_sorted/${name}.sort.bam > ${root}/09_pileup/${name}.pileup.txt
done < ${root}/samplelist.txt
