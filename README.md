# artic-rabv (for OIRSA)

#### VER README_ESPANOL.md arriba

Repository of material for rabies virus genomic surveillance using MinION sequencing (forked and modified from [artic-rabv](https://github.com/kirstyn/artic-rabv) which is forked and modified from [artic-base](https://github.com/artic-network/artic-base) and the latest conda environment from artic-ncov2019.

### Modified for use by the OIRSA-UofG Rabies Sequencing Project. (Note: Under development)

Contains ***materials, scripts and instructions*** for regional genomic surveillance of rabies using Nanopore MinION whole genome sequencing and FTA cards:

- Conserve, store and transport rabies positive brain samples on FTA cards: [training video](https://www.youtube.com/watch?v=fJ-_uupAVYA), protocols.io
- Metadata submission for samples and sample preps (e.g FTA cards, tissue) via Google Drive
- RNA elution and extraction from FTA cards: protocols.io
- Design and optimise multiplex primer schemes for rabies WGS ([PrimalScheme](https://primalscheme.com))
- Rabies WGS library prep and sequencing following the [end-to-end cost-effective workflow](https://www.jove.com/t/65414/whole-genome-sequencing-for-rapid-characterization-rabies-virus-using) with video and written insutructions
- Monitor sequencing in real time ([RAMPART](https://artic.network/rampart))
- Quality check raw data ([EPI2ME Labs](https://labs.epi2me.io))
- Generate consensus sequences ([ARTIC pipeline](https://artic.readthedocs.io/en/latest/))
- Classify lineages ([MADDOG](https://github.com/KathrynCampbell/MADDOG))
- Construct a maximum likelihood (ML) tree ([IQTREE](http://www.iqtree.org))
- Contextualise and report results ([Microreact](https://microreact.org))
- Share data and reports via Google Drive

### See original artic-rabv repo for
Resources and datasets used in publication:
Brunker K, Jaswant G, Thumbi SM et al. Rapid in-country sequencing of whole virus genomes to inform rabies elimination programmes [version 1; peer review: awaiting peer review]. Wellcome Open Res 2020, 5:3 (https://doi.org/10.12688/wellcomeopenres.15518.1)

Includes canine rabies primer schemes for various locations.

# To install: 
* Install the GitHub repository:  
```bash
git clone --recursive https://github.com/HFrench20/artic-rabv.git 
```
* Install mamba, which massively speeds up conda environment install:  
```bash
conda install mamba -n base -c conda-forge
```
* Create conda environment to install tools (using mamba). Modify the filepath after -f to reflect where you have installed artic-rabv on your computer.
* This will take a few minutes
```bash
mamba env create -f artic-rabv/environment.yml
``` 

* Use this command to activate your environment  
```bash
source activate artic-rabv  
```

* To update your environment after changes to environment file
```bash
conda env update --file artic-rabv/environment.yml
```

# Primer schemes  
Multiplex primer schemes for rabies virus whole genome sequencing, designed using Primal Scheme (http://primal.zibraproject.org/)  

#### OIRSA primer schemes
`VBRV_PS.4.2` = vampire bat rabies Central America Costa Rica ref

`VBRV_PS.4.3` = vampire bat rabies Central America Costa Rica ref (modified)

`VBRV_PS.8.1` = vampire bat rabies Central America 'northern strains'

#### Original artic-rabv primer schemes
`rabvTanzDg` = primers designed to target Tanzanian rabies virus (2016)

`rabv_ea` = updated primers for East Africa rabies virus lineages (2018)

`rabvSEasia` = primers designed to target SE Asia lineages of rabies virus  

`rabvPeru2` = primers designed to target lineages of rabies virus in Puno/Arequipa, Peru

# Protocols  
Full "sample-sequence-interpretation" protocol for rapid sequencing of rabies virus samples on the Nanopore MinION platform available with instructional videos on [JoVE](https://www.jove.com/t/65414/whole-genome-sequencing-for-rapid-characterization-rabies-virus-using) from Bautista et al., 2023 (doi: 10.3791/65414)



