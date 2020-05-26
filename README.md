% flowparsing-ageing
% Analysis code for flow parsing tasks in Evans et al. 2020 JOV flow parsing and ageing paper
% Requires MATLAB and the Palamedes toolbox 

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

% Before running:
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Experiment 2 (RT) Group Analysis 
% Open the FPAge_grpAnalysisRT.m script 
% This script will load in the data files for each participant and save a .mat file of the data:
%  - Columns are [Trial no, Flow Field (0:Full,1:Left,2:Right), Probe Angle, Probe Position(cm)(-ve:Left,+ve:Right), ...
%    Flow(1:Radial), Response]
%  - Rows are trials

% It will then calculate the average relative tilt for each participant in each condition (full, opp, same) and save these in a group
% .mat file in the main folder:
% - Columns are [avgerage Same relT, sd Same, avgerage Opp relT, sd Opp, avgerage Full relT, sd Full]
% - Rows are participants

% Before running:
% Ensure importRTFile and relativeTiltCalc functions are in the MATLAB path
% Change the main path of the data folder at the top of the code (RT directory)

  mainFolder = '...\dataFiles\RT';

%% Run the script

% It is possible to run individual participant analyses by running importRTFile and relativeTiltCalc functions separately
% Example:

  RTdat = [];
  [RTdat] = importRTfile('FP_RT_002_sess1.txt', 1, RTdat, 5, 112);


% Save the RTdat matrix for relativeTiltCalc to load
% Or comment out the section of code that loads the file if RTdat is still in workspace

  [avgSame, sdSame, avgOpp, sdOpp, avgFull, sdFull] = relativeTiltCalc('E:\Experiments\FPI_RT_EXPS\Ageing_Data\dataFiles\RT', '2');

% This will output the parameters above
