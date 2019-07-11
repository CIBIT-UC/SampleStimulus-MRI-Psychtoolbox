function [  ] = writePRT( PRTParameters , PRTConditions , runName , outputFolder )

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

outputFileName = [ runName '.prt'];

% --- Create new file using parameters

prtFile = fopen( fullfile(outputFolder,outputFileName) , 'wt' );

% delimiter tab
del = char(9);

% --- FILE HEADER
fprintf(prtFile, '\n');
fprintf(prtFile, 'FileVersion:%s%s%i \n\n', del, del, PRTParameters.FileVersion);
fprintf(prtFile, 'ResolutionOfTime:%s%s \n\n', del, PRTParameters.Resolution);
fprintf(prtFile, 'Experiment:%s%s%s%s \n\n', del, del, del, PRTParameters.ExperimentName);
fprintf(prtFile, 'BackgroundColor:%s%s \n', del, num2str(PRTParameters.BackgroundColor));
fprintf(prtFile, 'TextColor:%s%s%s%s \n\n', del, del, del, num2str(PRTParameters.TextColor));
fprintf(prtFile, 'TimeCourseColor:%s%s \n', del, num2str(PRTParameters.TimeCourseColor));
fprintf(prtFile, 'TimeCourseThick:%s%i \n', del, PRTParameters.TimeCourseThick);
fprintf(prtFile, 'ReferenceFuncColor:%s%s \n', del, num2str(PRTParameters.ReferenceFuncColor));
fprintf(prtFile, 'ReferenceFuncThick:%s%i \n\n', del, PRTParameters.ReferenceFuncThick);
fprintf(prtFile, 'NrOfConditions:%s%s%i \n \n', del, del, PRTParameters.nCond);

% -- Conditions
condNames = fieldnames(PRTConditions);

for c = 1:PRTParameters.nCond
    
    % Write the name of the condition
    fprintf(prtFile, '%s \n', condNames{c});
    
    % Write the number of blocks
    fprintf(prtFile, '%i \n', PRTConditions.(condNames{c}).NumBlocks);
    
    for i = 1:size(PRTConditions.(condNames{c}).Intervals,1)
        
        % Write to file
        fprintf(prtFile, '%i%s%i \n', PRTConditions.(condNames{c}).Intervals(i,1), del, PRTConditions.(condNames{c}).Intervals(i,2));
        
    end
    
    % Write condition color
    fprintf(prtFile, 'Color:%s%i %i %i \n', del, PRTConditions.(condNames{c}).Color);
    
    fprintf(prtFile, '\n');
    
end

fclose(prtFile);

fprintf('[writePRT] %s file exported.\n',outputFileName);

end
