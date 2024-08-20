#!/bin/bash

BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/'
JobName='nfRNAseq_GRCh38_ensembl_60M_76bp'
RunDir=${BaseDir}/${JobName}
OutDir=${BaseDir}/outs_${JobName}

cd ${RunDir}
mkdir -p ${OutDir}

nextflow run nf-core/rnaseq \
	-profile sahmri \
	-c ${RunDir}/nextflow.config \
	-r 3.14.0 \
	--input ${RunDir}/nfSampleSheet.csv \
	--outdir ${OutDir} \
	--fasta /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
	--gtf /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.111.gtf \
	--multiqc_methods_description /homes/daniel.thomson/References/multiqc_config_logo.yml \
        -resume

#        --skip_dupradar \
#        --skip_qualimap \
#        --save_reference \

echo "#### CLEANUP ####"
cp ${OutDir}/multiqc/*/*html ${WorkDir}
ln -s ${OutDir} ${RunDir}
