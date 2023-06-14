# Rodando em WDL

WDL (pronuncia-se widdle) é uma linguagem de descrição de fluxo de trabalho para definir tarefas e fluxos de trabalho. O WDL visa descrever tarefas com comandos abstratos que possuem entradas e, uma vez definidas, permite que você as conecte para formar fluxos de trabalho complexos. Aprenda mais sobre WDL [aqui](https://geocarvalho.medium.com/introdu%C3%A7%C3%A3o-ao-wdl-parte-1-ba01cf179db2) e [aqui](https://github.com/openwdl/learn-wdl) e [aqui](https://github.com/orgs/biowdl/repositories?page=2).

## Instalando o [Cromwell](https://github.com/broadinstitute/cromwell)

CROMWELL é o mecanismo de execução (escrito em Java) que suporta a execução de scripts WDL em três tipos de plataformas: máquina local (por exemplo, seu laptop), um cluster/server local acessado por meio de um agendador de tarefas (por exemplo, Slurm, GridEngine) ou uma plataforma de cloud (por exemplo, Google Cloud ou Amazon AWS). [Aqui](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/) tem mais conteúdo.

### Mac

```bash
brew install cromwell
```

### Ubuntu [release](https://github.com/broadinstitute/cromwell/releases/tag/85)

```bash
cd ~
mkdir cromwell
cp ~/Downloads/cromwell-XY.jar cromwell/
cd cromwell/
```

## Rodando womtool para verificação

```bash
womtool validate task.wdl
```

## Criando imagens

 temo um grande acervo de imagens, mas você também pode encrontra-las no Dockerhub.