% import files from each participant directory and calculate average
% relative tilts for each participant, placing them in a group matrix

mainFolder = 'E:\Experiments\FPI_RT_EXPS\Ageing_Data';   % absolute path of data folder

subFolder = dir(fullfile(mainFolder,'P*'));

nSubs = size(subFolder,1);

grpRTData = []; % create empty array for group data, to be saved as .mat

for i = 1 : nSubs
    
    isDir = subFolder(i).isdir;
    if isDir == 0
        continue
    end
    
    pFolder = subFolder(i).name;
    pnum = str2num(erase(pFolder,"P"));
    
    if pnum == 17
        continue
    end
    %if pFolder == 'P001'
     %   break
        %[avgHemi, sdHemi, avgFull, sdFull] = relativeTiltCalc(pnum);
    %end
                
    RTfiles = dir(fullfile(mainFolder, pFolder,'*FP_RT*.txt')); % find all files
    % in data folder that fit the filespec
    
    RTdat = []; %create empty array for RT data for each participant
    
    nFilesRT = size(RTfiles,1); % count number of relevant files
    % accessing first column of dirinfo which is the filenames 
    
    for j = 1 : nFilesRT
        filename = RTfiles(j).name;
        filepath = RTfiles(j).folder;
        fullpath = fullfile(filepath,filename);
        if pFolder == 'P001'
            RTdat = importRTfile(fullpath,j,RTdat,5,94);
        else
            RTdat = importRTfile(fullpath,j,RTdat,5,112);
        end
    end
    
    mat_filename = sprintf('%s_RT_age_og.mat',pFolder);
    mat_filepath = fullfile(filepath, mat_filename);
    save(mat_filepath,'RTdat');
    
    %[avgHemi, sdHemi, avgFull, sdFull] = relativeTiltCalc(pnum);
    [avgSame, sdSame, avgOpp, sdOpp, avgFull, sdFull] = relativeTiltCalc(pnum);
    
    grpRTData(i,1:6) = [avgSame, sdSame, avgOpp, sdOpp, avgFull, sdFull];
   
end

%RTratio = (grpRTData(:,1))./(grpRTData(:,3));
%grpRTData = [grpRTData RTratio];

%avgRT = (grpRTData(:,1)+grpRTData(:,3))./2;
%normHF = grpRTData(:,1)./avgRT;

%grpRTData = [grpRTData normHF];

mat_grp_filename = 'grpRTdata_age_og.mat';
save(fullfile(mainFolder, mat_grp_filename),'grpRTData');