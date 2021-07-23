#!/usr/bin/env bash
set -euo pipefail

# I'd like to thank finswimmer for his contribution, please check
# https://www.biostars.org/p/332853/
cat *.fasta|awk -v RS=">" -v FS="\n" -v OFS="\n" '$0 {match($1, /^(.+)\|[^\|]+$/, name); for(i=2; i<=NF; i++) {seq[name[1]] = seq[name[1]]$i}}; END {for(id in seq){print ">"id, seq[id]}}' > concatenated_alignments.fasta
