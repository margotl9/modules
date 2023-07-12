#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FASTA_PHAGE_HOST_IPHOP} from '../../../../subworkflows/nf-core/fasta_phage_host_iphop/main.nf'

workflow test_fasta_phage_host_iphop {
    
    input = [
        [id:'test'], 
        file(params.test_data['candidatus_portiera_aleyrodidarum']['genome']['genome_fasta'], checkIfExists: true)
    ]
    FASTA_PHAGE_HOST_IPHOP ( input )
}
