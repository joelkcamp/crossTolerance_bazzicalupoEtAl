Folder contents:

'figures' Folder
	- .jpg and .pdf format images of three figures
	- 'GO_tree_final_plain' has GO term hierarchical tree, manually drawn in Google Slides
		~ All terms have 3 or more genes and p<0.001 from Overrepresentation test (Fisher’s exact test)
		~ White circles are terms with p<0.001, but FDR>0.05. Color circles have terms with FDR<0.05, and the darker the color the smaller the pval
		~ Size of circle denotes how many genes in our mutation list fit into that term
		~ NOTE: The term “phosphotransferase activity, alcohol group as acceptor” has been shortened to “phosphotransferase activity”
	- 'GO_tree_final_withbroadcrosstol' has the same image as described above, but includes additional information
		~ All terms with a border have p<0.01, but none have FDR<0.05 
		~ Thick border denotes terms that were overrepresented in lines scoring above the 75th percentile for broad cross tolerance score
		~ Dashed border denotes terms that were overrepresented in lines scoring below the 25th percentile for broad cross tolerance score
		~ Thick/dashed border denotes terms that were overrepresented in both groups
	- 'distr_effects_figure' has output from ggplot in snpEff_PDBupdate.Rmd
		~ boxes separating by GO category were added in Google Slides

'spreadsheets_for_supplement' Folder
	- 'GO_tree_info_final.xlsx' has output from wrangled data in GO_analysis_PDBupdate.Rmd
		~ The overrepresentation test was performed on genes from all evolved lines, except Mn42 and Mn14
		~ All terms have 3 or more genes and p<0.001, sorted by FDR
		~ Column descriptions:
			* Ref_num - Number of genes in the whole genome that map to that term
			* List_num - Number of genes in our mutation set that map to that term
			* expected - This is calculated by dividing Ref_num by 6060 (total num yeast genes), and multiplying that by 208 (total number of genes in our mutation set)
			* pval - p from Fisher's exact test
			* FDR - FDR calculated by the program
			* [GO category]_DESC - the name of the term
			* circle size - size to make circle object in GO term hierarchical tree Google Slides
				determined in 'circle_size' sheet by matching min/max of number genes and feasible circle sizes to fit in the Google Slides
			* hex code - color to make circle object in GO term hierarchical tree Google Slides
				determined by making ggplot graphs with gradient (FDR 0-0.05) and using ColorPick Eyedropper extension in Google Chrome to get hex codes of points
	- 'overrep_broad_crosstol_final.xlsx' has the analysis of GO terms important for broad cross-tolerance
		~ Overrepresentation tests were performed on two gene lists
			* genes from lines with broadest cross tolerance: scoring above the 75th percentile
			* genes from lines with narrowest cross tolerance: scoring below the 25th percentile
		~ All terms have p<0.01, sorted by pval
		~ Column descriptions:
			* GO - the code used for that term in PDB
			* over_under - '+' indicates the term is more common than expected, '-' indicates the term is less common than expected
			* fold_enrich - calculated by dividing 'List' by 'expected'
	- 'overrep_by_metal.xlsx' has the analysis of GO terms important in each metal
		~ Overrepresentation tests were performed on six gene lists, those with mutations in each of the six metals
		~ All terms have p<0.05, sorted by pval

.txt files required for loading into Rmarkdown workflow
	- 'pantherGeneList_final.txt' has the raw output from PANTHERdb's mapping of genes to GO terms
		~ required for GO_analysis_PDBupdate.Rmd
	- 'all_[GO category]_Overrepresentation.txt' has the raw outputs from the overrepresentation tests run on genes from all evolved lines
		~ required for GO_analysis_PDBupdate.Rmd
	- 'pantherTerm_geneLists' is a folder of files with gene lists for terms that were not included in the mapping for "pantherGeneList_final.txt"
		~ It seems that the "Functional classification viewed in gene list" option used to produce "pantherGeneList_final.txt" only includes mapping of child terms
		~ Acquired by: In Overrepresentation test result page, clicking on 'List_num' value for a given term will redirect to a page with the genes mapped to that term. The output from this page is the file in this folder
		~ required for GO_analysis_PDBupdate.Rmd
		
Rmarkdown files
	- GO_analysis_PDBupdate.Rmd
		~ requirements listed above
	- snpEff_PDBupdate.Rmd
		~ requires 'snpsFINAL.tsv'
		~ requires the following output files from GO_analysis_PDBupdate.Rmd
			* '[GO category]PDB_long.csv'

