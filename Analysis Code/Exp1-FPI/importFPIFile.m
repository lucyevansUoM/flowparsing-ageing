function FPIdat = importFPIFile(filename, filenum, inputStruct, startRow, endRow, saveMat)
    % Function to import flow parsing index data file and convert to array
    %
    % Example:
    %   FPIdat = importFile("FP_INDEX_001_1.txt",1,FPIdat,2,201,1);
    %
    % Auto-generated by MATLAB on 2018/03/16 12:27:49
    % Edit by L.E. 
    
    %% Initialize variables.
    delimiter = '\t';
    if nargin<=2
        startRow = 2;
        endRow = inf;
    end
    
    %% Format for each line of text:
    %   column1: double (%f)
    %	column2: double (%f)
    %   column8: double (%f)
    %	column9: double (%f)
    % For more information, see the TEXTSCAN documentation.
    %if filenum == 1
    %    formatSpec = '%f%f%*s%*s%*s%*s%*s%f%s%[^\n\r]';
    %else
    %    formatSpec = '%f%f%*s%*s%*s%*s%*s%f%f%[^\n\r]';
    %end
    %formatSpec = '%f%f%*s%*s%*s%*s%*s%f%f%[^\n\r]';
    formatSpec = '%f%f%*s%*s%s%*s%*s%f%f%[^\n\r]';
    
    %% Open the text file.
    fileID = fopen(filename,'r');
    
    %% Read columns of data according to the format.
    % This call is based on the structure of the file used to generate this
    % code. If an error occurs for a different file, try regenerating the code
    % from the Import Tool.
    dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'TreatAsEmpty', {'-'}, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for block=2:length(startRow)
        frewind(fileID);
        dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
        for col=1:length(dataArray)
            dataArray{col} = [dataArray{col};dataArrayBlock{col}];
        end
    end
    
    
    %% Close the text file.
    fclose(fileID);
    
    %% Post processing for unimportable data.
    % No unimportable data rules were applied during the import, so no post
    % processing code is included. To generate code which works for
    % unimportable data, select unimportable cells in a file and regenerate the
    % script.
    
    %% Convert string column to numeric values 
    % save the indices for all the probe on left trials (obsd = l)
    dataArrayL = find(dataArray{1,3} == 'l');
    % save the indices for all the probe on right trials (obsd = r)
    dataArrayR = [1:200]';
    dataArrayR(dataArrayL) = [];
    
    % change obsd: L to -1; R to 1.  
    for i = 1:length(dataArrayL)
        dataArray{1,3}{dataArrayL(i)} = '-1';
    end
    for i = 1:length(dataArrayR)
        dataArray{1,3}{dataArrayR(i)} = '1';
    end
    
    dataArray{1,3} = str2double(dataArray{1,3});
    dataArray(:,6) = []; %delete the mysterious empty 6th column 
    
    %% Change stim levels & resps to make sense 
    %change resps: right(2) = 1; left(1) = 0.
    dataArray{:,5} = dataArray{:,5}-1;

    %change sign of all stim levels (currently - is right, + is left)
    dataArray{:,4} = dataArray{:,4}.*-1;

    
    %% Allocate imported array to column variable names
    FPIdat = inputStruct;
    if filenum == 1
        FPIdat(startRow-1:endRow-1,1) = dataArray{1,1};
        FPIdat(startRow-1:endRow-1,2) = dataArray{1,2};
        FPIdat(startRow-1:endRow-1,3) = dataArray{1,3};
        FPIdat(startRow-1:endRow-1,4) = dataArray{1,4};
        FPIdat(startRow-1:endRow-1,5) = dataArray{1,5};
    else
        FPIdat(endRow:(endRow-1)+(endRow-1),1) = dataArray{1,1};
        FPIdat(endRow:(endRow-1)+(endRow-1),2) = dataArray{1,2};
        FPIdat(endRow:(endRow-1)+(endRow-1),3) = dataArray{1,3};
        FPIdat(endRow:(endRow-1)+(endRow-1),4) = dataArray{1,4};
        FPIdat(endRow:(endRow-1)+(endRow-1),5) = dataArray{1,5};
    end
    