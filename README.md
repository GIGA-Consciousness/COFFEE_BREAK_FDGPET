# DOC_TOOLBOX

We provide an automated, fast, user-friendly and free-to-use (open-source GPL2) Statistical Parametric Mapping (SPM) pipeline, written in MATLAB, for tha analysis of [18F]FDG-PET images in patients with disorders of consciousness. The pipeline is based on validated analytical procedures ([Bruno et al., 2012](https://pubmed.ncbi.nlm.nih.gov/22081100/); [Thibaut et al., 2012](https://pubmed.ncbi.nlm.nih.gov/22366927/); [Thibaut et al., 2021](https://pubmed.ncbi.nlm.nih.gov/33938027/)) routinely used at the [Coma Science Group](https://www.coma.uliege.be/) and [Centre du Cerveau2](https://www.chuliege.be/jcms/c2_18822094/fr/centre-du-cerveau/accueil), Liège, Belgium.

The pipeline takes in the patient’s [18F]FDG-PET DICOM images and automatically performs all processing and pre-processing steps needed to estimate the patient's absolute decrease in brain glucose metabolism as well as the relative decrease vs. relative preservation of brain glucose metabolism (at voxel, region and network level).

Please refer to the material available here for a general overview on [18F]FDG-PET assessment in disorders of consciousness: [FDG-PET-2021](https://indico.giga.uliege.be/e/FDG-PET-2021)

> Note: this is a preliminary version of the pipeline that still has to be extensively tested on images derived from different scanners.

An overview of the pipeline is available below 

![pipeline](https://github.com/tincala91/COFFEE_BREAK_FDGPET/blob/main/doc/consciousness_fdg_pipeline.png)



## Setup 

[Matlab](https://nl.mathworks.com/products/matlab.html?s_tid=hp_ff_p_matlab) and [SPM](https://www.fil.ion.ucl.ac.uk/spm/software/download/) need to be installed before this pipeline can be run. The minimum requirements are Matlab 2017b and SPM12. Note that SPM12 can be installed only *after* installation of Matlab (see [instructions](https://en.wikibooks.org/wiki/SPM/Installation_on_Windows))

To setup the pipeline, the user should download all files and folders in this [GitHub repository](https://github.com/GIGA-Consciousness/COFFEE_BREAK_FDGPET); next, a Data folder containing the nifti files of 33 healthy controls, used for comparison in the analyses, should be downloaded from [EBRAINS](https://search.kg.ebrains.eu/instances/Dataset/68a61eab-7ba9-47cf-be78-b9addd64bb2f) by the user and placed into the COFFEE_BREAK_FDGPET folder.



## Running the pipeline

To run, the pipeline only requires the user to provide the DICOM files of the [18F]FDG-PET scan of the patient as input. 

To do so, the user should:
1) open Matlab
2) set the current directory to the COFFEE_BREAK_FDGPET folder
2) type `COFFEE_BREAK_FDGPET` in the Matlab prompt and press `enter`
3) select the folder containing the patient's DICOM files

For users with no previous experience with Matlab, a [short introduction](https://www.youtube.com/watch?v=0T2a-lZhMsk) to the software is recommended.

NB: we strongly recommended to NOT add the COFFEE_BREAK_FDGPET folder to the Matlab path; this can cause issues if multiple versions of the code get downloaded on the same computer



## Pre-processing and processing

All pre-processing steps (incl. co-registration, normalization, smoothing and scaling) are performed automatically, following a stand-alone pipeline based on a [18F]FDG-PET template specific for disorders of consciousness. 
The processed image is statistically compared to a reference group of 33 healthy controls (19-70 years old; 18/15 males/females; freely available online on the [EBRAINS](https://search.kg.ebrains.eu/instances/Dataset/68a61eab-7ba9-47cf-be78-b9addd64bb2f) platform).

![pipeline](https://github.com/tincala91/COFFEE_BREAK_FDGPET/blob/main/doc/consciousness_fdg_pipeline_analysis.png)

## Using the outputs

The pipeline produces a series of outputs of interest, saved within the patient's folder provided by the user:
1) voxel-based maps of relative hypometabolism and preserved metabolism, based on standardized uptake value ratio (SUVr, with global mean scaling), plus summary statistics and graphical renderings to aid clinical interpretation 
2) decrease in the patient’s global brain glucose metabolism, based on SUV, including graphical renderings to aid clinical interpretation 

All outputs are saved into the original patient's folder. 
The voxel-based maps of relative hypometabolism and preserved metabolism (nifti format), their graphical renders (image format) and summary statistics (excel or tsv format) are saved into the *SPM* subfolder.
The decrease in the patient's global brain glucose metabolism (xls or tsv format) and its graphical render (image format) are saved into the *SUV* subfolder.
A PET_info (excel or tsv format) file containing the main information extracted from the file header is also provided in the patient's folder.

More information on the types of outputs provided is available [here](https://www.youtube.com/watch?v=ncFcTxUuUK4&list=PLClpNB6uNhfHnBARU2MkRgASyM7M8WOGY&index=11)

More information on how to use these outputs for clinical purposes is available [here](https://www.youtube.com/watch?v=DENEYRvDaiA&list=PLClpNB6uNhfHnBARU2MkRgASyM7M8WOGY&index=12)

Examples of [18F]FDG-PET outputs in clinical cases are available [here](https://www.youtube.com/watch?v=CmX3zHdkI3A&list=PLClpNB6uNhfHnBARU2MkRgASyM7M8WOGY&index=13) and [here](https://www.youtube.com/watch?v=CmX3zHdkI3A&list=PLClpNB6uNhfHnBARU2MkRgASyM7M8WOGY&index=14)



## Quality checks

Please note that quality checks should be performed before interpreting the outputs of the pipeline; the user is advised in particular to evaluate the following: 
- the goodness of the spatial normalization procedure (the user should perform a visual evaluation of patient's w and sw images produced by the pipeline; normalization can be suboptimal in patients with extensive brain deformation)
- the goodness of the mask produced by SPM (the user should perform a visual evaluation of the patient's mask image produced by the pipeline; masks can fail to include all the relevant brain gray matter regions in patients with extremely low brain glucose metabolism)

For users with limited experience on the above, a [short overview](https://www.youtube.com/watch?v=UdRekc62ve0&list=PLClpNB6uNhfHnBARU2MkRgASyM7M8WOGY&index=10) of quality check steps is strongly recommended.

