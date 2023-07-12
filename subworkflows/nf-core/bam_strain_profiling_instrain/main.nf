// TODO nf-core: If in doubt look at other nf-core/subworkflows to see how we are doing things! :)
//               https://github.com/nf-core/modules/tree/master/subworkflows


include { BOWTIE2_BUILD    } from '../../../modules/nf-core/bowtie2/build'
include { FASTQ_ALIGN_BOWTIE2    } from '../../../subworkflows/nf-core/fastq_align_bowtie2/main.nf'
include { INSTRAIN_COMPARE } from '../../../modules/phidepiper/instrain/compare'
include { INSTRAIN_PROFILE } from '../../../modules/nf-core/instrain/profile'


workflow INSTRAIN_ALIGN {


   take:
   reads       // channel: tuple meta1 (sample), fastq files, meta2 (reference)
   fasta       // channel: tuple meta, fasta file
   genes_fasta // optional: path to .fna of genes to be profiled
   stb_file    // optional path to .stb to be profiled


   main:


   ch_versions = Channel.empty()


   /* BOWTIE */
   FASTQ_ALIGN_BOWTIE2 (
       reads,
       BOWTIE2_BUILD( fasta ).index,
       false,
       true,
       fasta )
   ch_versions = ch_versions.mix(FASTQ_ALIGN_BOWTIE2.out.versions)


   /* INSTRAIN */
   INSTRAIN_PROFILE (
       FASTQ_ALIGN_BOWTIE2.out.bam,
       Channel.of(fasta).collect{ it[1] },
       genes_fasta,
       stb_file )
   ch_versions = ch_versions.mix(INSTRAIN_PROFILE.out.versions)


   INSTRAIN_COMPARE ( INSTRAIN_PROFILE.out.profile.map{ [[id:"test"], it[1]] }.groupTuple() , FASTQ_ALIGN_BOWTIE2.out.bam.map{ [[id:"test"], it[1]] }.groupTuple() , [] )


   ch_versions = ch_versions.mix(INSTRAIN_COMPARE.out.versions)




   emit:
   compare     = INSTRAIN_COMPARE.out.compare
   versions    = ch_versions    // channel: [ versions.yml ]
}
