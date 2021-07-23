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
    tuple val(markerName), path("aligned/*.fasta")

    script:

    """
    cat *${markerName}* >> ${markerName}.fasta
    clustalo -i ${markerName}.fasta -o ${markerName}_aligned.fasta --outfmt=fa
    mkdir aligned
    mv ${markerName}_aligned.fasta aligned/.
    """

    stub:

    """
    echo "clustalo -i ${markerName}.fasta -o ${markerName}_aligned.fasta --outfmt=fa"
    mkdir aligned
    touch aligned/${markerName}_aligned.fasta

    """
}