%% Experiment 2 (RelT) Group Analysis 

% Open the FPAge_grpAnalysisRT.m script 

% This script will load in the data files for each participant and save a .mat file of the data:

%  - Columns are [Trial no, Flow Field (0:Full,1:Left,2:Right), Probe Angle, Probe Position(cm)(-ve:Left,+ve:Right), ...

%    Flow(1:Radial), Response]

%  - Rows are trials

% It will then calculate the average relative tilt for each participant in each condition (full, opp, same) and save these in a group

% .mat file in the main folder:

% - Columns are [avgerage Same relT, sd Same, avgerage Opp relT, sd Opp, avgerage Full relT, sd Full]

% - Rows are participants

%% Before running:

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
