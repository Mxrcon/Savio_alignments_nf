nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/raxml"
params.save_mode = 'copy'
params.should_publish = true

process RAXML {
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path(alignment_file)
    output:
    path("*")

    script:

    """
    raxml-ng --msa ${alignment_file} --model GTR+G
    """

    stub:

    """
    echo "raxml-ng --msa concatenated_alignments.fasta --model GTR+G"
    touch aa
    """
}
