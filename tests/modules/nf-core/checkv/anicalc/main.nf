#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CHECKV_ANICALC } from '../../../../../modules/nf-core/checkv/anicalc/main.nf'
include { BLAST_MAKEBLASTDB } from '../../../../../modules/nf-core/blast/makeblastdb/main.nf'
include { BLAST_BLASTN      } from '../../../../../modules/nf-core/blast/blastn/main.nf'

workflow test_checkv_anicalc {
    
    input = [ file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true) ]

    BLAST_MAKEBLASTDB ( input )
    BLAST_BLASTN ( [ [id:'test'], input ], BLAST_MAKEBLASTDB.out.db )

    CHECKV_ANICALC ( BLAST_BLASTN.out.input )
}
