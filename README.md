# Bioinformatics Gateway Test Examples

F. De Boever & D. Green


All files used in this tutorial are accessible via [github/FDBoever/CCAP_Course_2021](github/FDBoever/CCAP_Course_2021)



## Introduction

### What is this course about?

This tutorial is meant as a guide for obtaining and using sequence data from our [sequence collection](...) to build and visualise phylogenetic trees using freely available online tools. This is not a course on the [theory of phylogenetics](https://www.ebi.ac.uk/training/online/courses/introduction-to-phylogenetics/what-is-phylogenetics/), nor is it designed for more advanced phylogenetic analysis. Instead, the aim of this tutrial is to show a quick-and-easy, yet, powerful approach to build and beautify robust phylogenetic trees based on SSU rDNA sequences.

### What will you achieve?

* Download SSU sequences and associated metadata from the CCAP sequence collection
* Align SSU sequences using Silva
* Build phylogenetic trees using IQ-TREE
* Visualise and annotate phylogenetic trees


### What is required
 * internet browser
 * patience
 * tool to unpack .zip files


<br>
 
## Step 1: Download SSU sequences and associated metadata
To build molecular phylogenies, we need a gene that is present in all organisms we want to relate. Owing to it's ubiquity, the small-subunit (SSU) rDNA sequence has been proposed as a phylogenetic marker to infer universal relatedness of all life (Carl Woese, 1977), and since became the most popular marker to study relatedness and diveristy of prokaryotes (16S) and eukaryotes (18S). Thanks to it's populatirity, and continuous advances in sequenceing technologies, the SSU rDNA gene has been routenely sequenced from both cultured organisms as well as environmental samples, covering the enormous taxonomic diversity of life. 

At CCAP, there is a continuous effort to "barcode" the entire culture collection with a focus on the rDNA operon. Moreover, researches around the globe continue to sequence DNA from CCAP strains, resulting in a growing amount of data that is often difficult to find, or link back to the organisms and it's metadata. To facilitate the use of sequence data associated with the CCAP culture collection, we recently developed an in-house sequence database that is publically accessible via a [website](http://vallarta:3838/test-ccap-app/#!/). Its aim is to provide a central platform that allows users to browse and access CCAP-associated sequences, meta-data and common analysis results.

In this tutorial, we will browse and download sequence data from the website, and show-case it's usage by building  phylogenetic trees. In this step you will obtain a fasta file with the sequences to build a tree, and a CSV file that will be useful to annotate the tree later on.



### Procedure

 * Go to [CCAPs' bioinformatics Gateway](http://vallarta:3838/test-ccap-app/)
 * Search for "Nannochloropsis" 
 * Click on the `CSV` and `FASTA` (Ref SSU Sequences) download buttons on the top of the screen, as indicated in the image below
 * Save the files somewhere sensible on your computer


![sq](/Users/sa01fd/Desktop/Screenshot 2021-02-18 at 20.43.38.png)
<br>


 



## Step 2: Align SSU sequences using Silva
Although we have now obtained a number of homologous 18S sequences, they may vary in length and composition. Prior to infering evolutionary relationships between sequenes, we need to identify homologous sites in these sequences, by  generating sequence alignments. Due to evolution (substitutions, insertions/deletions), sequence errors and analysis errors, it is often not trivial to know when the same site in two different sequences is homologous. Many tools exist for aligning multiple sequences (muscle, mafft, clustalw, t-coffee, ...), some of which can include information of the molecule's secondary structure to help assign homologous sites. A widely used method for aligning SSU/LSU sequences is the [Silva-algignment tool](https://www.arb-silva.de/aligner/), which uses structural information and a manually curated super-alignment to align a set of input sequences. 

### Procedure

 * Go to [https://www.arb-silva.de/aligner/](https://www.arb-silva.de/aligner/)
 * paste your the content of your fasta file inside the text field or click "select file"
 * you can leave the default settings and click the `Run Tool` button.
 * this job may take a minute to compute, you can follow it's progress in the `Alignment Taskmanager`
 
  
<br>
![silva1](/Users/sa01fd/Downloads/Screenshot 2021-02-16 at 11.27.00.png)



 * Once finished to click on the job in the `Alignment Taskmanager`
 * To download the sequence alignments click on `Download File` and chose zip 
 
<br>
![silva2](/Users/sa01fd/Desktop/Screenshot 2021-02-19 at 17.58.50.png)

Great, you now aligned your 18S sequences! It is always advised to inspect your  alignments before continuing to build a tree. 


 * Consider to explore the alignment using `wasabi` or other free-tools such as   [aliview](https://ormbunkar.se/aliview/)

![silva3](/Users/sa01fd/Desktop/Screenshot 2021-02-16 at 11.29.07.png)



## Step 3: Build phylogeny using IQ-TREE

Now that we are reasonably confident about our identification of homologous characters across our sequences (e.g. the alignment), we can build a phylogenetic tree. A variety of very distinct and often complex algorithm (Parsimony, Maximum-likelihood, Bayesian) exist, and resulting trees are often clouded by uncertainty of certain branching patterns expressed in likelihoods and probabilities. Although phylogenetics often appears like a dark art, these methods share the goal to find a tree that best explains the character data according to evolutionary process and an optimality criterion. In essense many possible trees are compared and the tree with the best value wins, representing the single "best" phylogeny. For example, one such optimality criterion is Maximum-likelihood, where the tree that maximising the likelihood of observing the character matrix and a given model of character evolution wins.

We will use [IQ-tree](https://doi.org/10.1093/nar/gkw256), an excelent and well maintained platform for phylogenetic analysis (notable alternatives are PAUP, Phylip, RAxML for Maximim-likelihood, PAUP, TNT for parsimony and PhyloBayes, MrBayes for Bayesian inference). We will use the alignment obtained in previous step.


### Procedure

 * Go to [IQ-TREE web server](http://iqtree.cibiv.univie.ac.at/)
 * upload your alignment file by clicking "Bowse..." in the Input Data section
 * We can specify Sequence type as DNA and leave the rest at the default settings.
 * If you want to explore alternative settings, or manually specify the substicution model, and or bootstrap method.
 * The more sequences you input the longer the computation time, so consider inputting your email adress at the bottom of the screen before submitting the job.
 * submit and wait until the job is finished.


![iqtree](/Users/sa01fd/Desktop/Screenshot 2021-02-19 at 20.02.12.png)


 * Once completed, download and unzip the files
 * your tree is stored in a file with extention .treefile 
 
 
<br>


## Step 4: Visualise and annotate phylogenetic trees

Infomation associated with taxon may be analysed in the context of the evolutionary history, for example trees can be annotated using metadata, such as isolation source,... vislualising organisms isolation source

### iTOL

[iTOL](https://itol.embl.de/)

you can upload your tree on the 

 * go to [iTOL website](https://itol.embl.de/upload.cgi)
 * you can drag and drop your tree file, or select it from you browser



### FigTree

[FigTree](http://tree.bio.ed.ac.uk/software/figtree/)


### R

ggtree, with great tutorials ([ggtree-book](https://guangchuangyu.github.io/ggtree-book/)) 

<br>
<br>
<br>
<br>

# Things to consider

## Blast against CCAP sequence database

we have implemented a blast search function onIf you have a sequence of your organism of interest, and want to know if CCAP holds similar strains

Sequence obtained from NCBI [https://www.ncbi.nlm.nih.gov/nuccore/KT860962](https://www.ncbi.nlm.nih.gov/nuccore/KT860962)
or copy the sequence below


```sh
>KT860962.1 Nannochloropsis sp. RCC8 18S ribosomal RNA gene, partial sequence
ATGGCTCATTATATCAGTTATAGTTTATTTGATAGTCCTTTACTACTTGGATAACCGTAGTAATTCTAGA
GCTAATACATGCATCAACTCCCAACCGCTCGACGGACGGGATGTATTTATTAGATAGAAACCAATGCGGG
GCAACCCGGTATTGTGGTGAATCATGATAACTTTGCGGATCGCCGGCTTCGGCCAGCGACGAATCATTCA
AGTTTCTGCCCTATCAGCTTTGGATGGTAGGGTATTGGCCTACCATGGCTCTAACGGGTAACGGAGAATT
GGGGTTCGATTCCGGAGAGGGAGCCTGAGAGACGGCTACCACATCCAAGGAAGGCAGCAGGCGCGTAAAT
TACCCAATCCTGACACAGGGAGGTAGTGACAATAAATAACAATGCCGGGGTTTAACTCTGGCAATTGGAA
TGAGAACAATTTAAATCCCTTATCGAGGATCAATTGGAGGGCAAGTCTGGTGCCAGCAGCCGCGGTAATT
CCAGCTCCAATAGCGTATACTAAAGTTGTTGCAGTTAAAAAGCTCGTAGTTGGATTTCTGGCAGGGACGG
CTGGTCGGTTCCGATAAGGGGCCGTACTGTTGTTTGTTCCTGTCATCCTTGGGGAGAGCGATTCTGGCAT
TAAGTTGTTGGGGTCGGGATCCCTATCTTTTACTGTGAAAAAATTAGAGTGTTCAAAGCAGGCTTAGGCC
CTGAATACATTAGCATGGAATAATAAGATACGACCTTGGTGGTCTATTTTGTTGGTTTGCACGCCAAGGT
AATGATTAATAGGGATAGTTGGGGGTATTCGTATTCAATTGTCAGAGGTGAAATTCTTGGATTTATGGAA
GACGAACTACTGCGAAAGCATTTACCAAGGATGTTTTCATTAATCAAGAACGAAAGTTAGGGGATCGAAG
ATGATTAGATACCATCGTAGTCTTAACCATAAACTATGCCGACTAGGGATCGGTGGGTGCATTTTAAGGC
CCCATCGGCACCTTATGAGAAATCAAAGTCTTTGGGTTCCGGGGGGAGTATGGTCGCAAGGCTGAAACTT
AAAGAAATTGACGGAAGGGCACCACCAGGAGTGGAGCCTGCGGCTTAATTTGACTCAACACGGGGAAACT
TACCAGGTCCAGACATAGTAAGGATTGACAGATTGAGAGCTCTTTCTTGATTCTATGGGTGGTGGTGCAT
GGCCGTTCTTAGTTGGTGGAGTGATTTGTCTGGTTAATTCCGTTAACGAACGAGACCCC
```

Go to the web-page, click tools > BLAST
paste the sequence of interest in the textbox, and click BLAST




