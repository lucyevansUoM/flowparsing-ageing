function [staticPSE, staticSigma, movingPSE, movingSigma] = fitPF_right(pnum, plotFlag)
% FP Index Palamedes analysis
% Check the format of the mat file (e.g. number of columns and what they
% all are
% fitPF_R code written 06/01/20
% (adapted from fitPF_LR)
%
% Have written importFile to flip sign of stim levels and change resps to
% 1 (right) and 0 (left) so it makes sense - check this!
%
% Coded as if data was collected with the probe on the right  
%
close all

%% Load the correct FPI file to analyse
% Load the relevant mat file
% This should be FPIdat - a 200x5 double: trial, sc, objside, objspeed, resp
% Resps should be 1 (r) & 0 (l) and objspeed should be -ve: left, +ve: right

matFile_content = '%s_FPI_R.mat'; % same as 0312, but specific filename for probe on right
matFile = sprintf(matFile_content, pnum);
load (matFile)

%% Set up some trial/stair params
nPerStair = 50;

%% Split data into important arrays

% Split in to objside left & right
lInds = find(FPIdat(:,3) == -1);
rInds = find(FPIdat(:,3) == 1);

% Flip signs/resps as if data collected with probe on the right
FPIdat(lInds,4) = -1*FPIdat(lInds,4);
FPIdat(lInds,5) = 1-FPIdat(lInds,5);

% Find stimulus levels and responses for the static condition (staircases
% 1 & 2)
staticStairs = find(FPIdat(:,2) <=2);
staticStimLevs = FPIdat(staticStairs,4); %3 without objside column, 4 with
staticResps = FPIdat(staticStairs,5); %4 without objside column, 5 with

% Find stimulus levels and responses for the moving condition (staircases
% 3 & 4)
movingStairs = find(FPIdat(:,2) >2);
movingStimLevs = FPIdat(movingStairs,4);
movingResps = FPIdat(movingStairs,5);


%% General PF inputs 
paramsFree = [1 1 0 0];

%searchGrid.alpha = [-1:0.1:1];
%searchGrid.beta = [0:0.1:20];
%searchGrid.gamma = 0;
%searchGrid.lambda = 0;

staticOutOfNum = ones(200,1);
movingOutOfNum = ones(200,1);

%% Do PF fit 

PF = @PAL_CumulativeNormal;

%[staticParamsValues] = PAL_PFML_Fit(staticStimLevs, staticResps, staticOutOfNum, searchGrid, paramsFree, PF);
%[movingParamsValues] = PAL_PFML_Fit(movingStimLevs, movingResps, movingOutOfNum, searchGrid, paramsFree, PF);
[staticParamsValues] = PAL_PFML_Fit(staticStimLevs, staticResps, staticOutOfNum, [0 1 0 0], paramsFree, PF);
[movingParamsValues] = PAL_PFML_Fit(movingStimLevs, movingResps, movingOutOfNum, [0 1 0 0], paramsFree, PF);

% unpack s params values
staticPSE = staticParamsValues(1);
staticSlope = staticParamsValues(2);
staticSigma = 1/staticSlope;

%%unpack m params values
movingPSE = movingParamsValues(1);
movingSlope = movingParamsValues(2);
movingSigma = 1/movingSlope;


%% Plot the PF if plotFlag is 1
if plotFlag
%     
%     staticStimFine = [min(staticStimLevs):(max(staticStimLevs)-min(staticStimLevs))./1000:max(staticStimLevs)];
%     movingStimFine = [min(movingStimLevs):(max(movingStimLevs)-min(movingStimLevs))./1000:max(movingStimLevs)];
%     staticFit = PF(staticParamsValues, staticStimFine);
%     movingFit = PF(movingParamsValues, movingStimFine);
%     
%     
%     [statEdges, statBinMean, statProp1s] = groupLevs(staticStimLevs, staticResps, 10, 0);
%     [movEdges, movBinMean, movProp1s] = groupLevs(movingStimLevs, movingResps, 10, 0);
%     
%         
%     %Figure
%     figure(1);
%    
%     plot(statBinMean, statProp1s,'ko','MarkerFace','k', 'markersize',8);
%     hold on;
%     plot(movBinMean, movProp1s,'ko','MarkerEdge','k', 'markersize',8);
%     
%     plot(staticStimFine,staticFit,'k-');
%     plot(movingStimFine,movingFit,'k-');
%     
%     line([staticPSE staticPSE],[0 0.5],'Color','k','LineStyle','--');
%     line([-1 staticPSE],[0.5 0.5],'Color','k','LineStyle','--');
%     line([movingPSE movingPSE],[0 0.5],'Color','k','LineStyle','--');
%     line([-1 movingPSE],[0.5 0.5],'Color','k','LineStyle','--');
%     xlabel('Velocity (cm/s)', 'FontSize', 12);
%     ylabel('Proportion Right Responses', 'FontSize', 12);
%     hold off;
%     legend({'Static', 'Moving'}, 'Location', 'northwest', 'FontSize', 12);
%     
%     fig_filename = sprintf('%s_R.jpg',pnum);
%     saveas(gcf,fig_filename);
    
    %SC Figure
    
    % split FPIdat into file 1 & 2
    FPIdat1 = FPIdat(1:200,:);
    FPIdat2 = FPIdat(201:400,:);
    
    %session 1 / file 1
    % for static plot
    statStair1_1 = find(FPIdat1(:,2) == 1);
    statStair1Levs_1 = FPIdat1(statStair1_1,4); %3 without objside column, 4 with
    statStair2_1 = find(FPIdat1(:,2) == 2);
    statStair2Levs_1 = FPIdat1(statStair2_1,4); %3 without objside column, 4 with
    
    % for moving plot
    movStair3_1 = find(FPIdat1(:,2) == 3);
    movStair3Levs_1 = FPIdat1(movStair3_1,4); %3 without objside column, 4 with
    movStair4_1 = find(FPIdat1(:,2) == 4);
    movStair4Levs_1 = FPIdat1(movStair4_1,4); %3 without objside column, 4 with
    
    %session 2 / file 2
    % for static plot
    statStair1_2 = find(FPIdat2(:,2) == 1);
    statStair1Levs_2 = FPIdat2(statStair1_2,4); %3 without objside column, 4 with
    statStair2_2 = find(FPIdat2(:,2) == 2);
    statStair2Levs_2 = FPIdat2(statStair2_2,4); %3 without objside column, 4 with

    
    % for moving plot
    movStair3_2 = find(FPIdat2(:,2) == 3);
    movStair3Levs_2 = FPIdat2(movStair3_2,4); %3 without objside column, 4 with
    movStair4_2 = find(FPIdat2(:,2) == 4);
    movStair4Levs_2 = FPIdat2(movStair4_2,4); %3 without objside column, 4 with

    
    col = ['r-'; 'g-'; 'b-'; 'm-'; 'r:'; 'g:'; 'b:'; 'm:'];
    
    figure(2);
    clf;
    subplot(2, 1, 1);
    hold on;
    xlabel('Trial number (Static)');
    ylabel('Stimulus level'); 
    
    plot(1:1:nPerStair, statStair1Levs_1, col(1,:)) 
    plot(1:1:nPerStair, statStair2Levs_1, col(2,:))
    plot(1:1:nPerStair, statStair1Levs_2, col(3,:))
    plot(1:1:nPerStair, statStair2Levs_2, col(4,:))
    
    hold off;
    subplot(2, 1, 2);
    hold on;
    xlabel('Trial number (Moving)');
    ylabel('Stimulus level');
    
    plot(1:1:nPerStair, movStair3Levs_1, col(1,:)) 
    plot(1:1:nPerStair, movStair4Levs_1, col(2,:))
    plot(1:1:nPerStair, movStair3Levs_2, col(3,:))
    plot(1:1:nPerStair, movStair4Levs_2, col(4,:))
    
    hold off;
    fig_filename = sprintf('%s_SCfig.jpg',pnum);
    %fig_filename = sprintf('%s_SCfig_sess1.jpg',pnum);
    saveas(gcf,fig_filename);
    
%     figure(3);
%     clf;
%     subplot(2, 1, 1);
%     hold on;
%     xlabel('Trial number (Static)');
%     ylabel('Stimulus level'); 
%     
%     plot(1:1:nPerStair, statStair1Levs_2, col(3,:))
%     plot(1:1:nPerStair, statStair2Levs_2, col(4,:)) 
%     
%     
%     hold off;
%     subplot(2, 1, 2);
%     hold on;
%     xlabel('Trial number (Moving)');
%     ylabel('Stimulus level');
%     
%     plot(1:1:nPerStair, movStair3Levs_2, col(3,:))
%     plot(1:1:nPerStair, movStair4Levs_2, col(4,:)) 
%     
%     hold off;
%     fig_filename = sprintf('%s_SCfig_sess2.jpg',pnum);
%     saveas(gcf,fig_filename);
end
        
end