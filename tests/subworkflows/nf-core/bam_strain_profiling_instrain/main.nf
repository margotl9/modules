#!/usr/bin/env nextflow


nextflow.enable.dsl = 2


include { INSTRAIN_ALIGN } from '../../../../subworkflows/nf-core/bam_strain_profiling_instrain/main.nf'
include { GUNZIP } from '../../../modules/nf-core/gunzip/main.nf'




workflow test_bam_strain_profiling_instrain {
  
   input = Channel.of(
       [[id:'test1', single_end:false ], // meta map
       [
           file(params.test_data['sarscov2']['illumina']['test_1_fastq_gz'], checkIfExists: true),
           file(params.test_data['sarscov2']['illumina']['test_2_fastq_gz'], checkIfExists: true)
       ]],
       [[id:'test2', single_end:false ], // meta map
       [
           file(params.test_data['sarscov2']['illumina']['test2_1_fastq_gz'], checkIfExists: true),
           file(params.test_data['sarscov2']['illumina']['test2_2_fastq_gz'], checkIfExists: true)
       ]]
       )


   fasta = [
       [id: 'test'],
       file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true)
   ]
  
   INSTRAIN_ALIGN( input, fasta, [], [] )
}
