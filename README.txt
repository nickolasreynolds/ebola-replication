README
DATE: August 19, 2020 15:32 PT

This archive includes the data and code required to replicate the results from Christensen et al., "Community-Based Crisis Response: Evidence from Sierra Leone's Ebola Outbreak." AEA Papers and Proceedings 110: 260--264.

# _______________________________________________________________
CITATION:

@article{christensen:2020co,
Author = {Christensen, Darin and Dube, Oeindrila and Haushofer, Johannes and Siddiqi, Bilal and Voors, Maarten},
Title = {Community-Based Crisis Response: Evidence from Sierra Leone's Ebola Outbreak},
Journal = {AEA Papers and Proceedings},
Volume = {110},
Year = {2020},
Month = {May},
Pages = {260--264}
}

# _______________________________________________________________
DATA:

data/ccc.rds and data/ccc.csv are identical files. They provide the variables needed to create all plots and tables in the manuscript and online appendix, except for the maps in Figure A1. 

ccc-map.rds loads a list of 3 sf (geospatial) objects that are needed to create Figure A1. 

# _______________________________________________________________
INSTRUCTIONS:

All file paths are defined relative to the folder that contains the .rproj file. The easiest way to replicate the result is to open the .rproj file and run the code in _run-analysis.R. This sources the four scripts saved in the code/ folder; these scripts save results to the figures/ and tables/ folders as appropriate. (The numbered scripts in the code/ folder are all self-contained and can be run separately.)

# _______________________________________________________________
PACKAGES:

Note: all required packages need to be installed on your machine. Those packages are listed in the code/helper_scripts/_preamble.R script.

Critically, the original analysis was conducted using lfe version 2.8-2. That package has since been updated to version 2.8-5. This difference generates subtle differences in the standard errors, though no inferences are changed. (Changes typically appear beyond the second decimal place.) To exactly replicate the results, the user must install the legacy version of lfe, which we provide code to do at the top of the _run-analysis.R file.

