// TODO nf-core: If in doubt look at other nf-core/modules to see how we are doing things! :)
process VCONTACT2_GENE2GENOME {
    label 'process_low'

    conda "bioconda::vcontact2=0.11.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/vcontact2:0.11.3--pyhdfd78af_0':
        'biocontainers/vcontact2:0.11.3--pyhdfd78af_0' }"

    input:
    path(protein) // path to protein fasta
    val(source_type) // e.g. 'Prodigal-FAA'

    output:
    path('gene2genome.csv'),    emit: proteins_csv
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''

    """
    vcontact2_gene2genome \\
        $args \\
        -p $protein \\
        -o gene2genome.csv \\
        -s $source_type \\

    // cat <<-END_VERSIONS > versions.yml
    // "${task.process}":
    //     : \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//' ))
    // END_VERSIONS
    """
}
