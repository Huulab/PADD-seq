#!/bin/bash
# pre_run snakefile

snakefile=$1
cores=$2
mainpath=$(pwd)
title=$($mainpath|tr "/" "\t"|awk '{print $NF}')

# set default cores
if [ ! $cores ];then
	cores=1
fi

if [[ -e ${mainpath}/${snakefile} ]] && [[ -n ${snakefile} ]]
then
	echo "$(date "+%Y-%m-%d %H:%M:%S")  Start run: using $cores cores."
	mkdir fastqc/dataQC
	# dry-run
	snakemake -np -s $snakefile
	printf "\n\n\n\n\n\n\n\n\n\n\n"
	# output pipeline svg
	snakemake -s $snakefile --dag|dot -Tsvg > ${snakefile}.svg
	# run
	snakemake -s $snakefile -j $cores --latency-wait 30
	multiqc -i $title -o ./fastqc/multiQC ./fastqc/dataQC
	echo "$(date "+%Y-%m-%d %H:%M:%S")  Snake Done."

	if [ -e ${mainpath}/trim ];then
		rm -r ./trim
	fi

	if [ -e ${mainpath}/temp ];then
		rm -r ./temp
	fi

elif [ ! -e ${mainpath}/${snakefile} ]
then
	echo "Input snakefile is not exist."
else
	echo "Usage: bash main.sh <snakefile> <cores> ."
fi
