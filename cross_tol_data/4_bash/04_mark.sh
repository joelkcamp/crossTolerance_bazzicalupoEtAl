#!/bin/bash

## use gatk4 to mark duplicate reads

gatk=/Linux/GATK4/./gatk
samtools=/Linux/bin/samtools
root=/ottolab/2022_YeastMetals

while read name; do
	$gatk MarkDuplicates \
		-I ${root}/03_sorted/${name}.sort.bam \
		-O ${root}/04_mark/${name}.sort.dedup.bam \
		-M ${root}/04_mark/log/${name}.duplicateinfo.txt
	$samtools index ${root}/04_mark/${name}.sort.dedup.bam
done < ${root}/samplelist.txt
