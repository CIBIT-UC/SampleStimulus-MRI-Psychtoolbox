%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------- SAMPLE EXPERIMENT ---------------------------%
%------------------------------- Protocol --------------------------------%
%------------------------------ Version 1.0 ------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ______________________________________________________________________
% |                                                                      |%
% | Authors: John Doe                                                    |%
% |                                                                      |%
% |                                                                      |%
% |                        CIBIT ICNAS      2019                         |%
% |______________________________________________________________________|%
%
% This script will create protocol files (.prt) and MATLAB files (.mat) for
% each run of the experiment. These files are necessary for posterior
% analysis and for the stimulus code.
%
% Version 1.0
% - Creation
%

clear, clc;

%% Setup folders, repetition time and monitor refresh rate
prtFolder = fullfile(pwd,'PRTs');
matFolder = fullfile(pwd,'MATs');

TR = 1; % in seconds
fps = 60; % in frames per second

%% Setup PRT Parameters
PRTParameters = struct();

PRTParameters.FileVersion = 2;
PRTParameters.Resolution = 'Volumes';
PRTParameters.ExperimentName = 'Sample-Experiment';
PRTParameters.BackgroundColor = [0 0 0];
PRTParameters.TextColor = [255 255 255];
PRTParameters.TimeCourseColor = [1 1 1];
PRTParameters.TimeCourseThick = 3;
PRTParameters.ReferenceFuncColor = [0 0 80];
PRTParameters.ReferenceFuncThick = 2;

%% Define condition names, duration and color
condNames = {'Fixation','DotsMoving','Response','Discard'};

blockDuration = [ 5 5 5 5 ]; %in volumes 

blockColor = [170 170 170 ; 0 115 190 ; 216 83 25 ; 200 200 200];

%%  Create struct
PRTParameters.nCond = length(condNames);

PRTConditions = struct();

for c = 1:PRTParameters.nCond
    
    PRTConditions.(condNames{c}).Color = blockColor(c,:);
    PRTConditions.(condNames{c}).BlockDuration = blockDuration(c);
    PRTConditions.(condNames{c}).Intervals = [];
    PRTConditions.(condNames{c}).NumBlocks = 0;
    
end

%% Create PRT - SampleTask - Run 01
Sequence_R01 = [4 1 2 3 1 2 3 1 2 3 1 2 3 4]; % this is the sequence of conditions for this run. The numbers correspond to the indexes of the condNames variable.

[ PRTConditions_R01 , intervals_R01 ] = buildIntervals( Sequence_R01 , PRTConditions );

writePRT( PRTParameters , PRTConditions_R01 , 'SampleTask-Run01' , prtFolder );

%% Create PRT - SampleTask - Run 02
Sequence_R02 = [4 1 2 3 1 2 3 1 2 3 1 2 3 4]; % this is the sequence of conditions for this run. The numbers correspond to the indexes of the condNames variable.

[ PRTConditions_R02 , intervals_R02 ] = buildIntervals( Sequence_R02 , PRTConditions );

writePRT( PRTParameters , PRTConditions_R02 , 'SampleTask-Run02' , prtFolder );

%% Create MAT - SampleTask - Run 01
writeMAT(intervals_R01,condNames,TR,fps,'SampleTask-Run01',matFolder)

%% Create MAT - SampleTask - Run 02
writeMAT(intervals_R02,condNames,TR,fps,'SampleTask-Run02',matFolder)
