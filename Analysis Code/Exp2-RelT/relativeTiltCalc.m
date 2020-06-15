function [avgSame, sdSame, avgOpp, sdOpp, avgFull, sdFull] = relativeTiltCalc(mainFolder, pnum)
%
% function to calculate the relative tilts for same full and opposite
% conditions
% formula = ATAN((SIN(PI()*(RESPONSE IN DEGREES-PRBANG IN DEGREES)/180))/(SIN(PI()*RESPONSE IN DEGREES/180))) * 180/PI()
%
% Example:
%   [avgSame, sdSame, avgOpp, sdOpp, avgFull, sdFull] = relativeTiltCalc('E:\Experiments\FPI_RT_EXPS\Ageing_Data\dataFiles\RT', '2')  

%% Load data to analyse
% load RTdat
% mainFolder = 'E:\Experiments\FPI_RT_EXPS\Ageing_Data'; 

if pnum < 10
    folderNum = sprintf('P00%d',pnum);
else
    folderNum = sprintf('P0%d',pnum);
end

% Load the relevant mat file
matFileName = sprintf('%s_RT.mat', folderNum);
matFile = fullfile(mainFolder,folderNum,matFileName);
load (matFile)

%% Set up arrays etc
% create empty array for relative tilts
relTilt = [];

% find no of RTdat rows to loop through
nTrials = length(RTdat(:,1));

%% Calculate reltive tilts for each trial and add to data array
% loop through rows and calculate relative tilt for each trial
for i = 1 : nTrials
    relTilt(i,1) = atan((sin(pi*(RTdat(i,6)-RTdat(i,3))/180))/(sin(pi*RTdat(i,6)/180)))*180/pi;
end

% add relative tilts as new column in RTdat
RTdat = [RTdat relTilt];

% loop through transform each relative tilt (to negate left/right
% presentation) 
for i = 1 : nTrials
    if RTdat(i,4) < 0
        RTdat(i,7) = RTdat(i,7) * -1;
    end
end

%% Calculate average relTs for each condition
full = RTdat(:,2) == 0;
fullRTs = RTdat(full,7);

avgFull = mean(fullRTs);
sdFull = std(fullRTs);


opp = [];
for i = 1:nTrials
    f = (RTdat(i,2) == 1) && (RTdat(i,4) > 0) || (RTdat(i,2) == 2) && (RTdat(i,4) < 0);
    opp(i,1) = f;
end
opp = logical(opp);
oppRTs = RTdat(opp,7);
avgOpp = mean(oppRTs);
sdOpp = std(oppRTs);

same = [];
for i = 1:nTrials
    f = (RTdat(i,2) == 1) && (RTdat(i,4) < 0) || (RTdat(i,2) == 2) && (RTdat(i,4) > 0);
    same(i,1) = f;
end
same = logical(same);
sameRTs = RTdat(same,7);
avgSame = mean(sameRTs);
sdSame = std(sameRTs);

%% Save updated RTdat
save(matFile,'RTdat');
