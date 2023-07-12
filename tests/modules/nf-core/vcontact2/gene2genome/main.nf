#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { VCONTACT2_GENE2GENOME } from '../../../../../modules/nf-core/vcontact2/gene2genome/main.nf'

workflow test_vcontact2_gene2genome {
    
    input = Channel.of(
        file(params.test_data['sarscov2']['genome']['proteome_fasta'], checkIfExists: true),
    )
    VCONTACT2_GENE2GENOME ( input , 'NCBIFasta')
}
