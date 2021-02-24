##################################################################################
########################## Taxonomic identification using DADA2 ##################
##################################################################################
# R script prepared for the
# CCAP Algaculture for Biotechnology Training Course Programme (24-26 February 2021)
# compiled by David Green
####################################################################################

# For more information on DADA2, goto: https://benjjneb.github.io/dada2/tutorial.html
# Callahan, B. J., McMurdie, P. J., Rosen, M. J., Han, A. W., Johnson, A. J., & Holmes, S. P. (2016). 
# DADA2: High-resolution sample inference from Illumina amplicon data. Nat Methods, 13(7), 581-583. doi:10.1038/nmeth.3869

# This script uses curated database sources reformated by the DADA2 authors as sourced from:
# https://www.arb-silva.de --- SILVA; 
# Users from non-academic/commercial environments should have a look at the SILVA License Information (https://www.arb-silva.de/silva-license-information/)

# https://pr2-database.org --- PR2
# Guillou, L., Bachar, D., Audic, S., Bass, D., Berney, C., Bittner, L., Boutte, C. et al. 2013. The Protist Ribosomal Reference database (PR2): a catalog of unicellular eukaryote Small Sub-Unit rRNA sequences with curated taxonomy. Nucleic Acids Res. 41:D597–604.
# del Campo J., Kolisko M., Boscaro V., Santoferrara LF., Nenarokov S., Massana R., Guillou L., Simpson A., Berney C., de Vargas C., Brown MW., Keeling PJ., Wegener Parfrey L. 2018. EukRef: Phylogenetic curation of ribosomal RNA to enhance understanding of eukaryotic diversity and distribution. PLOS Biology 16:e2005849. DOI: 10.1371/journal.pbio.2005849.

# This is a modification of the full DADA2 metabarcoding pipeline featuring just taxonomic assigments.

### INSTRUCTIONS ###
# Format your sequences into a single multi-fasta file
# Make sure you have either R installed or have unix/cygwin command line available (and R installed)
# Note, that where ever your start the script from, will be where your output files will be saved.
# NB. The following examples assume you have navigated to the folder that contains your R script and fasta file.
### If using unix command line and Rscript is installed, you can do something like:
# $ Rscript Taxonomic_ID_with_Dada2.R asv_fasta.fa pr2 16s
# Where: pr2 or silva are the databases you want to use; 16S or 18S is what domain your SSU belongs to

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
if(!require(dada2, quietly=TRUE)) {BiocManager::install(c("Biostrings", "dada2"))}
if(!require(dplyr, quietly=TRUE)){ install.packages("dplyr") }
#packageVersion("dada2")
#packageVersion("dplyr")

# pull in arguments and set up config
args <- commandArgs(trailingOnly = TRUE)
if(length(args) < 3) { stop("Three arguments are required for taxonomic ID using this script:\n(1) Path and name to fasta file\n(2) Which database to use, SILVA or PR2\n(3) State if 16S or 18S.\n\nFor example type the following into your command line (not the $ sign): $ Rscript Taxonomic_ID_with_Dada2.R CCAP_fasta.fasta PR2 18S", call. = FALSE) }
FASTA <- args[1] # 
DB <- args[2] # either 'SILVA' or 'PR2' 
DB <- toupper(DB)
SSU <- args[3]
SSU <- toupper(SSU)
PATH <- "."
setwd(PATH)
if(!dir.exists("./output")) {
dir.create("./output", showWarnings=TRUE) }
if(!dir.exists("./db")) {
  dir.create("./db", showWarnings=TRUE) }

#### download tax training files
if ( DB == "SILVA") {
download.file("https://zenodo.org/record/3986799/files/silva_species_assignment_v138.fa.gz", 
              "./db/silva_species_assignment_v138.fa.gz") 
download.file("https://zenodo.org/record/3986799/files/silva_nr99_v138_train_set.fa.gz", 
              "./db/silva_nr99_v138_train_set.fa.gz")
  } else if (DB == "PR2") {
download.file("https://github.com/pr2database/pr2database/releases/download/v4.12.0/pr2_version_4.12.0_16S_dada2.fasta.gz", 
              "./db/pr2_version_4.12.0_16S_dada2.fasta.gz")
    download.file("https://github.com/pr2database/pr2database/releases/download/v4.12.0/pr2_version_4.12.0_18S_dada2.fasta.gz", 
                  "./db/pr2_version_4.12.0_18S_dada2.fasta.gz")
  } else { stop("You didn't enter a database name that was recognised. Please type either 'SILVA' or 'PR2' and restart the Rscript.", call. = FALSE) }

## Taxonomy assignment
# load fasta file into dada2
seqs <- Biostrings::readDNAStringSet(FASTA)
seq_names <- names(seqs)
#seqs <- getSequences(FASTA)
if(DB == "SILVA") {
print("Starting assignTaxonomy against SILVA db...be patient")
silvataxa <- assignTaxonomy(seqs, "./db/silva_nr99_v138_train_set.fa.gz", 
                       tryRC=TRUE, 
         #              outputBootstraps = TRUE,
                       multithread=TRUE) #<-- if running Windows, set to 'FALSE', but on Mac or unix, can change to the number of CPU you want, or all using TRUE.
print("Now assigning species names...be patient")
silvataxa <- addSpecies(silvataxa, "./db/silva_species_assignment_v138.fa.gz", 
                   tryRC=TRUE)
  saveRDS(silvataxa, "./output/silva_SSU_taxa.rds")
  taxa.print <- silvataxa %>% as_tibble() %>% cbind("ID" = seq_names) %>% select(ID, everything())
  write.table(taxa.print, "./output/SILVA_SSU_Taxa.tsv", sep = "\t", quote = FALSE, row.names = FALSE, col.names = TRUE)
} else if (DB == "PR2") {
  if(SSU == "16S") {
  print("Starting PR2 16s assignTaxonomy...be patient")
  pr2taxa16S <- assignTaxonomy(seqs, "./db/pr2_version_4.12.0_16S_dada2.fasta.gz", 
                            taxLevels = c("Kingdom","Supergroup","Division","Class","Order","Family","Genus","Species"),
                            tryRC=TRUE, 
         #                   outputBootstraps = TRUE,
                            multithread=TRUE)
  saveRDS(pr2taxa16S, "./output/pr2_16S_taxa.rds")
  taxa.print <- pr2taxa16S %>% as_tibble() %>% cbind("ID" = seq_names) %>% select(ID, everything())
  write.table(taxa.print, "./output/PR2_16S_Taxa.tsv", sep = "\t", quote = FALSE, row.names = FALSE, col.names = TRUE)
  } else if (SSU == "18S") {
    print("Starting PR2 18s assignTaxonomy...be patient")
  pr2taxa18S <- assignTaxonomy(seqs, "./db/pr2_version_4.12.0_18S_dada2.fasta.gz", 
                              taxLevels = c("Kingdom","Supergroup","Division","Class","Order","Family","Genus","Species"),
                              tryRC=TRUE, 
          #                    outputBootstraps = TRUE,
                              multithread=TRUE)
  saveRDS(pr2taxa18S, "./output/pr2_18S_taxa.rds")
  taxa.print <- pr2taxa18S %>% as_tibble() %>% cbind("ID" = seq_names) %>% select(ID, everything())
  write.table(taxa.print, "./output/PR2_18S_Taxa.tsv", sep = "\t", quote = FALSE, row.names = FALSE, col.names = TRUE )
    } 
}
# cleanup
cat("\n")
print(paste0("Taxaonomic assignments are in ", getwd(), "/output/...Taxa.tsv"))
rm(list = ls()) 
unlink("./db", recursive = TRUE, force = TRUE)
cat("\n")
print("Finished")
Sys.time()

     
