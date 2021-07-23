#!/usr/bin/env python3

from Bio import SeqIO
import sys
import os

#basic_args
input_file = sys.argv[1]
rrna_name = sys.argv[2]
#script
output_name = input_file.split(".")[0]

for seq_record in SeqIO.parse(input_file , 'genbank'):
    for feature in seq_record.features:
        if feature.type == "rRNA" and "product" in feature.qualifiers:
            product = feature.qualifiers['product'][0]
            if rrna_name in product:
                with open(output_name+"_"+rrna_name+".fasta", "w") as outfile:
                    outfile.write(">{0}|{1}\n{2}\n".format(output_name,rrna_name,feature.location.extract(seq_record).seq))
