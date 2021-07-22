nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/fasta_genomes"
params.save_mode = 'copy'
params.should_publish = true

process DOWNLOAD_GENOMES {
    tag "${genomeId}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish
    errorStrategy 'ignore'

    input:
    val(genomeId)

    output:
    tuple val(genomeId), path("${genomeId}*")

    script:
    """
    ncbi-acc-download ${genomeId} -F fasta
    """

    stub:
    """
    echo "ncbi-acc-download ${genomeId} -F fasta"
    touch ${genomeId}.fa
    """

}
