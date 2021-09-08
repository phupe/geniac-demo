# Geniac-demo pipeline 

[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A519.10.0-brightgreen.svg)](https://www.nextflow.io/)
[![Install with](https://anaconda.org/anaconda/conda-build/badges/installer/conda.svg)](https://conda.anaconda.org/anaconda)
[![Singularity Container available](https://img.shields.io/badge/singularity-available-7E4C74.svg)](https://singularity.lbl.gov/)
[![Docker Container available](https://img.shields.io/badge/docker-available-003399.svg)](https://www.docker.com/)

## Introduction

This is a demo pipeline with the best practises for the development of bioinformatics analysis pipelines with [Nextflow](https://www.nextflow.io) and [geniac](https://github.com/bioinfo-pf-curie/geniac) (Automatic Configuration GENerator and Installer for nextflow pipeline). 

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow manager to run tasks across multiple compute infrastructures in a very portable manner.

It supports [conda](https://docs.conda.io) package manager and  [singularity](https://sylabs.io/) / [Docker](https://www.docker.com/) containers making installation easier and results highly reproducible.


## Quick start

```bash
conda create -n geniac-cli python=3.9
conda activate geniac-cli
pip install git+https://github.com/bioinfo-pf-curie/geniac.git@release
```


```bash
geniac init ${HOME}/tmp/try-geniac-demo https://github.com/bioinfo-pf-curie/geniac-demo.git
geniac install ${HOME}/tmp/try-geniac-demo/install
geniac test conda
```

### Quick help

```bash
nextflow run main.nf --help
N E X T F L O W  ~  version 19.10.0
Launching `main.nf` [stupefied_darwin] - revision: aa905ab621
=======================================================

Usage:

Mandatory arguments:
--reads [file]                   Path to input data (must be surrounded with quotes)
--samplePlan [file]              Path to sample plan file if '--reads' is not specified
--genome [str]                   Name of the reference genome. See the `--genomeAnnotationPath` to defined the annotation path
-profile [str]                   Configuration profile to use (multiple profiles can be specified with comma separated values)

Inputs:
--design [file]                  Path to design file for extended analysis
--singleEnd [bool]               Specifies that the input is single-end reads

Skip options: All are false by default
--skipSoftVersion [bool]         Do not report software version
--skipMultiQC [bool]             Skip MultiQC

Other options:
--metadata [dir]                Add metadata file for multiQC report
--outDir [dir]                  The output directory where the results will be saved
-w/--work-dir [dir]             The temporary directory where intermediate data will be saved
-name [str]                      Name for the pipeline run. If not specified, Nextflow will automatically generate a random mnemonic

=======================================================
Available profiles
-profile test                    Run the test dataset
-profile conda                   Build a new conda environment before running the pipeline. Use `--condaCacheDir` to define the conda cache path
-profile multiconda              Build a new conda environment per process before running the pipeline. Use `--condaCacheDir` to define the conda cache path
-profile path                    Use the installation path defined for all tools. Use `--globalPath` to define the installation path
-profile multipath               Use the installation paths defined for each tool. Use `--globalPath` to define the installation path
-profile docker                  Use the Docker images for each process
-profile singularity             Use the Singularity images for each process. Use `--singularityPath` to define the path of the singularity containers
-profile cluster                 Run the workflow on the cluster, instead of locally

```


### Quick run

The pipeline can be run on any infrastructure from a list of input files or from a sample plan as follows:

#### Run the pipeline on a test dataset

See the file `conf/test.config` to set your test dataset.

```bash
nextflow run main.nf -profile test,conda

```

#### Run the pipeline from a `sample plan` and a `design` file

```bash
nextflow run main.nf --samplePlan mySamplePlan.csv --design myDesign.csv --genome 'hg19' --genomeAnnotationPath /my/annotation/path --outDir /my/output/dir

```

### Defining the '-profile'

By default (whithout any profile), Nextflow excutes the pipeline locally, expecting that all tools are available from your `PATH` environment variable.

In addition, several Nextflow profiles are available that allow:
* the use of [conda](https://docs.conda.io) or containers instead of a local installation,
* the submission of the pipeline on a cluster instead of on a local architecture.

The description of each profile is available on the help message (see above).

Here are a few examples to set the profile options:

#### Run the pipeline locally, using a global environment where all tools are installed (build by conda for instance)
```bash
-profile path --globalPath /my/path/to/bioinformatics/tools
```

#### Run the pipeline on the cluster, using the Singularity containers
```bash
-profile cluster,singularity --singularityPath /my/path/to/singularity/containers
```

#### Run the pipeline on the cluster, building a new conda environment
```bash
-profile cluster,conda --condaCacheDir /my/path/to/condaCacheDir

```

For details about the different profiles available, see [Profiles](docs/profiles.md).

### Sample plan

A sample plan is a csv file (comma separated) that lists all the samples with a biological IDs.
The sample plan is expected to contain the following fields (with no header):

```
SAMPLE_ID,SAMPLE_NAME,path/to/R1/fastq/file,path/to/R2/fastq/file (for paired-end only)
```

### Design control

A design file is a csv file that provides additional details on the samples and how they should be processed.
Here is a simple example:

```
SAMPLEID,CONTROLID,GROUP
A949C08,A949C02,1
...
```

<!-- TODO - update the design -->

### Genome annotations

The pipeline does not provide any genomic annotations but expects them to be already available on your system. The path to the genomic annotations can be set with the `--genomeAnnotationPath` option as follows:

```bash
nextflow run main.nf --samplePlan mySamplePlan.csv --design myDesign.csv --genome 'hg19' --genomeAnnotationPath /my/annotation/path --outDir /my/output/dir

```

For more details see  [Reference genomes](docs/referenceGenomes.md).

## Full Documentation

1. [Installation](docs/installation.md)
2. [Reference genomes](docs/referenceGenomes.md)
3. [Running the pipeline](docs/usage.md)
4. [Output and how to interpret the results](docs/output.md)
5. [Troubleshooting](docs/troubleshooting.md)


*Geniac* is an **A**utomatic **C**onfiguration **GEN**erator and **I**nstaller for nextflow pipelines.

* [Documentation](#documentation)
* [Acknowledgements](#acknowledgements)
* [Release notes](CHANGELOG)
* [Citation](#citation)

## Documentation

* The [geniac documentation](https://geniac.readthedocs.io) provides a set of best practises to implement *Nextflow* pipelines.
* The [geniac](https://github.com/bioinfo-pf-curie/geniac) source code provides the set of utilities.
* The [geniac demo](https://github.com/bioinfo-pf-curie/geniac-demo) provides a toy pipeline to test and practise *Geniac*.
* The [geniac template](https://github.com/bioinfo-pf-curie/geniac-template) provides a pipeline template to start a new pipeline.

## Acknowledgements

* [Institut Curie](https://www.curie.fr)
* [Centre national de la recherche scientifique](http://www.cnrs.fr)
* This project has received funding from the European Union’s Horizon 2020 research and innovation programme and the Canadian Institutes of Health Research under the grant agreement No 825835 in the framework on the [European-Canadian Cancer Network](https://eucancan.com/)

## Citation

[Allain F, Roméjon J, La Rosa P et al. Geniac: Automatic Configuration GENerator and Installer for nextflow pipelines. Open Research Europe 2021, 1:76](https://open-research-europe.ec.europa.eu/articles/1-76)
