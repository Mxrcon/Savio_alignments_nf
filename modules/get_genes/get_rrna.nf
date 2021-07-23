nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/rrna"
params.save_mode = 'copy'
params.should_publish = true

process GET_RRNA {
    tag "${genomeName} - ${ribossomal_rna_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(gbkFile)
    each ribossomal_rna_name
    output:
    tuple val(ribossomal_rna_name), path("*.fasta")

    script:

    """
    find_ribossomal_rna.py ${gbkFile} ${ribossomal_rna_name}
    """

    stub:

    """
    echo "find_ribossomal_rna.py ${genomeName} ${ribossomal_rna_name}"
    touch ${genomeName}_${ribossomal_rna_name}.fasta
    """
}
