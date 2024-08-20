#!/bin/bash

R1=$1
R2=$2

#number of reads
depth=60000000

paste ${R1} ${R2} | awk '{ printf("%s",$0); n++; if(n%4==0) { printf("\n");} else { printf("\t");} }' |
awk -v k=${depth} 'BEGIN{srand(systime() + PROCINFO["pid"]);}{s=x++<k?x- 1:int(rand()*x);if(s<k)R[s]=$0}END{for(i in R)print R[i]}' |
awk -F"\t" '{print $1"\n"$3"\n"$5"\n"$7 > $R1 ;print $2"\n"$4"\n"$6"\n"$8 > R2.fastq}'
