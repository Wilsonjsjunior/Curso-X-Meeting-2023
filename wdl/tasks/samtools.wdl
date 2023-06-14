version 1.0

task SamToBam {
    input {
        File bam
        File refFasta
        File refFastaIndex
        String outputPrefix

        # An image with Perl is required to run seq_cache_populate.pl
        String dockerImage = "776722213159.dkr.ecr.us-east-1.amazonaws.com/samtools:1.11"
        Float memoryGib = 3
        Int threads = 1
        Int awsBatchRetryAttempts = 3
    }

    command <<<
        set -euxo pipefail

        samtools view \
            -C \
            --reference ~{refFasta} \
            --threads ~{threads} \
            -o ~{outputPrefix}.cram \
            ~{bam}

        # Use seq_cache_populate.pl to create a CRAM reference cache, then point to it
        # to create a REF_CACHE environment variable necessary to index the CRAM.
        seq_cache_populate.pl -root ./ref/cache ~{refFasta}
        export REF_PATH=:
        export REF_CACHE=./ref/cache/%2s/%2s/%s

        samtools index ~{outputPrefix}.cram

        md5sum ~{outputPrefix}.cram | awk '{print $1}' > ~{outputPrefix}.cram.md5
    >>>

    runtime {
        docker: dockerImage
        memory: memoryGib + " GiB"
        cpu: threads
        awsBatchRetryAttempts: awsBatchRetryAttempts
    }

    output {
        File cram = "~{outputPrefix}.cram"
        File cramIndex = "~{outputPrefix}.cram.crai"
        File cramChecksum = "~{outputPrefix}.cram.md5"
    }

    parameter_meta {
        # inputs
        bam: "BAM file to be converted to CRAM format."
        refFasta: "Reference in FASTA format."
        refFastaIndex: "Reference FASTA index."
        outputPrefix: "Prefix of output files."
        dockerImage: "Docker image with Samtools and seq_cache_populate.pl."
        memoryGib: "Memory in GiB allocated to this task. Default is 3."
        threads: "Number of threads allocated to this task. Default is 1."

        # outputs
        cram: "Output file in CRAM format."
        cramIndex: "Output CRAM index file."
        cramChecksum: "MD5 file storing the CRAM's checksum value."
    }
}