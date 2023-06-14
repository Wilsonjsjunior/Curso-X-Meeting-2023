version 1.0

task FreeBayes {
    input {
        File reference
        File referenceIdx

        File? intervals

        String outputPrefix
        File bamFile
        File bamIdxFile

        String userString = "-4 -q 15 -F 0.03"

        Float memory = 12
        Int cpu = 1

        String outputFilename = outputPrefix + '.freebayes.vcf'

        String dockerImage = "776722213159.dkr.ecr.sa-east-1.amazonaws.com/freebayes:v1.3.2"
    }

  command <<<
      set -Eeuxo pipefail;
      test -f ~{bamIdxFile}
      freebayes \
          -f ~{reference} \
          ~{"-t " + intervals} \
          ~{bamFile} \
          ~{userString} \
          -v ~{outputFilename};
  >>>

  output {
      File vcfFile = "~{outputFilename}"
  }

  runtime {
      memory: memory + " GB"
      cpu: cpu
      docker: dockerImage
  }

  parameter_meta {
      reference: {description:"Reference sequence file.", category: "required"}
      referenceIdx: {description: "Reference sequence index (.fai).", category: "required"}
      intervals: {description: "One or more genomic intervals over which to operate.", category: "required"}
      bamFile: {description: "Sorted BAM file.", category: "required"}
      bamIdxFile: {description: "Sorted BAM index file.", category: "required"}
      outputFilename: {description: "VCF output file name Default is prefix + vcf.", category: "common"}
      userString: {description: "An optional parameter which allows the user to specify additions to the command line at run time.", category: "common"}
      memory: {description: "GB of RAM to use at runtime.", category: "advanced"}
      cpu: {description: "Number of CPUs to use at runtime.", category: "advanced"}
      dockerImage: {description: "Docker image for running the varcaller.", category: "advanced"}
  }
}
