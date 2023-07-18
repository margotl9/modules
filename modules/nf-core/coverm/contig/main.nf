process COVERM_CONTIG {
    tag "$meta.id"
    label 'process_single'

    
    conda "bioconda::coverm=0.6.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/coverm%3A0.6.1--hc216eb9_0':
        'biocontainers/coverm%3A0.6.1--hc216eb9_0' }"

    input:
    tuple val(meta), path(bams)

    output:
    tuple val(meta), path("coverm_contig_output.tsv"), emit: tsv
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    
    """
    coverm contig \\
        $args \\
        -b $bams \\
        -o coverm_contig_output.tsv \\
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        coverm: \$(echo \$(coverm --version 2>&1) | sed 's/^.*coverm //; s/Using.*\$//' ))
    END_VERSIONS
    """


    stub:
    def args = task.ext.args ?: ''

    """
    touch $tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        : \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//' ))
    END_VERSIONS
    """
}
