nextflow.enable.dsl = 2

include { DOWNLOAD_GENOMES } from "./modules/download_genomes/download_genomes.nf"



workflow {
    id_list_ch = Channel.fromList(params.genomes_ids)
    DOWNLOAD_GENOMES(id_list_ch)
}
