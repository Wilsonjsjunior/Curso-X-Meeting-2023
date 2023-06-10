# Tutorial simplificado para alinhamento

* Primeiramente organize o genoma de referência que será utilizado (caso não, veja o tutorial "genoma-referencia.md" nessa mesma pasta)

## Instalar BWA e Samtools;

```bash
conda install -c bioconda bwa samtools -y
apt-get install samtools bwa
```

## Crie a pasta `sam-bam` e de lá rode o BWA para alinhar os FASTQs e criar o arquivo SAM;

```bash
mkdir SAM-BAM && cd SAM-BAM
bwa mem -t 2 -R "@RG\tID:510-7\tSM:510-7\tPL:Illumina\tPU:unit1\tLB:lib1" ../../03_alinhamento/genome/ucsc-chr13-chr17.hg19.fa ../../00_dados/510-7-BRCA_S8_L001_R1_001.fastq.gz ../../00_dados/510-7-BRCA_S8_L001_R2_001.fastq.gz > 510-7-BRCA_S8.sam
```

> Existem vários alinhadores, para diferentes propósitos. Se quiser saber mais sobre eles [clique aqui](https://en.wikibooks.org/wiki/Next_Generation_Sequencing_(NGS)/Alignment)

## Transformar um arquivo SAM para BAM usando `samtools`, seguido pela indexação do arquivo;

```bash
samtools sort 510-7-BRCA_S8.sam > 510-7-BRCA_S8.bam
samtools index 510-7-BRCA_S8.bam
```

## Alinhando com um único comando sem criar arquivo SAM e passando os resultados diretamente para o arquivo BAM;

```bash
bwa mem -t 2 -R "@RG\tID:510-7\tSM:510-7\tPL:Illumina\tPU:unit1\tLB:lib1" ../../03_alinhamento/genome/ucsc-chr13-chr17.hg19.fa ../../00_dados/510-7-BRCA_S8_L001_R1_001.fastq.gz ../../00_dados/510-7-BRCA_S8_L001_R2_001.fastq.gz | samtools sort > 510-7-BRCA_S8.bam && samtools index 510-7-BRCA_S8.bam
```

## Instalar o IGV para visualizar o BAM, abra o programa e selecione os arquivos (BAM, BED, VCF) que irá analisar

```bash
conda install -c bioconda igv
igv
```

**Analisar a região `chr17:41222948` por exemplo**

> Durante o curso surgiu a dúvida do que seriam as sequências marcadas de vermelho e azul, [explicação aqui](https://software.broadinstitute.org/software/igv/interpreting_insert_size)

## Sem o IGV é possível saber métricas do BAM usando o `samtools`

* Quantas reads na reguião de interesse?
 
```bash
samtools view 510-7-BRCA_S8.bam chr17:41197694-41197819 | wc -l
```

* Quantas reads não foram mapeadas?

```bash
samtools view  510-7-BRCA_S8.bam | cut -f6 | grep '*' | wc -l
```
