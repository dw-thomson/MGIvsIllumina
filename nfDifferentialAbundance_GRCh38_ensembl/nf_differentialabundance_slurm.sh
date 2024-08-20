#!/bin/bash

#SBATCH --job-name=DE
#SBATCH --output=nfDA.%j.out
#SBATCH --mail-user=daniel.thomson@sahmri.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=24G
#SBATCH --time=4-00:00:00          # Run time in hh:mm:s
#SBATCH --verbose

#conda activate nf

BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfDifferentialAbundance_GRCh38_ensembl'
cd ${BaseDir}
mkdir -p ${BaseDir}/outs

RNAseqOutDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfRNAseq_GRCh38_ensembl/nfcoreRNAseq-outs/star_salmon'

## sample names from sample sheet need to match count matrix
## formatting gene matrix - R has substituted symbols, need to switch back
#cat ${RNAseqOutDir}/salmon.merged.gene_counts.tsv | sed 's/X23/23/g' | sed 's/\.00/-00/g' | sed 's/MGI.G400/MGI-G400/g' > ${BaseDir}/salmon.merged.gene_counts.tsv
#cat ${RNAseqOutDir}/salmon.merged.gene_lengths.tsv | sed 's/X23/23/g' | sed 's/\.00/-00/g' | sed 's/MGI.G400/MGI-G400/g' > ${BaseDir}/salmon.merged.gene_lengths.tsv

## chaning the samplesheet instead

nextflow run nf-core/differentialabundance \
	-r 1.4.0 \
        -profile rnaseq,singularity \
	--input nfSampleSheetX.csv \
        --contrasts contrasts.csv \
	--matrix ${RNAseqOutDir}/salmon.merged.gene_counts.tsv \
	--transcript_length_matrix ${RNAseqOutDir}/salmon.merged.gene_lengths.tsv \
	--gtf /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.111.gtf \
	--outdir ${BaseDir}/outs \
	--features_id_col gene_id \
	--features_name_col gene_name \
	--features_type gene \
	--study_name 'MGIvsIllumina' \
	--study_type rnaseq \
	--shinyngs_build_app true \
	--email "daniel.thomson@sahmri.com" \
	--logo_file  '/cancer/storage/SAGC/workflows/nf-qc-sagc/prod/docs/figures/sagc-logo.png' \
	--report_title "MGIvsIllumina" \
	--report_author "Daniel Thomson (daniel.thomson@sahmri.com.au)" \
	--report_scree FALSE \
        --gsea_run \
        --gsea_gene_sets '/homes/daniel.thomson/References/GSEA/c5.all.v2023.2.Hs.symbols.gmt' \
	--gsea_make_sets \
	--gsea_zip_report \
	-resume

#        --matrix ${RNAseqOutDir}/salmon.merged.gene_counts.tsv \
#       --gsea_permute gene_set \
#        --features_name_col gene \

echo "#### FINISHED ####"
#--gsea_permute phenotype
#        -c ${BaseDir}/nextflow.config \


#        --features_id_col gene_id \
#        --features_type gene \

#   --gtf /homes/daniel.thomson/References/GRCh38/ncbi_dataset/data/GCF_000001405.40/genomic.gtf\

#         --matrix ${RNAseqOutDir}/salmon.merged.gene_counts.tsv \
#         --transcript_length_matrix ${RNAseqOutDir}/salmon.merged.gene_lengths.tsv \
