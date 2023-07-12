include { MASH_SKETCH      } from '../../../modules/nf-core/mash/sketch/main'
include { MASH_SCREEN    } from '../../../modules/nf-core/mash/screen/main'

workflow  {

    take:
    reads // channel: [ val(meta), [ fastq paired end ] ]

    main:

    ch_versions = Channel.empty()

    // TODO nf-core: substitute modules here for the modules of your subworkflow

    MASH_SKETCH ( reads )
    ch_versions = ch_versions.mix(MASH_SKETCH.out.versions)

    MASH_SCREEN( reads, MASH_SKETCH.out.mash )
    ch_versions = ch_versions.mix(MASH_SCREEN.out.versions)

    emit:
    screen = MASH_SCREEN.out.screen             // list of sequences from fastx_db similar to query sequences

    versions = ch_versions                     // channel: [ versions.yml ]
}

