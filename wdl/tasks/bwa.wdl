version 1.0

task BwaMem {
    input {
        File read1
        File? read2
        BwaIndex bwaIndex
        String outputPrefix
        Int sortMemoryPerThreadGb = 2
        Int compressionLevel = 1

        String? readgroup
        Int? sortThreads

        Int threads = 4
        Int? memoryGb
        String dockerImage = "bwa:version"
    }

    Int estimatedSortThreads = if threads == 1 then 1 else 1 + ceil(threads / 4.0)
    Int totalSortThreads = select_first([sortThreads, estimatedSortThreads])
    Int estimatedMemoryGb = 4 

    command {
        set -e
        mkdir -p "$(dirname ~{outputPrefix})"
        bwa mem \
          -t ~{threads} \
          ~{"-R '" + readgroup}~{true="'" false="" defined(readgroup)} \
          ~{bwaIndex.fastaFile} \
          ~{read1} \
          ~{read2} \
          2> ~{outputPrefix}.log.bwamem | \
          samtools sort \
          ~{"-@ " + totalSortThreads} \
          -m ~{sortMemoryPerThreadGb}G \
          -l ~{compressionLevel} \
          - \
          -o ~{outputPrefix}.aln.bam
          samtools index  ~{outputPrefix}.aln.bam
    }

    output {
        File outputBam = outputPrefix + ".aln.bam"
        File outputBai = outputPrefix + ".aln.bam.bai"
    }

    runtime {
        cpu: threads
        memory: "~{select_first([memoryGb, estimatedMemoryGb])}G"
        docker: dockerImage
    }

    parameter_meta {
        # inputs
        read1: {description: "The first-end fastq file.", category: "required"}
        read2: {description: "The second-end fastq file.", category: "common"}
        bwaIndex: {description: "The BWA index, including (optionally) a .alt file.", category: "required"}
        outputPrefix: {description: "The prefix of the output files, including any parent directories.", category: "required"}
        sortMemoryPerThreadGb: {description: "The amount of memory for each sorting thread in gigabytes.", category: "advanced"}
        compressionLevel: {description: "The compression level of the output BAM.", category: "advanced"}
        readgroup: {description: "A readgroup identifier.", category: "common"}
        sortThreads: {description: "The number of threads to use for sorting.", category: "advanced"}
        threads: {description: "The number of threads to use for alignment.", category: "advanced"}
        memoryGb: {description: "The amount of memory this job will use in gigabytes.", category: "advanced"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}

        # outputs
        outputBam: {description: "The produced BAM file."}
    }
}

struct BwaIndex {
    File fastaFile
    Array[File] indexFiles
}
