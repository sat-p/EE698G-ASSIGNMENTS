%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,T] = ICP(scan1,scan2,iters,R_init,T_init,max_tresh)
    % [R,T] = ICP (scan1, scan2, iters, R_init, T_init, max_tresh). Returns the
    % rotational matrix and translation vector which can be used to trasform
    % scan2 data to the frame from which scan1 data was taken.
    % This ICP implementaion establishes point to point correspondance based on
    % minimum euclidean distance using a naive algorithm.
    % The implementation keeps a record of previous correspondances in the
    % variable 'correspond' and exits when the correspondances do not change
    % between two consecutive iterations.
    % 
    % R : The rotational matrix
    % T : The translation vector
    
    [~, n1] = size (scan1);
    [d, n2] = size (scan2);
    
    R = R_init;
    T = T_init;
    
    X = zeros (d, n1);
    Y = zeros (d, n2);
    
    correspond = zeros (n1, 1);
    
    for it = 1 : iters
        
        % Printing iteration number
        fprintf ('The current iteration no. is : %d\n', it);
        
        %%%%%%%%%%%%%%%%%Finding Correspondances%%%%%%%%%%%%%%%%%%%%%
        % Naive algorithm can be used here to find correspondances.
        % However, a better implementation would use K-d trees to find
        % the nearest neighbours.
        
        correspond_ = zeros (n1, 1);
        
        scan2_ = R * scan2 + repmat (T, 1, n2);
        count = 0;
        
        for n = 1 : n1
            
            x = -scan1 (:, n);
            disp = scan2_ + repmat (x, 1, n2);
            dist = sqrt (sum (disp.^2, 1));
            
            [m, i] = min (dist);
            
            if m < max_tresh
                
                count = count + 1;
                
                X (:, count) = -x;
                Y (:, count) = scan2 (:, i (1));
                
                scan2_ (:, i (1)) = [inf; inf]; % Effectively removing
                                                % point chosen from
                                                % 'scan2_'
                
                correspond_ (n) = i (1);
            end
        end
        
        %%%%%%%%%%%%%%Checking if correspondances changed%%%%%%%%%%%%
        
        if isequal (correspond, correspond_)
            % Exiting loop if the correspondance did not change from
            % last iteration
            break;
        else
            % Updating correspondances.
            correspond = correspond_;
        end
        
        %%%%%%%%%%%%%%%Using SVD to estimate R and T%%%%%%%%%%%%%%%%%
        
        mu_X = mean (X (:, 1 : count), 2);
        mu_Y = mean (Y (:, 1 : count), 2);
        
        M = (X (:, 1 : count) - repmat (mu_X, 1, count)) *...
            (Y (:, 1 : count) - repmat (mu_Y, 1, count))';
        
        [U, ~, V] = svd (M);
        
        R = U * V';
        T = mu_X - R * mu_Y;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%