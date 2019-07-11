function [ PRTConditions , intervals ] = buildIntervals( Sequence , PRTConditions )

condNames = fieldnames(PRTConditions);
currentTime = 0;

intervals = [];

for t = 1:length(Sequence)
    
    PRTConditions.(condNames{Sequence(t)}).Intervals = ...
        [PRTConditions.(condNames{Sequence(t)}).Intervals ; ...
        currentTime+1 currentTime+PRTConditions.(condNames{Sequence(t)}).BlockDuration];
    
    PRTConditions.(condNames{Sequence(t)}).NumBlocks = PRTConditions.(condNames{Sequence(t)}).NumBlocks + 1;
    
    currentTime = currentTime+PRTConditions.(condNames{Sequence(t)}).BlockDuration;
    
    intervals = [intervals ; Sequence(t)*ones(PRTConditions.(condNames{Sequence(t)}).BlockDuration,1)];
    
end

end
