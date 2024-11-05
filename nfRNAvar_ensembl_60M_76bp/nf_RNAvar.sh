#!/bin/bash

BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfRNAvar_ensembl_60M_76bp'
OutDir=${BaseDir}/outs
cd ${BaseDir}
mkdir -p ${OutDir}

nextflow run nf-core/rnavar \
	-profile sahmri \
	-c ${BaseDir}/nextflow.config \
	-r 1.0.0 \
	--input ${BaseDir}/nfSampleSheet.csv \
	--outdir ${OutDir} \
        --fasta /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
        --gtf /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.111.gtf \
	--email daniel.thomson@sahmri.com \
	--multiqc_title MGIvsIllumina_nfRNAvar_ensembl_60M_76bp \
	--dbsnp /homes/daniel.thomson/References/GRCh38/Ensembl_download/test_unzip/homo_sapiens_somatic_incl_consequences.vcf.gz \
	--dbsnp_tbi /homes/daniel.thomson/References/GRCh38/Ensembl_download/test_unzip/homo_sapiens_somatic_incl_consequences.vcf.gz.tbi \
        --read_length 150 \
	--star_index /homes/daniel.thomson/References/GRCh38/Ensembl_download/star_genome_generate_149bp \
        --star_ignore_sjdbgtf \
	-resume

# keeping the notes from previous

# I am running this on trimmed fastqs, I don't think this pipelines has a trimming step

# the star index I used was from the nfRNAseq outputs and it wasn't the same length (100nt), and pulled an error, I will regenerate the star intex using --sjdbOverhang 149
# new index in /homes/daniel.thomson/References/GRCh38/Ensembl_download/star_genome_generate

# but as a hack I can also choose the read length to one base above the length ( --read_length 101 \)
#         --read_length 148 \
#        --star_index /cancer/storage/SAGC/projects/SAGCQA1249_DeboraCasolari/nfRNAseq/nfcoreRNAseq-outs/genome/index/star \

# there were some version clashes with producing star index, so I used one that I'd produced with the RNAseq pipeline, but also had to use star_ignore_sjdbgtf

# dbsnp and vep datasets were downloaded


# it's failing at
# ERROR ~ Error executing process > 'NFCORE_RNAVAR:RNAVAR:GATK4_BASERECALIBRATOR (THP1-MIPS-54875-24h-2)'
# can't find the fai,
#        --fasta_fai /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.fai \
#
# this was fixed by removing the paramenter specifying the --fasta_fai. So that a .fai was auto generated


# it's now failing at:
#   Process `NFCORE_RNAVAR:RNAVAR:GATK4_BASERECALIBRATOR (THP1-MIPS-55262_6h-1)` terminated with an error exit status (2)
#  ***********************************************************************
#
#  A USER ERROR has occurred: An index is required but was not found for file homo_sapiens_somatic_incl_consequences.vcf.gz. Support for unindexed block-compressed files has been temporarily disabled. Try running IndexFeatureFile on the input.
#
#  ***********************************************************************

# I think this is because the --vep_genome parameter, trying tonow specify the .tar.gz library downloaded from ensembl, also the --vep species parameter
#         --vep_genome /homes/daniel.thomson/References/GRCh38/Ensembl_download/homo_sapiens \
#         --vep_species homo_sapiens \
#
#trying removing this
#        --dbsnp_tbi /homes/daniel.thomson/References/GRCh38/Ensembl_download/homo_sapiens_somatic_incl_consequences.vcf.gz.csi \
# this made it skip til the end
#
# now try removing this
#	        --vep_genome /homes/daniel.thomson/References/GRCh38/Ensembl_download/homo_sapiens/113_GRCh38 \
# and changing this, after generating my own indexed vcf
#        --dbsnp /homes/daniel.thomson/References/GRCh38/Ensembl_download/homo_sapiens_somatic_incl_consequences.vcf.gz \
#        --dbsnp_tbi /homes/daniel.thomson/References/GRCh38/Ensembl_download/homo_sapiens_somatic_incl_consequences.vcf.gz.csi \
#
# bgzip -c file.vcf > file.vcf.gz
# [tabix -p vcf file.vcf.gz]
# tabix -p vcf homo_sapiens_somatic_incl_consequences.vcf.gz
#

