function [ Output ] = runSampleTask( runName , S )
%RUNSAMPLETASK Stimulus function for the Localiser
% Usage: [ Output ] = runSampleTask( S );
%
% Inputs:
%   : S - struct containing very important info (screen, subject, colors,
%   trigger, response box, eyetracker, etc)
%
% Outputs:
%   : Output - struct containing time of start, end and trigger of the
%   stimulation, key presses and codes, user responses.
%

Output = struct();
commandwindow;

%% Clean the COMs
% Never trust what happened before...
if S.RSPBOX
    IOPort('Purge',S.response_box_handle);
end
if S.TRIGGER
    IOPort('Purge', S.syncbox_handle);
end

%% Read PRT and define moving blocks
load(fullfile(S.input_path,[ runName '.mat']),...
    'framesCond','nFrames','condNames','nVols','nCond','runName');

movingIdx = find(ismember(condNames, 'DotsMoving')) ; % index of the moving dots condition
reportIdx = find(ismember(condNames, 'Response')) ; % index of the report condition

%% Movings Dots Properties and Aperture
dots = struct();
dots.nDots = 350;                % number of dots
dots.color = [255,255,255];      % color of the dots
dots.size = 6;                   % size of dots (pixels)
dots.apertureSize = [9,9];       % size of rectangular aperture [w,h] in degrees.

dots.speed = 3;       %degrees/second

dots.direction = [ 0 45 90 120 180 225 270 315 ];  %degrees (clockwise from straight up)
dots.nDir = length(dots.direction);

% Start at the center of the screen
dots.center = [0,0];

% Calculate the left, right top and bottom of the aperture (in degrees)
dots.l = dots.center(1)-dots.apertureSize(1)/2;
dots.r = dots.center(1)+dots.apertureSize(1)/2;
dots.b = dots.center(2)-dots.apertureSize(2)/2;
dots.t = dots.center(2)+dots.apertureSize(2)/2;

% New random starting positions
dots.x = (rand(1,dots.nDots)-.5)*dots.apertureSize(1) + dots.center(1);
dots.y = (rand(1,dots.nDots)-.5)*dots.apertureSize(2) + dots.center(2);

idx = []; dx = []; dy = [];

%% Initialize key related stuff
btUnique = false;
nButtons = 2;
keyCodes = zeros(nButtons,1);
keysPressed = zeros(nFrames , 2);

%% Stimulus

try
    % -- Open Window
    [ windowID , winRect ] = Screen('OpenWindow', S.screenNumber , S.black);
    
    % -- Center Variables
    [S.xCenter, S.yCenter] = RectCenter(winRect);
    
    % -- Flip Interval
    ifi = Screen('GetFlipInterval', windowID);
    
    % -- Rendering Options
    Screen('BlendFunction', windowID, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    % -- Select specific text font, style and size
    Screen('TextFont', windowID , 'Arial');
    Screen('TextSize', windowID , 30);
    
    % -- Hide Cursor
    HideCursor;
    
    % -- Initialise EyeTracker
    if S.EYETRACKER
        eyeTrackerInit( windowID , S , [ 'R' runName{end} ] );
    end
        
    % -- Instruction
    text = 'Look attentively at the fixation dot. \n You must report using buttons 1 and 2, \n when the fixation dot turns orange, if \n 1) The dots moved \n 2) The dots did not move. \n\n (researcher) Press any key to continue.';
    DrawFormattedText(windowID, text, 'center', 'center', S.white);
    Screen('Flip',windowID);
    KbStrokeWait;
    
    % -- Map Keys / Identify Key Codes
    while ~btUnique
        
        % Button 1
        DrawFormattedText(windowID, 'Press Button for Yes', 'center', 'center', S.white);
        Screen('Flip',windowID);
        if S.RSPBOX
            pr = 1;
            while pr
                key = IOPort('Read',S.response_box_handle);
                if ~isempty(key) && (length(key) == 1)
                    keyCodes(1) = key;
                    pr = 0;
                end
                IOPort('Flush',S.response_box_handle);
            end
        else
            [~,code] = KbPressWait;
            keyCodes(1) = find(code==1);
        end
        
        % Button 2
        DrawFormattedText(windowID, 'Press Button for No', 'center', 'center', S.white);
        Screen('Flip',windowID);
        if S.RSPBOX
            pr = 1;
            while pr
                key = IOPort('Read',S.response_box_handle);
                if ~isempty(key) && (length(key) == 1)
                    keyCodes(2) = key;
                    pr = 0;
                end
                IOPort('Flush',S.response_box_handle);
            end
        else
            [~,code] = KbPressWait;
            keyCodes(2) = find(code==1);
        end
        
        % Further check codes (if they are different)
        if length(unique(keyCodes)) == nButtons
            btUnique = true;
        else
            keyCodes = zeros(nButtons,1);
        end
        
        clear code key pr
        
    end
    
    % -- Start Eyetracker
    if S.EYETRACKER
        eyeTrackerStart();
    end
    
    % -- Wait for Key Press or Trigger
    if S.TRIGGER
        DrawFormattedText(windowID, 'Waiting to start...', 'center', 'center', S.white);
        Screen('Flip',windowID);
        disp('[runSampleTask] Waiting for trigger...')
        
        [gotTrigger, timeStamp] = waitForTrigger(S.syncbox_handle,1,300); % timeOut = 5 min (300s)
        if gotTrigger
            disp('[runSampleTask] Trigger Received.')
            IOPort('Purge', S.syncbox_handle);
        else
            disp('[runSampleTask] Trigger Not Received. Aborting!')
            return
        end
    else
        DrawFormattedText(windowID, '(researcher) Press Enter to Start', 'center', 'center', S.white);
        Screen('Flip',windowID);
        disp('[runSampleTask] Waiting to start...')
        KbPressWait;
    end
    
    %% Frame Iteration
    vbl = Screen('Flip', windowID);
    disp('[runSampleTask] Starting iteration...')
    
    init = GetSecs;
    
    for ii = 1:nFrames % Iteration on the frames
        
        % -------- ESCAPE KEYS --------
        [keyPress,~,keyCode] = KbCheck();
        if keyCode(KbName('escape')) == 1 % Quit if "Esc" is pressed
            throw(MException('user:escape','Aborted by escape key.'))
        end
        
        % Depending on the current experimental condition
        switch framesCond(ii)
            
            case reportIdx
                
                drawFixationCross( windowID , S , 'orange' )
                
                changeDir = true;
                
                % -- KEYS
                if S.RSPBOX
                    [key,timestamp] = IOPort('Read',S.response_box_handle);
                    
                    if ~isempty(key) && (length(key) == 1)
                        IOPort('Flush',S.response_box_handle);
                        
                        keysPressed(ii,1) = key;
%                         nEventsUser(idxStop,1) = find(key_codes==key);
%                         nEventsUser(idxStop,2) = timestamp;
                        
                    end
                    
                    IOPort('Flush',S.response_box_handle);
                else
                    if keyPress
                        a = find(keyCode==1);
                        if length(a) == 1
                            keysPressed(ii,1) = a;
%                             if any(a==key_codes) % User is numb and can press any key...
%                                 nEventsUser(idxStop,1) = find(key_codes==a);
%                             end
%                             nEventsUser(idxStop,2) = idxStop;
                        end
                    end
                end
                  
            case movingIdx
                
                [dots, idx, dx, dy, changeDir] = drawMovingDots(windowID, S, dots, idx, dx, dy, changeDir);
                
                drawFixationCross( windowID , S , 'purple' )
                
                % Clean the Response Box COM at every iteration. This allows
                % the participant to freely play with the buttons when there
                % should be no responses. But just don't try it.
                if S.RSPBOX
                    IOPort('Purge',S.response_box_handle);
                end
                
            otherwise
                drawFixationCross( windowID , S , 'purple' )
                
                changeDir = true;
                
        end
        
        keysPressed(ii,2) = GetSecs;
        
        % FLIP
        vbl = Screen('Flip', windowID, vbl + 0.5*ifi);
              
    end % End of frame interation
    
    finit = GetSecs;
    
    % -- Stop EyeTracker
    if S.EYETRACKER
        eyeTrackerStop( 0 );
    end
    
    % -- Close window
    Screen('CloseAll');
    ShowCursor;
    commandwindow;
    
    % -- Export Log
    Output.Subject = S.SUBJECT;
    Output.Start = init;
    Output.End = finit;
    if S.TRIGGER
        Output.TriggerTime = timeStamp;
    end
    Output.Keys = keysPressed;
    Output.KeyCodes = keyCodes;
    
    output_filename = [S.SUBJECT '_' runName '_' datestr(now,'HHMM_ddmmmmyyyy')];
    save(fullfile(S.output_path,output_filename),'Output')
    
    disp('[runSampleTask] Done.')
    
catch ME
    
    finit = GetSecs;
    
    % -- Stop EyeTracker
    if S.EYETRACKER
        eyeTrackerStop( 1 );
    end
    
    % -- Close window
    Screen('CloseAll');
    ShowCursor;
    commandwindow;
    
    % -- Deal with it
    switch ME.identifier
        case 'user:escape'
            % -- Export Incomplete Log
            Output.Subject = S.SUBJECT;
            Output.Start = init;
            Output.End = finit;
            if S.TRIGGER
                Output.TriggerTime = timeStamp;
            end
            Output.Keys = keysPressed;
            Output.KeyCodes = keyCodes;
            
            output_filename = [S.SUBJECT '_' runName '_' datestr(now,'HHMM_ddmmmmyyyy') '_Aborted'];
            save(fullfile(S.output_path,output_filename),'Output')
            
            disp('[runSampleTask] Aborted by escape key.')
        otherwise
            rethrow(ME);
            % psychrethrow(psychlasterror);
    end
    
end % End try/catch

end % End function
