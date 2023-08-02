#!/bin/bash

## Sort the mapped sequences and index them according to the reference genome using samtools
## note that the -bh flag converts the sam files to binary and
## maintains the current header file. The samtools sort command 
## organises the file by coordinate. This loop sorts the files,
## and then index them

samtools=/Linux/bin/./samtools
root=/ottolab/2022_YeastMetals

while read name; do
	${samtools} view -bh \
	${root}/02_map/${name}.map.sam |
	${samtools} sort > ${root}/03_sorted/${name}.sort.bam
	${samtools} index ${root}/03_sorted/${name}.sort.bam
done < ${root}/samplelist.txt
