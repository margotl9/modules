#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FASTQ_GENOME_CONTAINMENT_MASH } from '../../../../subworkflows/nf-core/fastq_genome_containment_mash/main.nf'

workflow test_fastq_genome_containment_mash {
    
    input = [
        [id:'test', single_end: false] 
        [
            file(params.test_data['sarscov2']['illumina']['test_1_fastq_gz'], checkIfExists: true),
            file(params.test_data['sarscov2']['illumina']['test_2_fastq_gz'], checkIfExists: true)
        ]
    ]

    FASTQ_GENOME_CONTAINMENT_MASH ( input )
}
