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

BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina'
JobName='nfDifferentialAbundance_GRCh38_ensembl_60M_76bp'
RunDir=${BaseDir}/${JobName}
OutDir=${BaseDir}/outs_${JobName}

cd ${RunDir}
mkdir -p ${OutDir}

RNAseqOutDir=${BaseDir}/outs_nfRNAseq_GRCh38_ensembl_60M_76bp/star_salmon

## sample names from sample sheet need to match count matrix

nextflow run nf-core/differentialabundance \
	-r 1.4.0 \
        -profile rnaseq,singularity \
	--input nfSampleSheet.csv \
        --contrasts contrasts.csv \
	--matrix ${RNAseqOutDir}/salmon.merged.gene_counts.tsv \
	--transcript_length_matrix ${RNAseqOutDir}/salmon.merged.gene_lengths.tsv \
	--gtf /homes/daniel.thomson/References/GRCh38/Ensembl_download/Homo_sapiens.GRCh38.111.gtf \
	--outdir ${OutDir} \
	--features_id_col gene_id \
	--features_name_col gene_name \
	--features_type gene \
	--study_name 'MGIvsIllumina-trimmed' \
	--study_type rnaseq \
	--shinyngs_build_app true \
	--email "daniel.thomson@sahmri.com" \
	--logo_file  '/cancer/storage/SAGC/workflows/nf-qc-sagc/prod/docs/figures/sagc-logo.png' \
	--report_title "MGIvsIllumina-trimmed" \
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

echo "#### CLEANUP ####"
cp ${OutDir}/report/*html ${RunDir}

echo "#### FINISHED ####"
#--gsea_permute phenotype
#        -c ${BaseDir}/nextflow.config \


#        --features_id_col gene_id \
#        --features_type gene \

#   --gtf /homes/daniel.thomson/References/GRCh38/ncbi_dataset/data/GCF_000001405.40/genomic.gtf\

#         --matrix ${RNAseqOutDir}/salmon.merged.gene_counts.tsv \
#         --transcript_length_matrix ${RNAseqOutDir}/salmon.merged.gene_lengths.tsv \
