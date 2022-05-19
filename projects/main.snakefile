# This is a snakefile based on python
# For PADD-seq and Damage-seq
# written by Yin,Jiayong, modified by Zhu,Yongchang
# 2022-01-15


import os
pwd = os.getcwd()
TRIM_PATH = pwd + '/trim'

# loadConfig
include: "conf/config"

# load Samples-prefix
SAMPLES=[line.rstrip() for line in open("conf/sm.list")]


# main workflow

rule all:
	input:
		expand("{sample}.done",sample=SAMPLES)


rule cutadapt:
	input:
		"fastq/Sample_{sample}/{sample}_combined_R1.fastq.gz",
		"fastq/Sample_{sample}/{sample}_combined_R2.fastq.gz"
	output:
		cut1=temp("temp/{sample}_R1.fq"),
		cut2=temp("temp/{sample}_R2.fq")
	message:"cut adapter in 5'-end using cutadapt"
	log:
		"logs/trim/{sample}_cut.log"
	threads:0
	params:
		pair_mode='any'
	shell:
		"cutadapt -g {ADAPT1} --discard-trimmed --pair-filter={params.pair_mode} -j {threads} -o {output.cut1} -p {output.cut2} {input} 1>{log} 2>&1"


rule trim_galore:
	input:
		rules.cutadapt.output
	output:
		temp("trim/{sample}_R1_val_1.fq.gz"),
		temp("trim/{sample}_R2_val_2.fq.gz")
	message:"trim remains adapter using trim_galore"
	log:
		"logs/trim/{sample}_trim.log"
	threads:4
	shell:
		"trim_galore {input} --phred33 --gzip  -j {threads} --paired -o {TRIM_PATH}  1>{log} 2>&1"


rule bwa_map:
	input:
		rules.trim_galore.output
	output:
		temp("mapped/{sample}.bam")
	message:"mapping reads to genome using bwa"
	log:
		"logs/bwa/{sample}_map.log"
	threads:15
	shell:
		"bwa mem -t {threads} {hg38_INDEX_PATH} {input} | samtools view -Sb - > {output}"


rule sort_bam:
	input:
		rules.bwa_map.output
	output:
		temp("{sample}.sort.bam")
	params:15
	shell:
		"samtools sort -@ {params} -o {output} {input}"

rule markdup:
	input:
		rules.sort_bam.output
	output:
		"mapped/{sample}.markdup.bam"
	params:15
	shell:
		"sambamba markdup -t {params} {input} {output}"


rule index:
	input:
		rules.markdup.output
	output:
		"mapped/{sample}.markdup.bam.bai"
	shell:
		"samtools index {input}"



rule generate_bed:
	input:
		bam=rules.markdup.output,
		bai=rules.index.output
	output:
		bed="{sample}.bed",
		uniq="{sample}.uniqCount"
	message:"generate bed containing filtered reads info from bam"
	shell:
		"python {SCRIPTS}/generate_bed.py --ibam {input.bam} --fasta {hg38_FA} --bed {output.bed} --uniq {output.uniq}"



rule count_base:
	input:
		rules.generate_bed.output.bed
	output:
		"BaseCount/{sample}.baseCount.txt"
	message:"Stat base ratio within 10 bp"
	shell:
		"python {SCRIPTS}/count_base.py {input} {output}"

rule countDipyrimidine:
        input:
                rules.generate_bed.output.bed
        output:
                "BaseCount/{sample}.DipyrimidineRatio.txt"
        message:"Stat dipyrimidine ratio of damage site"
        shell:
                "python {SCRIPTS}/countDipyrimidine.py {input} {output}"


rule splitBed:
	input:
		rules.generate_bed.output.bed
	output:
		plus=temp("{sample}.plus.bed"),
		minus=temp("{sample}.minus.bed")
	shell:
		"python {SCRIPTS}/split_bed_by_strand.py {input} {output.plus} {output.minus}"


rule assignRead2gene:
	input:
		intxt1=rules.splitBed.output.plus,
		intxt2=rules.splitBed.output.minus
	output:
		pos1=temp("{sample}.plus.POS.tsv"),
		neg1=temp("{sample}.plus.NEG.tsv"),
		pos2=temp("{sample}.minus.POS.tsv"),
		neg2=temp("{sample}.minus.NEG.tsv")
	run:
		shell("python {SCRIPTS}/assignReadtoGene.py  --tssdat {TSSDAT} --intxt {input.intxt1} --posout {output.pos1} --negout {output.neg1} \
		--upstream {UPSTREAM} --downstream {DOWNSTREAM} ")
		shell("python {SCRIPTS}/assignReadtoGene.py  --tssdat {TSSDAT} --intxt {input.intxt2} --posout {output.pos2} --negout {output.neg2} \
		--upstream {UPSTREAM} --downstream {DOWNSTREAM} ")


rule readProfile:
	input:
		q=rules.assignRead2gene.output.neg1,
		w=rules.assignRead2gene.output.pos2,
		e=rules.assignRead2gene.output.pos1,
		t=rules.assignRead2gene.output.neg2,
		bgfile=rules.generate_bed.output.uniq
	output:
		value="{sample}.rawValue"
	shell:
		"python {SCRIPTS}/readProfile.py --t1 {input.q} --t2 {input.w} --nt1 {input.e} --nt2 {input.t} \
		--regionlength {REGION} --binSize {BINSIZE} --bgValue {input.bgfile} \
		--outRawvalue {output.value}"


rule done:
	input:
		rules.readProfile.output,
		rules.count_base.output,
		rules.countDipyrimidine.output
	output:
		touch("{sample}.done")
