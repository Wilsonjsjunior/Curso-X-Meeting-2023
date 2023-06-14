# Chamada de variante utilizando o Freebayes e o GATK

* Para realizar esse tutorial é necessário que o BED esteja formatado, para isso veja o tutorial `ucsc-arquivo-bed.md` nessa mesma pasta!

## Instalando o Freebayes

```bash
conda install -c bioconda freebayes gatk4
apt-get install freebayes
```

## Chamar variante usando o BAM resultante do tutorial com o freebayes

```bash
freebayes -f reference/ucsc.chr13-chr17.fa --targets BRCA.bed E100024251.brca.bam > E100024251.brca.freebayes.vcf
```

## Chamar variante usando o BAM resultante do tutorial com o GATK

```bash
gatk --java-options "-Xmx12g" HaplotypeCaller --sample-ploidy 2 --input E100024251.brca.bam \
--output E100024251.brca.gatk.vcf \
--reference reference/ucsc.chr13-chr17.fa --bam-output E100024251.brca.bamout.bam
```

## A partir daqui é possível filtrar as variantes e em seguida anotar informações para sua interpretação

## *Opcional* - Vamos usar Vcftools para filtrar variantes com qualidade (phred-score) abaixo de 20

```bash
conda install -c bioconda vcftools
vcftools --vcf file.vcf --minQ 20 --recode --recode-INFO-all --out file.q20.vcf
```

> Para outros filtros, como por exemplo `--min-meanDP 10` que filtra fora regiões com profundidade abaixo de 10 , é recomendado analisar a [documentação](https://vcftools.github.io/man_latest.html)

## Analisando o arquivo [VCF](https://gatk.broadinstitute.org/hc/en-us/articles/360035531692-VCF-Variant-Call-Format)

**GT**
O genótipo desta amostra neste local.

```bash
- 0/0 : a amostra é homozigótica em relação a referência
- 0/1 : a amostra é heterozigota, carregando 1 cópia de cada um dos alelos REF e ALT
- 1/1 : a amostra é homozigótica alternativa
```

**AD** and **DP**
AD é a profundidade do alelo não filtrado, ou seja, o número de leituras que suportam cada um dos alelos relatados.
DP é a profundidade filtrada, no nível da amostra.

**PL**
Probabilidades em escala Phred "normalizadas" dos genótipos possíveis.

**GQ**
A qualidade do genótipo representa a confiança em escala Phred de que a atribuição do genótipo (GT) está correta, derivada dos PLs do genótipo.

## Exemplo

```bash
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  E100024251
chr13   32916919        .       T       G       37.32   .       [CLIPPED]      GT:AD:DP:GQ:PL      1/1:0,2:2:6:49,6,0
```

```bash
20  10001019    .   T   G   364.77  .   [CLIPPED]   GT:AD:DP:GQ:PL  0/1:18,15:33:99:393,0,480
```

## Para calcular o VAF

Usaremos o valores de AD e DP:

```bash
AD = 8,4 
DP = 12
VAF = 4/12
```

Nesse caso o VAF será de 0,33 para um alelo ALT e VAF = 0,66 para o alelo REF. Podemos concluir que os valores sugerem que o indivíduo e HET.
