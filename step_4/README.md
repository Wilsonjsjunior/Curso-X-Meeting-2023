# Chamada de variante utilizando o Freebayes

* Para realizar esse tutorial é necessário que o BED esteja formatado, para isso veja o tutorial `ucsc-arquivo-bed.md` nessa mesma pasta!

## Instalando o Freebayes

```bash
conda install -c bioconda freebayes
apt-get install freebayes
```

## Chamar variante usando o BAM resultante do tutorial da pasta `03_alinhamento`

```bash
freebayes -f ../03_alinhamento/genome/ucsc-chr13-chr17.hg19.fa --targets BRCA.bed  ../03_alinhamento/SAM-BAM/510-7-BRCA_S8.bam > 510-7-BRCA_S8.vcf
```

## A partir daqui é possível filtrar as variantes e em seguida anotar informações para sua interpretação

## *Opcional* - Vamos usar Vcftools para filtrar variantes com qualidade (phred-score) abaixo de 20

```bash
conda install -c bioconda vcftools
vcftools --vcf 510-7-BRCA_S8.vcf --minQ 20 --recode --recode-INFO-all --out 510-7-BRCA_S8_q20
```

> Para outros filtros, como por exemplo `--min-meanDP 10` que filtra fora regiões com profundidade abaixo de 10 , é recomendado analisar a [documentação](https://vcftools.github.io/man_latest.html)
