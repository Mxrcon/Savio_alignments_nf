nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/concatenated_alignment"
params.save_mode = 'copy'
params.should_publish = true

process CONCATENATE_ALIGNMENTS {

    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path("*")
    output:
    path("concatenated_alignments.fasta")

    script:

    """
    concatenate.sh
    """

    stub:

    """
    touch concatenated_alignments.fasta
    """
}
