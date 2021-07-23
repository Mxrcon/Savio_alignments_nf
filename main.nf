nextflow.enable.dsl = 2

include { DOWNLOAD_GENOMES } from "./modules/download_genomes/download_genomes.nf"
include { PROKKA } from "./modules/prokka/prokka.nf"
include { GET_GENES } from "./modules/get_genes/get_genes.nf"
include { GET_RRNA } from "./modules/get_genes/get_rrna.nf"
include { ALIGN_MARKERS } from "./modules/align_markers/align_markers.nf"

workflow {
    id_list_ch = Channel.fromList(params.genomes_ids)
    DOWNLOAD_GENOMES(id_list_ch)
    PROKKA(DOWNLOAD_GENOMES.out)
// Creating input channels for processes
    genes_list_ch = Channel.fromList(params.genes_names)
    rrna_list_ch = Channel.fromList(params.rrna_names)

    GET_GENES(PROKKA.out.anotated_genome, genes_list_ch)
    GET_RRNA(PROKKA.out.anotated_genome, rrna_list_ch)
// Exporting markers and joining them together
    markers_ch = Channel.of().mix(GET_RRNA.out.groupTuple(),GET_GENES.out.groupTuple())
    ALIGN_MARKERS(markers_ch)
}
