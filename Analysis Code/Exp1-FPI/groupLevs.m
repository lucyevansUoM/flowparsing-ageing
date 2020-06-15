function [edges, binMean, prop1s] = groupLevs(levs, resps, nBins, plotFlag)
 
% function to group binary responses into proportion correct when binning
% over similar levels
%
% edges = upper bin level
% binMean = mean of binned levels
% prop1s = mean of resp over binned levels
%
% levs = raw level data (likely from staircase)
% resps = raw binary resp data
% nBins = number of bins required
% plotFlag = 1 if want to plot
 
[levs,I] = sort(levs);
resps = resps(I);
 
N = length(levs);
%n = floor(N/binN);
nPerBin = floor(N/nBins);
 
% % calculate bins
% for i = 1:nBins-1
%     bins(i) = levs(nPerBin*i);
% end
% bins(nBins) = levs(N);
 
% calculate bin edges (i.e. the max value of each bin)
edges(nBins) = levs(N)+.01;
for i = 1:nBins-1
     edges(nBins-i) = levs(N-nPerBin*i);
end
%edges = [-inf, edges]; 
 
 
 
[count,X] = histc(levs, edges);
 
for j = 1:length(edges)
    prop1s(j) = sum(resps(X==j-1))/sum(X==j-1);
    binMean(j) = mean(levs(X==j-1));
end
 
if plotFlag
    plot(binMean, prop1s, 'g*')
end
 
