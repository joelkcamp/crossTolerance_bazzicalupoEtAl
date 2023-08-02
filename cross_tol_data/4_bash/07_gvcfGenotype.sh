#!/bin/bash

## create genomics databases for each of the yeast chromosomes

root=/ottolab/2022_YeastMetals
gatk=/Linux/GATK4/./gatk
bcf=/Linux/bin/bcftools

## construct a sample map of all the sequences to be added to the genomics database

for i in `ls ${root}/06_haploCall/*.g.vcf.gz | sed 's/\/ottolab\/2022_YeastMetals\/06_haploCall\///g' | sed 's/.g.vcf.gz//g' | sed 's/gvcf\///g'`
do
	echo -e "$i\t/ottolab/2022_YeastMetals/06_haploCall/$i.g.vcf.gz"
done > ${root}/07_genomicsDB/yeast_genomes.sample_map

## calls GenomicsDBImport for all of the yeast genome chromosomes on all samples
## designated on the sequence map

chr=("NC_001133" "NC_001134" "NC_001135" "NC_001136" "NC_001137" "NC_001138" "NC_001139" "NC_001140" "NC_001141" "NC_001142" "NC_001143" "NC_001144" "NC_001145" "NC_001146" "NC_001147" "NC_001148" "NC_001224")



for i in "${chr[@]}"
do 
	$gatk --java-options "-Xmx4g -Xms4g" GenomicsDBImport \
	--genomicsdb-workspace-path ${root}/07_genomicsDB/$i \
	--batch-size 110 \
	-L "ref|"$i"|" \
	--sample-name-map ${root}/07_genomicsDB/yeast_genomes.sample_map

	$gatk --java-options "-Xmx4g" GenotypeGVCFs \
	-R ${root}/ref_genomes/reference1.fasta \
	-V gendb://${root}/07_genomicsDB/$i \
	-O ${root}/07_genomicsDB/$i.vcf.gz
done

$bcf concat ${root}/07_genomicsDB/NC_*.vcf.gz \
	-O z > ${root}/07_genomicsDB/full_genome.vcf.gz

