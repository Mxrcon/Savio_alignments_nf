#!/usr/bin/env python3

from Bio import SeqIO
import sys
import os

#basic_args
input_file = sys.argv[1]
gene_name = sys.argv[2]
#script
output_name = input_file.split(".")[0]

for seq_record in SeqIO.parse(input_file , 'genbank'):
    for feature in seq_record.features:
        if feature.type == "CDS" and "gene" in feature.qualifiers:
            gene = feature.qualifiers['gene'][0]
            if gene_name == gene:
                with open(output_name+"_"+gene_name+".fasta", "w") as outfile:
                    outfile.write(">{0}|{1}\n{2}\n".format(output_name,gene_name,feature.location.extract(seq_record).seq))
