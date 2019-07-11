function [ D ] = moveDots( cond , D , T , nDotsDown )
%MOVEDOTS Move the dots position depending on the current condition
% Usage: [ D ] = moveDots( cond , D , T )
%
% Inputs:
%   : cond - Current condition index as returned in framesDots by extractFramesPRT
%   : D - struct with dots-related parameters
%   : T - struct with textures
%
% Outputs:
%   : D - struct with dots-related parameters (updated)
%

if cond == 11 % Rest , Static Test
    
    % - Adjust
    D.n_dots_plaid_down=D.n_dots_plaid;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;

elseif cond == 999 % Ambiguous Down
    
    % - Adjust
    D.n_dots_plaid_down = nDotsDown;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    
    % - Movement
    
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)+D.dots_veloc_vert;
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)+D.dots_veloc_horiz;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)+D.dots_veloc_vert;
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)-D.dots_veloc_horiz;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1); % Select the "active" ones
        if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=round(rand(length(D.dots_out45_down),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
        end
        D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
        if ~isempty(D.dots_out45_in)
            D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=1;
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=round(rand(length(D.dots_out45_in),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
        if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=round(rand(length(D.dots_out_45_down),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
        end
        D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
        if ~isempty(D.dots_out_45_in)
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=T.height;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=round(rand(length(D.dots_out_45_in),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
        end
    end

elseif cond == 22 % Pattern Down
    
    % - Adjust
    D.n_dots_plaid_down=D.n_dots_plaid;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)+D.dots_veloc_vert;
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)+D.dots_veloc_vert;
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
%         if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=D.dots_xy45(D.dots_out45(D.dots_out45_down),2)+D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_down)),1)*D.dots_veloc_vert;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
%         if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)+D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_down)),1)*D.dots_veloc_vert;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
        if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=round(rand(length(D.dots_out45_down),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
        if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=round(rand(length(D.dots_out_45_down),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
        end
    end
    
elseif cond == 33 % Component Out
    
    % - Adjust
    D.n_dots_plaid_down=0;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)+D.dots_veloc_horiz;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)-D.dots_veloc_horiz;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
%         if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=D.dots_xy45(D.dots_out45(D.dots_out45_in),1)+D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_in)),1)*D.dots_veloc_horiz;
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
%         if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)-D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_in)),1)*D.dots_veloc_horiz;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
        if ~isempty(D.dots_out45_in)
            D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=1;
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=round(rand(length(D.dots_out45_in),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
        if ~isempty(D.dots_out_45_in)
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=T.height;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=round(rand(length(D.dots_out_45_in),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
        end
    end
    
elseif cond == 222 % Pattern Up
    
    % - Adjust
    D.n_dots_plaid_down=D.n_dots_plaid;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)-D.dots_veloc_vert;
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)-D.dots_veloc_vert;
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
%         if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=D.dots_xy45(D.dots_out45(D.dots_out45_down),2)-D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_down)),1)*D.dots_veloc_vert;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
%         if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)-D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_down)),1)*D.dots_veloc_vert;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
        if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=round(rand(length(D.dots_out45_down),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=T.height;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
        if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=round(rand(length(D.dots_out_45_down),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=T.height;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
        end
    end
    
elseif cond == 333 % Component In
    
    % - Adjust
    D.n_dots_plaid_down=0;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)-D.dots_veloc_horiz;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)+D.dots_veloc_horiz;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
%         if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=D.dots_xy45(D.dots_out45(D.dots_out45_in),1)-D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_in)),1)*D.dots_veloc_horiz;
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
%         if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)+D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_in)),1)*D.dots_veloc_horiz;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
        if ~isempty(D.dots_out45_in)
            D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=T.height;
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=round(rand(length(D.dots_out45_in),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
        if ~isempty(D.dots_out_45_in)
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=1;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=round(rand(length(D.dots_out_45_in),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
        end
    end
    
elseif cond == 2222 % Pattern Right
    
    % - Adjust
    D.n_dots_plaid_down=D.n_dots_plaid;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)+D.dots_veloc_horiz;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)+D.dots_veloc_horiz;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
%         if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=D.dots_xy45(D.dots_out45(D.dots_out45_down),1)+D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_down)),1)*D.dots_veloc_horiz;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
%         if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)+D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_down)),1)*D.dots_veloc_horiz;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height)); %Find points outside the borders
    if ~isempty(D.dots_out45)
        D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
        if ~isempty(D.dots_out45_down)
            D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=1;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=round(rand(length(D.dots_out45_down),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
        if ~isempty(D.dots_out_45_down)
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=1;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=round(rand(length(D.dots_out_45_down),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
        end
    end
    
elseif cond == 3333 % Component Out Vertical
    
    % - Adjust
    D.n_dots_plaid_down=0;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1);
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)+(D.dots_veloc_vert-1);
%     D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)-(D.dots_veloc_vert-1);
%     D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
%         if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=D.dots_xy45(D.dots_out45(D.dots_out45_in),2)+D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_in)),1)*(D.dots_veloc_vert-1);
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
%         if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)-D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_in)),1)*D.dots_veloc_vert;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
        if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=round(rand(length(D.dots_out45_in),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
        if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=round(rand(length(D.dots_out_45_in),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=T.height;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
        end
    end
    
elseif cond == 22222 % Pattern Left
    
    % - Adjust
    D.n_dots_plaid_down=D.n_dots_plaid;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),4)=1;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),4)=1;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),1)-D.dots_veloc_horiz;
    D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy45(D.dots_xy45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),1)-D.dots_veloc_horiz;
    D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),2);
%     D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)=D.dots_xy_45(D.dots_xy_45_perm(1,1:D.n_dots_plaid_down),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1);
%         if ~isempty(D.dots_out45_down)
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=D.dots_xy45(D.dots_out45(D.dots_out45_down),1)-D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_down)),1)*D.dots_veloc_horiz;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
%         if ~isempty(D.dots_out_45_down)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)-D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_down)),1)*D.dots_veloc_horiz;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height)); %Find points outside the borders
    if ~isempty(D.dots_out45)
        D.dots_out45_down=find(D.dots_xy45(D.dots_out45,4)==1); % Select the "active" ones
        if ~isempty(D.dots_out45_down)
            D.dots_xy45(D.dots_out45(D.dots_out45_down),1)=T.height;
%             D.dots_xy45(D.dots_out45(D.dots_out45_down),2)=round(rand(length(D.dots_out45_down),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_down),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_down=find(D.dots_xy_45(D.dots_out_45,4)==1);
        if ~isempty(D.dots_out_45_down)
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),1)=T.height;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),2)=round(rand(length(D.dots_out_45_down),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_down),3)=1;
        end
    end
    
    
elseif cond == 33333 % Component In Vertical
    
    % - Adjust
    D.n_dots_plaid_down=0;
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),4)=2;
    
    % - Movement
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1);
    D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)-(D.dots_veloc_vert-1);
%     D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy45(D.dots_xy45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),1);
    D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),2)+D.dots_veloc_vert-1;
%     D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)=D.dots_xy_45(D.dots_xy_45_perm(1,D.n_dots_plaid_down+1:D.n_dots_plaid),3)+1;
    
    % - Lifetime
%     D.dots_out45=find(D.dots_xy45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out45)
%         D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
%         if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=D.dots_xy45(D.dots_out45(D.dots_out45_in),2)-D.myPointLifeJump*rand(length(D.dots_out45(D.dots_out45_in)),1)*(D.dots_veloc_vert-1);
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
%         end
%     end
%     
%     D.dots_out_45=find(D.dots_xy_45(:,3)>D.myPointLife);
%     if ~isempty(D.dots_out_45)
%         D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
%         if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)+D.myPointLifeJump*rand(length(D.dots_out_45(D.dots_out_45_in)),1)*D.dots_veloc_vert;
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
%         end
%     end
    
    % - Borders
    D.dots_out45=find((D.dots_xy45(:,1)<=0 | D.dots_xy45(:,1)>T.height) | (D.dots_xy45(:,2)<=0 | D.dots_xy45(:,2)>T.height));
    if ~isempty(D.dots_out45)
        D.dots_out45_in=find(D.dots_xy45(D.dots_out45,4)==2);
        if ~isempty(D.dots_out45_in)
%             D.dots_xy45(D.dots_out45(D.dots_out45_in),1)=round(rand(length(D.dots_out45_in),1)*(T.height-1))+1;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),2)=T.height;
            D.dots_xy45(D.dots_out45(D.dots_out45_in),3)=1;
        end
    end
    
    D.dots_out_45=find((D.dots_xy_45(:,1)<=0 | D.dots_xy_45(:,1)>T.height) | (D.dots_xy_45(:,2)<=0 | D.dots_xy_45(:,2)>T.height));
    if ~isempty(D.dots_out_45)
        D.dots_out_45_in=find(D.dots_xy_45(D.dots_out_45,4)==2);
        if ~isempty(D.dots_out_45_in)
%             D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),1)=round(rand(length(D.dots_out_45_in),1)*(T.height-1))+1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),2)=1;
            D.dots_xy_45(D.dots_out_45(D.dots_out_45_in),3)=1;
        end
    end
    
end % End if condition

end % End function