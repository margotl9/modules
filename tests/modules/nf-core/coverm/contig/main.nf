#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { COVERM_CONTIG } from '../../../../../modules/nf-core/coverm/contig/main.nf'

workflow test_coverm_contig {
    
    input = Channel.of(
        [
            [ id:'test1', single_end:false ], // meta map
            file(params.test_data['bacteroides_fragilis']['illumina']['test1_paired_end_sorted_bam'], checkIfExists: true),
        ],
        [
            [ id:'test2', single_end:false ],
            file(params.test_data['bacteroides_fragilis']['illumina']['test2_paired_end_sorted_bam'], checkIfExists: true),
        ]
    )

    bams = input.map{ [[id:"test"], it[1]] }.groupTuple()

    COVERM_CONTIG ( bams )
}
