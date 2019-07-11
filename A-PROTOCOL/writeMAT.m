function [] = writeMAT(intervals,condNames,TR,fps,runName,outputFolder)

nVols = length(intervals);
nFrames = nVols*fps*TR;
nCond = length(condNames);

framesCond = zeros(nFrames,1);

for t = 0:nVols-1  
    framesCond(t*fps*TR+1:(t+1)*fps*TR) = intervals(t+1);
end

% output
save(fullfile(outputFolder,['Protocol-' runName '.mat']),...
    'framesCond','nFrames','condNames','nVols','nCond','runName');

fprintf('[writeMAT] %s file exported.\n',['Protocol-' runName '.mat']);

end
