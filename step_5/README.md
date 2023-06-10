# Anotação das variantes chamadas pelo Freebayes utilizando [SnpEff](http://snpeff.sourceforge.net/SnpEff_manual.html#cmdline)

## Fazer a instalação do SnpEff, além dele também é necessário ter o java jdk instalado.

```bash
conda install -c bioconda snpeff
conda install -c cyclus java-jdk
```

## Fazer download das anotações referentes ao genoma GRCh37

```bash
java -jar snpEff/snpEff.jar download GRCh37.75
```

> Para saber mais sobre os bancos disponíveis:

```bash
java -jar snpEff/snpEff.jar databases | grep GRCh37
```

> Ignorar o código a partir do pipe se quiser ver tudo disponível

## Rodar o SnpEff

```bash
java -jar snpEff/snpEff.jar -Xmx4G -spliceSiteSize 10 -v GRCh37.75 ../04_chamada-de-variante/510-7-BRCA_S8.vcf > 510-7-BRCA_S8.anno.vcf
```

> O parâmetro `-spliceSiteSize 10` identifica as regiões +10 e -10 como sendo regiões de splicing.
> Ficar de olho na memória requerida, isso pode acarretar erro ao rodar e não ter memória suficiente para que funcione.

## Opcional - Para anotar outros bancos de dados é preciso usar o SnpSift

```bash
conda install -c bioconda snpsift
```

> Ver o [manual](http://snpeff.sourceforge.net/SnpSift.html#intro) caso queira anotar preditores, bancos de frequência populacional, intervalos de interesse, etc.

## Interpretação

* Nós visualizamos duas variantes:
  1. chr13:32906729 (hg19) - NM_000059.3(BRCA2):c.1114A>C(p.Asn372His) - [Benigna no Clinvar](https://www.ncbi.nlm.nih.gov/clinvar/RCV000009916.7/) - [análise da ACMG disponível no VarSome](https://varsome.com/variant/hg19/NM_000059.3(BRCA2)%3Ac.1114A%3EC)
  2. chr17:41222948 (hg19) - NM_007294.3(BRCA1):c.4964_4982del19 (p.Ser1655Tyrfs) - [Patogênica no Clinvar](https://www.ncbi.nlm.nih.gov/clinvar/variation/37616/) - [Artigo de evidência](https://link.springer.com/article/10.1007/s13167-010-0037-y)