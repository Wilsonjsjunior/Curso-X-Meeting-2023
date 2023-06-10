# Download e preparação do genoma de referência

Espera-se que o BWA e samtools estejam instalados para criação dos indexes (senão, ver a instalação desses itens no README.md dessa mesma pasta.

## Para fazer download do genoma inteiro (incluindo seus contigs extras)

```bash
cd genome
wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/*'
ls chr* | xargs cat > ucsc.hg19.fa 
```

## Para esse tutorial só precisamos de chr13 e chr17, para facilitar é possível criar um novo arquivo com eles:

```bash
cd genome
for fasta in $(ls *.gz); do gunzip ${fasta}; done
ls chr* | xargs cat > ucsc-chr13-chr17.hg19.fa
```

## Gerar arquivos de index do fasta e para o BWA

```bash
bwa index -a bwtsw ucsc-chr13-chr17.hg19.fa
samtools faidx ucsc-chr13-chr17.hg19.fa
```

## Quais os contigs no genoma de referência e quantas linhas de DNA eles possuem?

```bash
grep '>' ucsc-chr13-chr17.hg19.fa
grep -v '>' ucsc-chr13-chr17.hg19.fa | wc -l
```