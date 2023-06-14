version 1.0

task MarkDuplicates {
    input {
        Array[File] bams
        String outputPrefix
        String? readNameRegex
        Float? sortingCollectionSizeRatio
        Int compressionLevel = 2
        String dockerImage = "picard:2.23.8"
        Float memoryGib = 7.5
        Int awsBatchRetryAttempts = 3
    }

    Int javaMemorySizeGb = ceil(memoryGib - 2)

    command <<<
        set -euxo pipefail

        java -Dsamjdk.compression_level=~{compressionLevel} -Xms~{javaMemorySizeGb}g -jar /usr/picard/picard.jar \
            MarkDuplicates \
            --INPUT ~{sep=" --INPUT " bams} \
            --ADD_PG_TAG_TO_READS false \
            --ASSUME_SORT_ORDER "queryname" \
            --CLEAR_DT "false" \
            --METRICS_FILE ~{outputPrefix}.duplicate_metrics.txt \
            --OPTICAL_DUPLICATE_PIXEL_DISTANCE 2500 \
            ~{"--READ_NAME_REGEX " + readNameRegex} \
            ~{"--SORTING_COLLECTION_SIZE_RATIO " + sortingCollectionSizeRatio} \
            --VALIDATION_STRINGENCY SILENT \
            --OUTPUT ~{outputPrefix}.duplicates_marked.bam
    >>>

    runtime {
        docker: dockerImage
        memory: memoryGib + " GiB"
        awsBatchRetryAttempts: awsBatchRetryAttempts
    }

    output {
        File dupMarkedBam = "~{outputPrefix}.duplicates_marked.bam"
        File duplicateMetrics = "~{outputPrefix}.duplicate_metrics.txt"
    }

    parameter_meta {
        # inputs
        bams: "Array of SAM or BAM files."
        outputPrefix: "Prefix of output files."
        readNameRegex: "Regular expression used to parse read names in the input."
        sortingCollectionSizeRatio: "Value to add to the JVM RAM to define the memory footprint used by some sorting collections."
        compressionLevel: "Compression level for all compressed files created. Default is 2."
        dockerImage: "Docker image with Picard."
        memoryGib: "Memory in GiB allocated to this task. Default is 7."
        awsBatchRetryAttempts: "Retry attempts in case the task fails."

        # outputs
        dupMarkedBam: "Merged BAM with duplicate reads marked."
        duplicateMetrics: "File with duplication metrics."
    }
}