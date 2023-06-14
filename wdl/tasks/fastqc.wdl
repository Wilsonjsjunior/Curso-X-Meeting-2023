version 1.0

task FastQC {

    input {
        File unmapped
        String dockerImage = "776722213159.dkr.ecr.sa-east-1.amazonaws.com/fastqc:v0.11.9"
        Int awsBatchRetryAttempts = 3
    }

    String htmlFileName = basename(unmapped) + "_fastqc.html"
    String zippedFileName = basename(unmapped) + "_fastqc.zip"

    command <<<
        set -euxo pipefail

        fastqc \
            --outdir . \
            --noextract \
            ~{unmapped}

        mv *_fastqc.html ~{htmlFileName}
        mv *_fastqc.zip ~{zippedFileName}
    >>>

    runtime {
        docker: dockerImage
        awsBatchRetryAttempts: awsBatchRetryAttempts
    }

    output {
        File htmlFile = htmlFileName
        File zippedFile = zippedFileName
    }
}