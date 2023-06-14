# Validação das variantes chamadas pelo Freebayes e/ou GATK utilizando [rtg-tools](https://github.com/RealTimeGenomics/rtg-tools)

## Fazer a instalação do rtg-tools

```bash
conda install -c bioconda rtgtools
```

## Baixando o VCF goldstandard da amostra NA12878

```bash
wget https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz
tabix -p vcf HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz
```

## Criando o arquivo sdf

```bash
rtg format -o reference/ucsc.chr13-chr17.sdf reference/ucsc.chr13-chr17.fa
```

rtg vcfeval -b rtgtools/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz --bed-regions ../brca.bed -c E100024251.brca.gatk.vcf.gz -o rtgtools/test2/ -t reference/ucsc.chr13-chr17.sdf/