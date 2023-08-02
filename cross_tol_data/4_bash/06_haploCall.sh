#!/bin/bash

## a loop that uses GATK HaplotypeCaller to calling all germline indels and SNPs

gatk=/Linux/GATK4/./gatk
root=/ottolab/2022_YeastMetals
samtools=/Liunx/bin/samtools

## create a sequence dictionary and .fai file for the reference genome
$gatk CreateSequenceDictionary \
	-R ${root}/ref_genomes/reference1.fasta \
	-O ${root}/ref_genomes/reference1.dict

$samtools faidx ${root}/ref_genomes/reference1.fasta

while read name; do
	$gatk --java-options "-Xmx10g" HaplotypeCaller \
	-R ${root}/ref_genomes/reference1.fasta \
	-I /ottolab/2022_YeastMetals/04_mark/${name}.sort.dedup.bam \
	-O /ottolab/2022_YeastMetals/06_haploCall/${name}.g.vcf.gz \
	-ERC GVCF
done < /ottolab/2022_YeastMetals/samplelist.txt


