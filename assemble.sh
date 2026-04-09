#!/bin/bash
set -euo pipefail
READS=$1; GSIZE=${3:-5m}
OUTDIR=assembly_results
mkdir -p ${OUTDIR}

# QC
NanoPlot --fastq ${READS} -o ${OUTDIR}/nanoplot -t 8

# Filter
filtlong --min_length 1000 --keep_percent 90 ${READS} | gzip > ${OUTDIR}/filtered.fastq.gz

# Assemble
flye --nano-hq ${OUTDIR}/filtered.fastq.gz --out-dir ${OUTDIR}/flye --genome-size ${GSIZE} --threads 16

# Polish
medaka_polish -i ${OUTDIR}/filtered.fastq.gz -d ${OUTDIR}/flye/assembly.fasta -o ${OUTDIR}/medaka -t 8

# QC
quast ${OUTDIR}/medaka/consensus.fasta -o ${OUTDIR}/quast
busco -i ${OUTDIR}/medaka/consensus.fasta -o ${OUTDIR}/busco -m genome --auto-lineage

echo 'Assembly complete.'
