process CHECKV_ANICALC {
    tag "$meta.id"
    label 'process_single'


    conda "bioconda::checkv=1.0.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/YOUR-TOOL-HERE':
        'biocontainers/YOUR-TOOL-HERE' }"

    input:
    tuple val(meta), path(blastn)

    output:
    tuple val(meta), path("*.ani.tsv"), emit: ani
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    
    """
    anicalc.py  \\
        $args \\
        -i $blastn \\
        -o $ani \\
    """

    stub:
    def args = task.ext.args ?: ''

    """
    touch $ani
    """
}
