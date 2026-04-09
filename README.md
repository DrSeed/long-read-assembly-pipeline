# Long-Read Genome Assembly Pipeline

Oxford Nanopore genome assembly with Flye + Medaka polishing.

## Steps
1. NanoPlot read QC
2. Filtlong quality filtering
3. Flye assembly
4. Medaka polishing (Nanopore model)
5. Optional Pilon short-read polishing
6. QUAST assembly assessment
7. BUSCO completeness check

## Usage
```bash
bash assemble.sh reads.fastq.gz --genome-size 5m
```
