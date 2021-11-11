# Vulnerability of Blue Foods to Human-induced Environmental Change

This repositroy saves processing and visulization scripts for article *Vulnerability of Blue Foods to Human-induced Environmental Change*.

## Repository contents

* /Data/ folder - contain raw/unprocessed database;
  * 01_raw_data.xlsx - Raw database for further calculation;
  * 02_ISO_information.csv - Conataining management and production related informations;
* /Scripts/ folder - contain processing scripts:
  * 00_functions.R - Predefined computation functions;
  * 01_data_preparation.R - spitting databases for further computation;
  * 02_EI_computation.R - Computation scripts for Exposure Impacts, using function in 00_functions.R;
  * 03_PI_computation.R - Computation scripts for Potential Impacts, using function in 00_functions.R;
  * 04_model_aggregrate.R - Combine model Results;
  * 05_vul_computation.R - Scripts for culculation of vulnerability;
  * 06_to_viz_data.R - Scripts for combine all data together and output first stage visualization data, the EI data is directly used in visulization of Fig S
* /Scripts/07_plotting - contain visulization scripts:
  * 00_Viz_data_gather.R - recombine data output from 06_to_viz_data.R, used for final stage visualization;
  * 01_Viz.R - final visualization script for figs except Fig S9-10;
  * 02_figs09-10.R - visualization script for Fig S9-10.
