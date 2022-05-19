rule all:
	input:
		expand("fastq/dataQC/{sample}_combined_R{i}_fastqc.html",sample=SAMPLES,i=[1,2])


rule fastQC:
	input:
		"fastq/Sample_{sample}/{sample}_combined_R{i}.fastq.gz"
	output:
		"fastq/dataQC/{sample}_combined_R{i}_fastqc.html"
	threads:3
	params:
		"fastq/dataQC/"
	shell:
		"fastqc -o {params} --format=fastq --noextract -t {threads} -q {input}"


title=$(pwd|tr "/" "\t"|awk '{print $NF}')
multiqc -i $title -o ./fastqc/multiQC ./fastqc/dataQC
