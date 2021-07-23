nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/genes"
params.save_mode = 'copy'
params.should_publish = true

process GET_GENES {
    tag "${genomeName} - ${gene_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(gbkFile)
    each gene_name
    output:
    tuple val(gene_name), path("*.fasta")

    script:

    """
    find_genes.py ${gbkFile} ${gene_name}
    """

    stub:

    """
    echo "find_genes.py ${gbkFile} ${gene_name}"
    touch ${genomeName}_${gene_name}.fasta
    """
}
