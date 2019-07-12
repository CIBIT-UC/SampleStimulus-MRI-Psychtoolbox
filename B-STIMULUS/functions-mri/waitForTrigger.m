function [gotTrigger, timeStamp]=waitForTrigger(syncBoxHandle,triggerN,timeOut)
%
% waits for timeOut seconds for the Nth MR trigger on port
%
% Example usage:
% waitForTrigger (syncBoxHandle, 1, 300) 
% 
%  Inputs:
%     syncBoxHandle (handle) - handle to I/O port
%     triggerN 
%     timeOut (int)
%   Outputs:
%     gotTrigger
%     timeStamp
%

t=GetSecs;
t0=t;

%exit condition
stopWaitingAtTime=t+timeOut;
triggersReceived=0; 
cycles=0;

while t<stopWaitingAtTime
    t=GetSecs;
    cycles=cycles+1;
    %triggerData=[round(rand*.5001),GetSecs];
    [syncData,syncTime,errmsg]=IOPort('Read',syncBoxHandle);    
    
    if ~isempty(syncData) % trigger was received
        triggersReceived=triggersReceived+1;
        disp(strcat('got trigger #', num2str(triggersReceived),' at time:',num2str(syncTime-t0))); % just for checking; remove 
    end
    
    if triggersReceived>=triggerN
        gotTrigger=1;
        timeStamp=syncTime;
        disp(strcat('waited for:',num2str(syncTime-t0),' seconds'));
        disp(strcat('# cycles:',num2str(cycles)));
        disp(strcat('mean cycle time',num2str((syncTime-t0)/cycles)));
        return
    end
    
    [keyIsDown, timeSecs, keyCode] = KbCheck;
            
    if strcmp(KbName(keyCode),'esc')
        Priority(0);Screen('CloseAll');
        gotTrigger=0;
        timeStamp=getSecs;
        return;
    end;
end

gotTrigger=0;
timeStamp=getSecs;
disp(strcat('Timed out after waiting for ',num2str(t-t0),' seconds'));
disp(strcat('# cycles:',cycles));

end
