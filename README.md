# MGIvsIllumina
daniel thomson

- I'm putting some data together for a direct comparison of MGI vs Illumina,
- the only dataset I am aware we have access to is Deb White's SAGCQA0625-1
- RNAseq dataset, 6 ALL blood samples, sequenced on both G400 and Nextseq
- I am going to run through nf-core/RNAseq together (12 samples) to get a better direct comparison analysis

```bash
BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina'
cd ${BaseDir}

#MGI data, G400
ln -s  /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030 .

#Illumina data, Nextseq
ln -s /cancer/storage/SAGC/fastq/SAGCQA0625/230424_NS500329_0587_AHTFMFBGXN/SAGCQA0625-1_DebWhite_24042023/ .

```
# nf-core/RNAseq

```bash
BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfRNAseq_GRCh38_ensembl'
cd ${BaseDir}

sh nf_rnaseq.sh 
```
-nexflow run script
```bash
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

```
# nf-core/DifferntialAbundance



```bash
 for input in $(ls /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/*R1_001.fastq.gz | awk -F "/" '{print $NF}' ) \
 do sbatch fastp_trimtolength.sh /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/$input /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/${input/R1/R2} \
 done
```
- there was actually quite a big difference in gene expression >300 genes downregulated with MGI
- but I have a feeling it's because of the lenght of the sequencing, Illumina 76bp, MGI 98bp,
- so im going to redo, but trim the MGI data to the same length with fastp

# rerunning with datasets of equal length
-trimming MGI reads to 76bp

```bash
 for input in $(ls /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/*R1_001.fastq.gz | awk -F "/" '{print $NF}' ) \
 do sbatch fastp_trimtolength.sh /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/$input /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/${input/R1/R2} \
 done
```

# nf-core/RNAseq with shortened fastqs

```bash
BaseDir='/homes/daniel.thomson/projects/MGIvsIllumina/nfRNAseq_GRCh38_ensembl_trimmed'
cd ${BaseDir}

sh nf_rnaseq.sh
```
-nexflow run script
```bash
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

```
# rerunning with subset fastqs to 60M
cd ~/projects/MGIvsIllumina/fastq.trimmed
gunzip *

cp ../SAGCQA0625-1_DebWhite_24042023/fastq/*.gz ~/projects/MGIvsIllumina/fastq.trimmed
