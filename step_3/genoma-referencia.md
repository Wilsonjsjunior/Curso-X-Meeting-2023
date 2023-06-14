# Download e preparação do genoma de referência

Espera-se que o BWA e samtools estejam instalados para criação dos indexes (senão, ver a instalação desses itens no README.md dessa mesma pasta.

## Faremso o download apenas dos cromossomos de interesse:

```bash
mkdir genome
cd genome
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr13.fa.gz
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr17.fa.gz
zcat chr13.fa.gz chr17.fa.gz > ucsc.chr13-chr17.fa
```

## Gerar arquivos de index do fasta e para o BWA

```bash
bwa index ucsc.chr13-chr17.fa
samtools faidx ucsc.chr13-chr17.fa
picard CreateSequenceDictionary R=ucsc.chr13-chr17.fa O=ucsc.chr13-chr17.dict
```

## Quais os contigs no genoma de referência e quantas linhas de DNA eles possuem?

```bash
grep '>' ucsc.chr13-chr17.fa
grep -v '>' ucsc.chr13-chr17.fa | wc -l
```
