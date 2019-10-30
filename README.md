# Genomics England Clinical Interpretation Partnership Conference 04_Nov_2019

This repository will recreate the poster used at the first GECIP conference and provide the associated information required for reproducibility.

# Poster Production

The poster was created using the [posterdown](https://cran.r-project.org/web/packages/posterdown/index.html) package. To run, render the `Posterdown.Rmd` file. The output will be in html format. A PDF version is also provided in this repo. The libraries should automatically load or prompt for installation if they are not already installed.


# SEPATH Pipeline Parameters:

The [SEPATH](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1819-8) pipeline is available as a singularity on [github](https://github.com/UEA-Cancer-Genetics-Lab/sepath_tool_UEA).

This pipeline was ran on all cancer whole genome sequences (v6 release) from the 100,000 Genomes Project with the following parameters (all others parameters were as default):

`krakendb` - All genomes in [NCBI Refseq](https://www.ncbi.nlm.nih.gov/refseq/) scaffold level and above (bacterial, viral, fungal, protozoal). Dustmasked to remove low complexity. See [resources/names.dmp](resources/names.dmp) and [resources/nodes.dmp](resources/names.dmp) for taxonomy information. `database.kdb` MD5:`1e5bbafdef19775b6a9a9055598fb709` 

`kraken_confidence` - 0.2 - 20% of assigned _k_-mers within a read must assign to a taxonomy before classification can be determined

`min_clade_reads` - 0 - left unfiltered until analysis

`bbduk_db` - Human reference [genome 38](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.38/) (no decoys) with additional cancer sequences from the [COSMIC](https://cancer.sanger.ac.uk/cosmic/download) database

`minimum_quality` - 20 - in addition to quality control from Illumina

`minimum_length` -  35 - sufficient for _k_=31 runs with kraken. set low to preserve data


# Data Formatting

Sample metadata was accessed via the R labkey API in Genomics England Research Environment. Main programme data used was for v7 data release as of `2019-07-25`. Associated scripts for data cleaning and formatting can be provided to GeCIP members from within the research environment upon request.


# Principal Coordinates Analysis

Community matrix filtering:

* All samples were aligned to genome build GRCh38, passed Illumina internal QC, were obtained from fresh-frozen tissue and library prep was PCR-free
* Taxa within samples with less than 50 assigned sequencing reads were set to 0 to reduce false positives
* Converted to binary with `kraken_pa <- decostand(kraken_prep, method='pa')`

PCoA:

* Distance matrix obtained with `jacc <- vegdist(kraken_pa, method='jaccard', binary=TRUE)`
* Multidimensional scaling performed with `cmdscale(jacc, k=2, eig=TRUE, x.ret=TRUE)`
* vegan pacakge version: `2.5.3`
* Data points and principal MDS axes variance were extracted, remerged with metadata by sequencing plate_key and plotted with ggplot.

# Boruta Feature Selection

Scripts available from within research environment. Boruta settings required for reproducibility:

* R version: `3.5.1`
* Random seed setting: `set.seed(1122)`
* Boruta package: `6.0.0`
* Boruta Parameters: `maxRuns=500`. All other parameters as default

The importance decisions for each boruta run were extracted for each technical variable. The combined number of times a genus was confirmed as important for predicting a technical variable was ranked the the top 15 decisions were compared to table 1 in [Eisenhofer et al 2019](https://www.cell.com/trends/microbiology/fulltext/S0966-842X(18)30253-1). The resulting dataframe is provided in code of the poster markdown file.





