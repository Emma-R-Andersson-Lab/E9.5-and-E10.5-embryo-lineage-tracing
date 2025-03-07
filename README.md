# Repository for in utero next generation single cell lineage tracing, used in De Haan & He et al


Contains scripts used to analyse data in:
- De Haan & He et al. Ectoderm barcoding reveals neural and cochlear compartmentalization

This repository contains instructions to

- [Generate the barcode library characterization](Barcode_library_sequencing)
- [Processing FASTQ files](cloneID_extraction)
- [Extract CellIDs from individual Seurat objects needed for CloneID extraction using the Trex algorithm](cloneID_extraction)
- [Jaccard Threshold and exclusion list parameter analysis](trex_parameter_sweep)
- [Integrate various scRNAseq datasets using SCTransform and adding cloneIDs into Seurat Objects](qc_and_clustering) (including QC and clustering)

- [Analysis and visualization as in Figures in De Haan and He et al.](analysis)
- 


An overview of the workflow can be seen in the figure below.

![workflow](assets/analysis_flow.jpg)

## Running Python and Jupyter notebooks

Download and install conda (preferably from [MINIFORGE](https://github.com/conda-forge/miniforge#download)). 
Then clone this repository and install it.

```
git clone git@github.com:Emma-R-Andersson-Lab/E9.5-and-E10.5-embryo-lineage-tracing.git
cd E9.5-and-E10.5-embryo-lineage-tracing
conda env create -f environment.yml
```

Once it is installed, activate it and install TREX as we will need its helper functions.
Finally run jupyter lab to open the notebook and run the cells.

*Note: the `--no-deps` parameter is only needed in Windows.*

```
conda activate E9.5-and-E10.5-embryo-lineage-tracing
pip install git+https://github.com/frisen-lab/TREX.git --no-deps
jupyter lab
```

## Cite

```
Sandra de Haan#, Jingyan He#, Agustin A. Corbat, Lenka Belicova, Michael Ratz, Elin Vinsland, Jonas Frisén, Matthew W. Kelley, Emma R. Andersson* (2025). Ectoderm barcoding reveals neural and cochlear compartmentalization
```

## License

[GNU GPL 3.0](LICENSE)

## Contact

Open an issue in this repository.
