#!/bin/bash

BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfRNAseq_GRCh38_ensembl'
OutDir=${BaseDir}/nfcoreRNAseq-outs
cd ${BaseDir}
mkdir -p ${OutDir}

nextflow run nf-core/rnaseq \
	-profile sahmri \
	-c ${BaseDir}/nextflow.config \
	-r 3.14.0 \
	--input ${BaseDir}/nfSampleSheet.csv \
	--outdir ${OutDir} \
	--fasta /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
	--gtf /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.111.gtf \
	--multiqc_methods_description /homes/daniel.thomson/References/multiqc_config_logo.yml \
        -resume

#        --skip_dupradar \
#        --skip_qualimap \
#        --save_reference \
