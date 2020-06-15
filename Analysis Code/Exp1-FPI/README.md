
%% Experiment 1 (FPI) Group Analysis 

% Open the FPAge_grpAnalysisFPI.m script 

% This script will load in the data files for each participant and save a .mat file of the data

%  - Columns are [trail no, staircase no, probe side (-l:left, 1:right), probe speed (-ve:left, +ve:right), response (0:left, 1:right)]

%  - Rows are trials

% It will then fit a psychometric function to each participant's data and save the threshold(sigma) and PSE of all participants in 

% both conditions (static and moving). It will save a group .mat file in the mainFolder:

% - Columns are [staticPSE, staticSigma, movingPSE, movingSigma]

% - Rows are participants

% If plotFlag = 1, a PF plot is outputted and saved in for each participant in their folder

%% Before running:

% Set plotFlag to 1 (output and save psychometric function figure) or 0 (don't output/save figure)

% Ensure Palamedes and importFPIFile, groupLevs and fitPF_right functions are in the MATLAB path

% Change the path of the data folder at the top of the code (FPI directory)

  mainFolder = '...\dataFiles\FPI';

%% Run the script

% It is possible to run individual participant analyses by running importFPIFile and fitPF_right functions separately

% Example:

  FPIdat = importFile("FP_INDEX_001_1.txt",1,FPIdat,2,201,1);

% Save the FPIdat matrix for fitPF to load

% Or comment out the section of code that loads the file if FPIdat is still in workspace

  [staticPSE, staticSigma, movingPSE, movingSigma] = fitPF_right('E:\Experiments\FPI_RT_EXPS\Ageing_Data\dataFiles\FPI', 'P001', 1);

% This will output a PF plot and the parameters above
