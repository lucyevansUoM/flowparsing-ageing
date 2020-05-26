% import files from each participant directory and calculate PF values 
% and store in a group matrix

%% Find participant directories in main folder 
mainFolder = 'E:\Experiments\FPI_RT_EXPS\Ageing_Data\dataFiles\FPI';  % absolute path of data folder

plotFlag = 1; % 1 to ouput each PF plot; 0 to not

allFiles = dir(fullfile(mainFolder,'P*'));

dirFlags = [allFiles.isdir]; 

subFolders = allFiles(dirFlags);

nSubs = size(subFolders,1);

%grpFPIDataLR = []; % create empty array for group data, to be saved as .mat
grpFPIDataR = []; % create empty array for group data, to be saved as .mat

%% Loop through individual directories and get individual PF parameters 
% And add these to a group matrix
for i = 1 : nSubs
    
    pFolder = subFolders(i).name;
    
    FPIfiles = dir(fullfile(mainFolder, pFolder,'*FP_INDEX*.txt')); % find all files 
    % in data folder that fit the filespec
    
    FPIdat = []; %create empty array for FPI data for each participant
    
    nFilesFPI = size(FPIfiles,1); % count number of relevant files
    %accessing first column of dirinfo which is the filenames 
    
    for j = 1 : nFilesFPI
        filename = FPIfiles(j).name;
        filepath = FPIfiles(j).folder;
        fullpath = fullfile(filepath,filename);
        FPIdat = importFPIFile(fullpath,j,FPIdat,2,201,0); %imports & formats data file
    end
    
    mat_filename = sprintf('%s_FPI_R.mat',pFolder);
    save(fullfile(mainFolder, pFolder, mat_filename),'FPIdat'); %save .mat file of participant data
    
    [staticPSE, staticSigma, movingPSE, movingSigma] = fitPF_right(mainFolder, pFolder, plotFlag); %plotFlag 1 or 0
    
    grpFPIDataR(i,1:4) = [staticPSE, staticSigma, movingPSE, movingSigma];
end

%% Save the matrix as a mat file
mat_grp_filename = 'grpFPIdata_R.mat';
save(fullfile(mainFolder, mat_grp_filename),'grpFPIDataR');