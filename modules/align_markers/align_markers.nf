nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/aligned_markers"
params.save_mode = 'copy'
params.should_publish = true

process ALIGN_MARKERS {
    tag "${markerName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(markerName), path("*")
    output:
    tuple val(markerName), path("*.fasta")

    script:

    """
    cat *${markerName}* >> ${markerName}.fasta
    """

    stub:

    """
    echo "find_ribossomal_rna.py ${genomeName} ${ribossomal_rna_name}"
    touch ${genomeName}_${ribossomal_rna_name}.fasta
    """
}
