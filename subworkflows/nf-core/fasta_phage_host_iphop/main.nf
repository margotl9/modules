// TODO nf-core: If in doubt look at other nf-core/subworkflows to see how we are doing things! :)
//               https://github.com/nf-core/modules/tree/master/subworkflows
//               You can also ask for help via your pull request or on the #subworkflows channel on the nf-core Slack workspace:
//               https://nf-co.re/join
// TODO nf-core: A subworkflow SHOULD import at least two modules

include { IPHOP_DOWNLOAD      } from '../../../modules/nf-core/iphop/download/main'
include { IPHOP_PREDICT    } from '../../../modules/nf-core/iphop/predict/main'

workflow FASTA_PHAGE_HOST_IPHOP {

    take:
    fasta // channel: [ val(meta), [ fasta ] ]

    main:
    IPHOP_DOWNLOAD()

    ch_versions = Channel.empty()

    db = IPHOP_DOWNLOAD.out.iphop_db
    ch_versions = ch_versions.mix(IPHOP_DOWNLOAD.out.versions)

    genus = IPHOP_PREDICT( fasta, db ).iphop_genus
    ch_versions = ch_versions.mix(IPHOP_PREDICT.out.versions)

    emit:
    genus                                      // file: Host_prediction_to_genus_m*.csv
    versions = ch_versions                     // channel: [ versions.yml ]
}

