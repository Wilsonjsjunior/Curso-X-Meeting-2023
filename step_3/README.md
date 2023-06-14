# Tutorial simplificado para alinhamento

* Primeiramente vamos organizar o genoma de referência que será utilizado (caso não, veja o tutorial "genoma-referencia.md" nessa mesma pasta)

## Instalar BWA e Samtools;

```bash
conda install -c bioconda bwa samtools -y
apt-get install samtools bwa
```

## Crie a pasta `bam` e de lá rode o BWA para alinhar os FASTQs e criar o arquivo SAM;

```bash
mkdir bam && cd bam
bwa mem -t 10 -R "@RG\tID:E100024251\tSM:E100024251\tPL:MGI\tPU:unit1\tLB:lib1" reference/ucsc.chr13-chr17.fa E100024251_L01_104.bwa.sortdup.bqsr.brca.1.trimmed.fastq.gz E100024251_L01_104.bwa.sortdup.bqsr.brca.2.trimmed.fastq.gz > E100024251.brca.sam
```

> Existem vários alinhadores, para diferentes propósitos. Se quiser saber mais sobre eles [clique aqui](https://en.wikibooks.org/wiki/Next_Generation_Sequencing_(NGS)/Alignment)

## Transformar um arquivo SAM para BAM usando `samtools`, seguido pela indexação do arquivo;

```bash
samtools sort E100024251.brca.sam > E100024251.brca.bam
samtools index E100024251.brca.bam
```

## Alinhando com um único comando sem criar arquivo SAM e passando os resultados diretamente para o arquivo BAM;

```bash
bwa mem -t 10 -R "@RG\tID:E100024251\tSM:E100024251\tPL:MGI\tPU:unit1\tLB:lib1" reference/ucsc.chr13-chr17.fa E100024251_L01_104.bwa.sortdup.bqsr.brca.1.trimmed.fastq.gz E100024251_L01_104.bwa.sortdup.bqsr.brca.2.trimmed.fastq.gz | samtools sort > E100024251.brca.bam && samtools index E100024251.brca.bam
```

## Instalar o IGV para visualizar o BAM, abra o programa e selecione os arquivos (BAM, BED, VCF) que irá analisar

```bash
conda install -c bioconda igv
igv
```

**Analisar a região `chr13:32889630` por exemplo**

> Durante o curso surgiu a dúvida do que seriam as sequências marcadas de vermelho e azul, [explicação aqui](https://software.broadinstitute.org/software/igv/interpreting_insert_size)

## Sem o IGV é possível saber métricas do BAM usando o `samtools`

* Quantas reads na reguião de interesse?
 
```bash
samtools view E100024251.brca.bam chr13:32889616-32973809 | wc -l
```

* Quantas reads não foram mapeadas?

```bash
samtools view E100024251.brca.bam | cut -f6 | grep '*' | wc -l
```
