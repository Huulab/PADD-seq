# Codes for PADD-seq
This repository stores original codes used in ***Genome-wide mapping of protein-DNA damage interaction by PADD-seq***.

## Software Requiremnents

## Linux Tools
+ snakemake >= 5.5.4
+ FastQC >= 0.11.9
+ bgzip >= 1.9
+ Cutadapt >= 1.12
+ trim_galore >= 0.6.7
+ samtools >= 1.9
+ bwa >= 0.7.17
+ sambamba >= 0.8.1
+ bedtools >= 2.30.0
+ deeptools >= 3.5.1

## Python
+ Pyhton version >= 3.7.x
+ numpy >= 1.19.2
+ pandas >= 1.1.2
+ py2bit >= 0.3.0
+ re >= 2.2.1
+ pyfaidx >= 0.5.9.1
+ pysam >= 0.16.0.1

## R
+ R version >= 3.6.1
+ ggplot2 >= 3.3.0
+ stringr >= 1.4.0


---

# Workflow Example

## 1. Quality Check and Alignment
You can download the raw sequencing data from [GEO](https://www.ncbi.nlm.nih.gov/geo/) under GSE**** to `projects/fastq/`.

run `projects/fastq/Check.sh` and get `projects/fastq/check.log` to verify the integrity of downloaded files.

Download the reference genome and build a reference genome index for the alignment program (bwa). 

Edit the `projects/conf/config`, and replace the `hg38_FA`, `hg38_INDEX_PATH` variables with the path of your reference genome and reference genome index, respectively. Replace the `TSSDAT` variable with the path of `Tssdat.txt` file in `projects/conf/`. Replace the `UPSTREAM`, `DOWNSTREAM` variables with distance upstream of the reference-point selected

The data structure of  is shown below:
| Gene ID | Chromasome | Reference-point site | Strand | Notes (optional) |
| :---: | :---: | :---: | :---: | :---: |
| ENSG00000173193 | chr3 | 122680839 | + | 50001 |
| ENSG00000112335 | chr6 | 108261246 | - | 50024 |

run `projects/start.sh` to perform Alignment.





