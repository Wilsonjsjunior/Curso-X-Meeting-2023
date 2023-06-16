# Análise da qualidade dos reads

## Instalando Fastqc

```bash
conda install -c bioconda fastqc
apt-get install fastqc
```

## Rodando o Fastq nos exemplos

Entre na pasta `step_2` crie os diretórios e rode o comando abaixo

```bash
mkdir FASTQC cutadapt
fastqc E100024251_L01_104.bwa.sortdup.bqsr.brca.1.fastq.gz --nogroup -o ./
fastqc E100024251_L01_104.bwa.sortdup.bqsr.brca.2.fastq.gz --nogroup -o ./
```

> Dúvidas sobre os argumentos usados, use o comando abaixo:

```bash
fastqc --help
```

**Caso a qualidade não esteja boa, use alguma das opções indicadas nos slides. No nosso caso não é preciso, mas abaixo temos um exemplo de comando para para o `cutadapt` excluindo reads no final da sequência com phred score abaixo de 20.**

```bash
conda install -c bioconda cutadapt
apt-get install cutadapt

cd ../cutadapt/
cutadapt -q 20 -o E100024251_L01_104.bwa.sortdup.bqsr.brca.1.trimmed.fastq.gz E100024251_L01_104.bwa.sortdup.bqsr.brca.1.fastq.gz
cutadapt -q 20 -o E100024251_L01_104.bwa.sortdup.bqsr.brca.2.trimmed.fastq.gz E100024251_L01_104.bwa.sortdup.bqsr.brca.2.fastq.gz
```

## Analisando o número de sequências no Fastq

```bash
gunzip -c E100024251_L01_104.bwa.sortdup.bqsr.brca.1.fastq.gz | echo "$((`wc -l` / 4))"
gunzip -c E100024251_L01_104.bwa.sortdup.bqsr.brca.2.fastq.gz | echo "$((`wc -l` / 4))"
```
